class PlatformPermissionsStatus {
  final bool hasUsageStats;
  final bool hasOverlay;
  final bool hasAccessibility;
  final bool hasNotifications;

  const PlatformPermissionsStatus({
    required this.hasUsageStats,
    required this.hasOverlay,
    required this.hasAccessibility,
    required this.hasNotifications,
  });

  bool get isFullyAuthorized =>
      hasUsageStats && hasOverlay && hasAccessibility && hasNotifications;

  bool get canMonitorUsage => hasUsageStats;
  bool get canEnforceRestrictions => hasOverlay && hasAccessibility;

  factory PlatformPermissionsStatus.fromMap(Map<dynamic, dynamic> map) {
    return PlatformPermissionsStatus(
      hasUsageStats: map['usageStats'] as bool? ?? false,
      hasOverlay: map['overlay'] as bool? ?? false,
      hasAccessibility: map['accessibility'] as bool? ?? false,
      hasNotifications: map['notifications'] as bool? ?? false,
    );
  }

  factory PlatformPermissionsStatus.allDenied() {
    return const PlatformPermissionsStatus(
      hasUsageStats: false,
      hasOverlay: false,
      hasAccessibility: false,
      hasNotifications: false,
    );
  }
}

