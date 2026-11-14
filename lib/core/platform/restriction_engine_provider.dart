import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'android_restriction_engine.dart';
import 'restriction_engine.dart';

final restrictionEngineProvider = Provider<RestrictionEngine>((ref) {
  return AndroidRestrictionEngine();
});

final permissionsStatusProvider = FutureProvider.autoDispose((ref) async {
  final engine = ref.watch(restrictionEngineProvider);
  return engine.checkAuthorizationStatus();
});

final availableAppsProvider = FutureProvider.autoDispose((ref) async {
  final engine = ref.watch(restrictionEngineProvider);
  return engine.getAvailableApplications(includeIcons: true);
});

final todayUsageStatsProvider = FutureProvider.autoDispose((ref) async {
  final engine = ref.watch(restrictionEngineProvider);
  return engine.getApplicationUsageStatistics();
});

final restrictedPackagesProvider = FutureProvider.autoDispose((ref) async {
  final engine = ref.watch(restrictionEngineProvider);
  return engine.getRestrictedPackages();
});

