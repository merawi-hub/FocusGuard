import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// Stream providers for key tables
final monitoredAppsStreamProvider = StreamProvider<List<MonitoredApp>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchAllMonitoredApps();
});

final appLimitsStreamProvider = StreamProvider<List<AppLimit>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchAllLimits();
});

final recentRestrictionEventsProvider = StreamProvider<List<RestrictionEvent>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchRecentRestrictionEvents(limit: 25);
});

final dailyRoutinesStreamProvider = StreamProvider<List<DailyRoutine>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchAllRoutines();
});

final todayUsageSessionsStreamProvider = StreamProvider<List<UsageSession>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchTodayUsageSessions();
});

final activeFocusSessionsStreamProvider = StreamProvider<List<FocusSession>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchActiveFocusSessions();
});

