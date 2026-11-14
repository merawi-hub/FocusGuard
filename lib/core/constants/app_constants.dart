class AppConstants {
  static const String appName = 'FocusGuard';
  static const String appTagline = 'Digital Wellbeing & Distraction Defense';
  static const String appVersion = '1.0.0';

  // Default values
  static const int defaultEmergencyUnlockMinutes = 10;
  static const int defaultDailyGoalMinutes = 120;
  static const List<int> defaultWarningThresholds = [50, 80, 100];

  // Channel
  static const String methodChannelName = 'com.focusguard.app/restrictions';

  // Storage keys
  static const String keyFirstLaunch = 'focusguard_first_launch_done';
  static const String keyThemeMode = 'focusguard_theme_mode';
  static const String keyEmergencyUnlockDuration = 'focusguard_emergency_duration';
  static const String keyDailyResetHour = 'focusguard_reset_hour';
}

