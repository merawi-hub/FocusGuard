import 'package:flutter_test/flutter_test.dart';
import 'package:focusguard/shared/models/platform_app.dart';

void main() {
  group('PlatformApp Model Tests', () {
    test('Calculates usage progress correctly', () {
      const app = PlatformApp(
        packageName: 'com.zhiliaoapp.musically',
        appName: 'TikTok',
        todayUsageSeconds: 1200, // 20 min
        dailyLimitSeconds: 1800, // 30 min
      );

      expect(app.usageProgress, closeTo(0.666, 0.01));
      expect(app.remainingSeconds, 600); // 10 min remaining
    });

    test('Clamps usage progress when exceeded', () {
      const app = PlatformApp(
        packageName: 'com.instagram.android',
        appName: 'Instagram',
        todayUsageSeconds: 2400, // 40 min
        dailyLimitSeconds: 1800, // 30 min
      );

      expect(app.usageProgress, 1.0);
      expect(app.remainingSeconds, 0);
    });

    test('Handles null daily limit without crash', () {
      const app = PlatformApp(
        packageName: 'com.google.android.youtube',
        appName: 'YouTube',
        todayUsageSeconds: 1500,
        dailyLimitSeconds: null,
      );

      expect(app.usageProgress, 0.0);
      expect(app.remainingSeconds, 0);
    });
  });
}

