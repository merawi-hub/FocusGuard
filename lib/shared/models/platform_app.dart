import 'dart:convert';
import 'dart:typed_data';

class PlatformApp {
  final String packageName;
  final String appName;
  final String? iconBase64;
  final int todayUsageSeconds;
  final bool isMonitored;
  final int? dailyLimitSeconds;
  final bool isRestricted;

  const PlatformApp({
    required this.packageName,
    required this.appName,
    this.iconBase64,
    this.todayUsageSeconds = 0,
    this.isMonitored = false,
    this.dailyLimitSeconds,
    this.isRestricted = false,
  });

  Uint8List? get iconBytes {
    if (iconBase64 == null || iconBase64!.isEmpty) return null;
    try {
      return base64Decode(iconBase64!);
    } catch (_) {
      return null;
    }
  }

  double get usageProgress {
    if (dailyLimitSeconds == null || dailyLimitSeconds! <= 0) return 0.0;
    return (todayUsageSeconds / dailyLimitSeconds!).clamp(0.0, 1.0);
  }

  int get remainingSeconds {
    if (dailyLimitSeconds == null) return 0;
    final remaining = dailyLimitSeconds! - todayUsageSeconds;
    return remaining > 0 ? remaining : 0;
  }

  PlatformApp copyWith({
    String? packageName,
    String? appName,
    String? iconBase64,
    int? todayUsageSeconds,
    bool? isMonitored,
    int? dailyLimitSeconds,
    bool? isRestricted,
  }) {
    return PlatformApp(
      packageName: packageName ?? this.packageName,
      appName: appName ?? this.appName,
      iconBase64: iconBase64 ?? this.iconBase64,
      todayUsageSeconds: todayUsageSeconds ?? this.todayUsageSeconds,
      isMonitored: isMonitored ?? this.isMonitored,
      dailyLimitSeconds: dailyLimitSeconds ?? this.dailyLimitSeconds,
      isRestricted: isRestricted ?? this.isRestricted,
    );
  }

  factory PlatformApp.fromMap(Map<String, dynamic> map) {
    return PlatformApp(
      packageName: map['packageName'] as String,
      appName: map['appName'] as String,
      iconBase64: map['iconBase64'] as String?,
      todayUsageSeconds: (map['todayUsageSeconds'] as num?)?.toInt() ?? 0,
      isMonitored: map['isMonitored'] as bool? ?? false,
      dailyLimitSeconds: (map['dailyLimitSeconds'] as num?)?.toInt(),
      isRestricted: map['isRestricted'] as bool? ?? false,
    );
  }
}

