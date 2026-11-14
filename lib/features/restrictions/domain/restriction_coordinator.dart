import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../../core/platform/restriction_engine.dart';
import 'limit_evaluator.dart';

class RestrictionCoordinator {
  final AppDatabase database;
  final RestrictionEngine engine;

  // Track sent warnings per package for today: Map<packageName, Set<thresholdPercentage>>
  final Map<String, Set<int>> _sentWarningsToday = {};
  DateTime _lastResetDate = DateTime.now();

  RestrictionCoordinator({
    required this.database,
    required this.engine,
  });

  void _checkDailyReset() {
    final now = DateTime.now();
    if (now.day != _lastResetDate.day ||
        now.month != _lastResetDate.month ||
        now.year != _lastResetDate.year) {
      _sentWarningsToday.clear();
      _lastResetDate = now;
    }
  }

  Future<void> evaluateAndEnforce() async {
    _checkDailyReset();

    final monitoredApps = await database.getAllMonitoredApps();
    if (monitoredApps.isEmpty) return;

    final monitoredPackages = monitoredApps
        .where((a) => a.isMonitored)
        .map((a) => a.platformAppId)
        .toList();

    if (monitoredPackages.isEmpty) return;

    final usageStats = await engine.getApplicationUsageStatistics(
      packageNames: monitoredPackages,
    );

    for (final app in monitoredApps) {
      if (!app.isMonitored) continue;

      final limit = await database.getLimitForApp(app.id);
      if (limit == null || !limit.isEnabled || limit.dailyLimitSeconds <= 0) {
        continue;
      }

      final usedSeconds = usageStats[app.platformAppId] ?? 0;
      final sentThresholds = _sentWarningsToday[app.platformAppId] ?? {};

      // Parse thresholds list (default: [50, 80, 100])
      final thresholds = [50, 80, 100];

      final evaluation = LimitEvaluator.evaluate(
        usedSeconds: usedSeconds,
        limitSeconds: limit.dailyLimitSeconds,
        thresholds: thresholds,
        alreadySentThresholds: sentThresholds,
      );

      // Record summary in local database
      await database.upsertDailySummary(
        DailyUsageSummariesCompanion(
          monitoredAppId: Value(app.id),
          usageDate: Value(DateTime(
            _lastResetDate.year,
            _lastResetDate.month,
            _lastResetDate.day,
          )),
          totalDurationSeconds: Value(usedSeconds),
        ),
      );

      if (evaluation.shouldRestrict) {
        // Enforce restriction natively
        await engine.addApplicationRestriction(
          app.platformAppId,
          limitSeconds: limit.dailyLimitSeconds,
        );

        if (evaluation.shouldWarn) {
          sentThresholds.add(100);
          _sentWarningsToday[app.platformAppId] = sentThresholds;

          await engine.sendRestrictionNotification(
            packageName: app.platformAppId,
            appName: app.appName,
            limitMinutes: limit.dailyLimitSeconds ~/ 60,
          );

          await database.logRestrictionEvent(
            RestrictionEventsCompanion(
              monitoredAppId: Value(app.id),
              eventType: const Value('restriction_enforced'),
              details: Value('Usage reached ${usedSeconds ~/ 60}m / ${limit.dailyLimitSeconds ~/ 60}m'),
            ),
          );
        }
      } else if (evaluation.shouldWarn && evaluation.triggeredThreshold != null) {
        final th = evaluation.triggeredThreshold!;
        sentThresholds.add(th);
        _sentWarningsToday[app.platformAppId] = sentThresholds;

        await engine.sendWarningNotification(
          packageName: app.platformAppId,
          appName: app.appName,
          percentage: th,
          usedMinutes: usedSeconds ~/ 60,
          limitMinutes: limit.dailyLimitSeconds ~/ 60,
        );

        await database.logRestrictionEvent(
          RestrictionEventsCompanion(
            monitoredAppId: Value(app.id),
            eventType: const Value('warning_sent'),
            details: Value('$th% threshold warning triggered'),
          ),
        );
      }
    }
  }

  Future<bool> requestEmergencyUnlock({
    required int monitoredAppId,
    required String packageName,
    required String reason,
    int durationMinutes = 10,
  }) async {
    final res = await engine.requestEmergencyUnlock(
      packageName,
      durationMinutes: durationMinutes,
    );

    final success = res['unlocked'] as bool? ?? false;
    if (success) {
      final now = DateTime.now();
      final expiresAt = now.add(Duration(minutes: durationMinutes));

      await database.insertEmergencyUnlock(
        EmergencyUnlocksCompanion(
          monitoredAppId: Value(monitoredAppId),
          requestedAt: Value(now),
          expiresAt: Value(expiresAt),
          reason: Value(reason),
          status: const Value('active'),
        ),
      );

      await database.logRestrictionEvent(
        RestrictionEventsCompanion(
          monitoredAppId: Value(monitoredAppId),
          eventType: const Value('emergency_unlocked'),
          details: Value('Emergency unlock for $durationMinutes minutes. Reason: $reason'),
        ),
      );
      return true;
    }
    return false;
  }
}

