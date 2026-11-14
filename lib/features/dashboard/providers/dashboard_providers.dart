import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/platform/restriction_engine_provider.dart';
import '../../../shared/models/platform_app.dart';

class DashboardStats {
  final int totalScreenTimeSeconds;
  final int totalDailyLimitSeconds;
  final int remainingAllowedSeconds;
  final int monitoredAppsCount;
  final int restrictedAppsCount;
  final List<PlatformApp> mostUsedApps;

  const DashboardStats({
    required this.totalScreenTimeSeconds,
    required this.totalDailyLimitSeconds,
    required this.remainingAllowedSeconds,
    required this.monitoredAppsCount,
    required this.restrictedAppsCount,
    required this.mostUsedApps,
  });
}

final dashboardStatsProvider = FutureProvider.autoDispose<DashboardStats>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  final engine = ref.watch(restrictionEngineProvider);

  final monitoredApps = await db.getAllMonitoredApps();
  final limits = await db.watchAllLimits().first;
  final restrictedPackages = await engine.getRestrictedPackages();

  final packageList = monitoredApps.map((a) => a.platformAppId).toList();
  final usageMap = await engine.getApplicationUsageStatistics(
    packageNames: packageList.isEmpty ? null : packageList,
  );

  int totalUsed = 0;
  int totalLimit = 0;
  final List<PlatformApp> appList = [];

  for (final app in monitoredApps) {
    final used = usageMap[app.platformAppId] ?? 0;
    final limit = limits.where((l) => l.monitoredAppId == app.id).firstOrNull;
    final isRestricted = restrictedPackages.contains(app.platformAppId);

    totalUsed += used;
    if (limit != null && limit.isEnabled) {
      totalLimit += limit.dailyLimitSeconds;
    }

    appList.add(
      PlatformApp(
        packageName: app.platformAppId,
        appName: app.appName,
        iconBase64: app.iconReference,
        todayUsageSeconds: used,
        isMonitored: app.isMonitored,
        dailyLimitSeconds: limit?.dailyLimitSeconds,
        isRestricted: isRestricted,
      ),
    );
  }

  appList.sort((a, b) => b.todayUsageSeconds.compareTo(a.todayUsageSeconds));

  final remaining = (totalLimit - totalUsed).clamp(0, double.infinity).toInt();

  return DashboardStats(
    totalScreenTimeSeconds: totalUsed,
    totalDailyLimitSeconds: totalLimit,
    remainingAllowedSeconds: remaining,
    monitoredAppsCount: monitoredApps.where((a) => a.isMonitored).length,
    restrictedAppsCount: restrictedPackages.length,
    mostUsedApps: appList,
  );
});

