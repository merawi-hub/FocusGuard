import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/monitored_apps_table.dart';
import 'tables/app_limits_table.dart';
import 'tables/usage_sessions_table.dart';
import 'tables/daily_usage_summaries_table.dart';
import 'tables/focus_sessions_table.dart';
import 'tables/daily_goals_table.dart';
import 'tables/restriction_events_table.dart';
import 'tables/emergency_unlocks_table.dart';
import 'tables/daily_routines_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  MonitoredApps,
  AppLimits,
  UsageSessions,
  DailyUsageSummaries,
  FocusSessions,
  DailyGoals,
  RestrictionEvents,
  EmergencyUnlocks,
  DailyRoutines,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'focusguard_db');
  }

  // --- Monitored Apps Queries ---
  Stream<List<MonitoredApp>> watchAllMonitoredApps() =>
      select(monitoredApps).watch();

  Future<List<MonitoredApp>> getAllMonitoredApps() =>
      select(monitoredApps).get();

  Future<MonitoredApp?> getMonitoredAppByPackage(String packageName) =>
      (select(monitoredApps)..where((tbl) => tbl.platformAppId.equals(packageName)))
          .getSingleOrNull();

  Future<int> insertMonitoredApp(MonitoredAppsCompanion app) =>
      into(monitoredApps).insertOnConflictUpdate(app);

  Future<bool> updateMonitoredApp(MonitoredApp app) =>
      update(monitoredApps).replace(app);

  Future<int> deleteMonitoredApp(int id) =>
      (delete(monitoredApps)..where((tbl) => tbl.id.equals(id))).go();

  // --- App Limits Queries ---
  Stream<List<AppLimit>> watchAllLimits() => select(appLimits).watch();

  Future<AppLimit?> getLimitForApp(int monitoredAppId) =>
      (select(appLimits)..where((tbl) => tbl.monitoredAppId.equals(monitoredAppId)))
          .getSingleOrNull();

  Future<int> upsertLimit(AppLimitsCompanion limit) =>
      into(appLimits).insertOnConflictUpdate(limit);

  // --- Usage Sessions & Summaries ---
  Future<int> insertUsageSession(UsageSessionsCompanion session) =>
      into(usageSessions).insert(session);

  Stream<List<UsageSession>> watchTodayUsageSessions() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    return (select(usageSessions)
          ..where((tbl) => tbl.startedAt.isBiggerOrEqualValue(startOfDay))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.startedAt)]))
        .watch();
  }

  Future<int> upsertDailySummary(DailyUsageSummariesCompanion summary) =>
      into(dailyUsageSummaries).insertOnConflictUpdate(summary);

  Stream<List<DailyUsageSummary>> watchDailySummariesForDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    return (select(dailyUsageSummaries)
          ..where((tbl) =>
              tbl.usageDate.isBiggerOrEqualValue(startOfDay) &
              tbl.usageDate.isSmallerOrEqualValue(endOfDay)))
        .watch();
  }

  // --- Focus Sessions ---
  Stream<List<FocusSession>> watchActiveFocusSessions() =>
      (select(focusSessions)..where((tbl) => tbl.status.equals('active'))).watch();

  Future<int> insertFocusSession(FocusSessionsCompanion session) =>
      into(focusSessions).insert(session);

  Future<bool> updateFocusSession(FocusSession session) =>
      update(focusSessions).replace(session);

  // --- Daily Goals ---
  Stream<List<DailyGoal>> watchGoalsForToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return (select(dailyGoals)..where((tbl) => tbl.goalDate.equals(today))).watch();
  }

  Future<int> insertGoal(DailyGoalsCompanion goal) => into(dailyGoals).insert(goal);

  // --- Restriction Events ---
  Future<int> logRestrictionEvent(RestrictionEventsCompanion event) =>
      into(restrictionEvents).insert(event);

  Stream<List<RestrictionEvent>> watchRecentRestrictionEvents({int limit = 20}) =>
      (select(restrictionEvents)
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.occurredAt)])
            ..limit(limit))
          .watch();

  // --- Emergency Unlocks ---
  Future<int> insertEmergencyUnlock(EmergencyUnlocksCompanion unlock) =>
      into(emergencyUnlocks).insert(unlock);

  Future<EmergencyUnlock?> getActiveEmergencyUnlock(int monitoredAppId) {
    final now = DateTime.now();
    return (select(emergencyUnlocks)
          ..where((tbl) =>
              tbl.monitoredAppId.equals(monitoredAppId) &
              tbl.status.equals('active') &
              tbl.expiresAt.isBiggerThanValue(now)))
        .getSingleOrNull();
  }

  // --- Daily Routines ---
  Stream<List<DailyRoutine>> watchAllRoutines() => select(dailyRoutines).watch();

  Future<int> insertRoutine(DailyRoutinesCompanion routine) =>
      into(dailyRoutines).insert(routine);

  Future<bool> updateRoutine(DailyRoutine routine) =>
      update(dailyRoutines).replace(routine);

  Future<int> deleteRoutine(int id) =>
      (delete(dailyRoutines)..where((tbl) => tbl.id.equals(id))).go();
}

