import 'package:flutter/services.dart';
import '../constants/app_constants.dart';
import '../../shared/models/permission_status.dart';
import '../../shared/models/platform_app.dart';
import '../../shared/models/usage_session_item.dart';
import 'restriction_engine.dart';

class AndroidRestrictionEngine implements RestrictionEngine {
  final MethodChannel _channel = const MethodChannel(AppConstants.methodChannelName);

  @override
  Future<PlatformPermissionsStatus> checkAuthorizationStatus() async {
    try {
      final dynamic result = await _channel.invokeMethod('checkPermissions');
      if (result is Map) {
        return PlatformPermissionsStatus.fromMap(result);
      }
      return PlatformPermissionsStatus.allDenied();
    } catch (_) {
      return PlatformPermissionsStatus.allDenied();
    }
  }

  @override
  Future<bool> requestUsageAuthorization() async {
    try {
      final bool? res = await _channel.invokeMethod('requestUsagePermission');
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> requestOverlayAuthorization() async {
    try {
      final bool? res = await _channel.invokeMethod('requestOverlayPermission');
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> requestAccessibilityAuthorization() async {
    try {
      final bool? res = await _channel.invokeMethod('requestAccessibilityPermission');
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> requestNotificationAuthorization() async {
    try {
      final bool? res = await _channel.invokeMethod('requestNotificationPermission');
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<PlatformApp>> getAvailableApplications({bool includeIcons = true}) async {
    try {
      final dynamic result = await _channel.invokeMethod('getInstalledApps', {
        'includeIcons': includeIcons,
      });

      if (result is List) {
        return result.map((item) {
          final map = Map<String, dynamic>.from(item as Map);
          return PlatformApp(
            packageName: map['packageName'] as String? ?? '',
            appName: map['appName'] as String? ?? '',
            iconBase64: map['iconBase64'] as String?,
          );
        }).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  @override
  Future<Map<String, int>> getApplicationUsageStatistics({List<String>? packageNames}) async {
    try {
      final dynamic result = await _channel.invokeMethod('getTodayUsage', {
        'packages': packageNames,
      });

      final Map<String, int> usage = {};
      if (result is List) {
        for (final item in result) {
          if (item is Map) {
            final pkg = item['packageName'] as String? ?? '';
            final duration = (item['durationSeconds'] as num?)?.toInt() ?? 0;
            if (pkg.isNotEmpty) {
              usage[pkg] = duration;
            }
          }
        }
      }
      return usage;
    } catch (_) {
      return {};
    }
  }

  @override
  Future<List<UsageSessionItem>> getUsageSessions({
    required DateTime startTime,
    required DateTime endTime,
    List<String>? packageNames,
  }) async {
    try {
      final dynamic result = await _channel.invokeMethod('getUsageSessions', {
        'startTime': startTime.millisecondsSinceEpoch,
        'endTime': endTime.millisecondsSinceEpoch,
        'packages': packageNames,
      });

      if (result is List) {
        return result.map((item) {
          final map = Map<String, dynamic>.from(item as Map);
          return UsageSessionItem.fromMap(map);
        }).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  @override
  Future<bool> setMonitoredPackages(List<String> packageNames, Map<String, int> limits) async {
    try {
      final bool? res = await _channel.invokeMethod('setMonitoredPackages', {
        'packages': packageNames,
        'limits': limits,
      });
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> schedulePeriodicMonitoring() async {
    try {
      final bool? res = await _channel.invokeMethod('schedulePeriodicMonitoring');
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> applyApplicationRestrictions(List<String> packageNames) async {
    try {
      final bool? res = await _channel.invokeMethod('setAppRestrictions', {
        'packages': packageNames,
      });
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> addApplicationRestriction(String packageName, {int limitSeconds = 0}) async {
    try {
      final bool? res = await _channel.invokeMethod('addAppRestriction', {
        'packageName': packageName,
        'limitSeconds': limitSeconds,
      });
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> removeApplicationRestriction(String packageName) async {
    try {
      final bool? res = await _channel.invokeMethod('removeAppRestriction', {
        'packageName': packageName,
      });
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<String>> getRestrictedPackages() async {
    try {
      final dynamic result = await _channel.invokeMethod('getRestrictedPackages');
      if (result is List) {
        return result.map((e) => e.toString()).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>> requestEmergencyUnlock(
    String packageName, {
    int durationMinutes = 10,
  }) async {
    try {
      final dynamic result = await _channel.invokeMethod('requestEmergencyUnlock', {
        'packageName': packageName,
        'durationMinutes': durationMinutes,
      });
      if (result is Map) {
        return Map<String, dynamic>.from(result);
      }
      return {'unlocked': false};
    } catch (_) {
      return {'unlocked': false};
    }
  }

  @override
  Future<Map<String, dynamic>> getEmergencyUnlockStatus(String packageName) async {
    try {
      final dynamic result = await _channel.invokeMethod('getEmergencyUnlockStatus', {
        'packageName': packageName,
      });
      if (result is Map) {
        return Map<String, dynamic>.from(result);
      }
      return {'isUnlocked': false, 'remainingSeconds': 0};
    } catch (_) {
      return {'isUnlocked': false, 'remainingSeconds': 0};
    }
  }

  @override
  Future<bool> sendWarningNotification({
    required String packageName,
    required String appName,
    required int percentage,
    required int usedMinutes,
    required int limitMinutes,
  }) async {
    try {
      final bool? res = await _channel.invokeMethod('sendWarningNotification', {
        'packageName': packageName,
        'appName': appName,
        'percentage': percentage,
        'usedMinutes': usedMinutes,
        'limitMinutes': limitMinutes,
      });
      return res ?? false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> sendRestrictionNotification({
    required String packageName,
    required String appName,
    required int limitMinutes,
  }) async {
    try {
      final bool? res = await _channel.invokeMethod('sendRestrictionNotification', {
        'packageName': packageName,
        'appName': appName,
        'limitMinutes': limitMinutes,
      });
      return res ?? false;
    } catch (_) {
      return false;
    }
  }
}
