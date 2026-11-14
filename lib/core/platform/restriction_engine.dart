import '../../shared/models/permission_status.dart';
import '../../shared/models/platform_app.dart';
import '../../shared/models/usage_session_item.dart';

abstract class RestrictionEngine {
  /// Check current status of required permissions
  Future<PlatformPermissionsStatus> checkAuthorizationStatus();

  /// Request Usage Access permission
  Future<bool> requestUsageAuthorization();

  /// Request Overlay (Draw over other apps) permission
  Future<bool> requestOverlayAuthorization();

  /// Request Accessibility Service permission
  Future<bool> requestAccessibilityAuthorization();

  /// Request Notification permission
  Future<bool> requestNotificationAuthorization();

  /// Retrieve installed user-facing applications
  Future<List<PlatformApp>> getAvailableApplications({bool includeIcons = true});

  /// Retrieve today's usage statistics in seconds mapped by package name
  Future<Map<String, int>> getApplicationUsageStatistics({List<String>? packageNames});

  /// Retrieve precise session intervals from UsageEvents
  Future<List<UsageSessionItem>> getUsageSessions({
    required DateTime startTime,
    required DateTime endTime,
    List<String>? packageNames,
  });

  /// Synchronize monitored packages and configured limits to native background services
  Future<bool> setMonitoredPackages(List<String> packageNames, Map<String, int> limits);

  /// Schedule periodic background WorkManager monitoring
  Future<bool> schedulePeriodicMonitoring();

  /// Apply restrictions to a batch of package names
  Future<bool> applyApplicationRestrictions(List<String> packageNames);

  /// Add restriction to a specific package
  Future<bool> addApplicationRestriction(String packageName, {int limitSeconds = 0});

  /// Remove restriction from a specific package
  Future<bool> removeApplicationRestriction(String packageName);

  /// Get list of currently restricted packages
  Future<List<String>> getRestrictedPackages();

  /// Request emergency unlock for a restricted app
  Future<Map<String, dynamic>> requestEmergencyUnlock(
    String packageName, {
    int durationMinutes = 10,
  });

  /// Get emergency unlock status and remaining time for a package
  Future<Map<String, dynamic>> getEmergencyUnlockStatus(String packageName);

  /// Send usage threshold warning notification (e.g. 50%, 80%)
  Future<bool> sendWarningNotification({
    required String packageName,
    required String appName,
    required int percentage,
    required int usedMinutes,
    required int limitMinutes,
  });

  /// Send limit reached restriction notification
  Future<bool> sendRestrictionNotification({
    required String packageName,
    required String appName,
    required int limitMinutes,
  });
}
