import 'package:flutter_test/flutter_test.dart';
import 'package:focusguard/shared/models/usage_session_item.dart';

void main() {
  group('UsageSessionItem Model Tests', () {
    test('Correctly parses map from native UsageEvents bridge', () {
      final nowMillis = DateTime.now().millisecondsSinceEpoch;
      final startMillis = nowMillis - (15 * 60 * 1000); // 15 mins ago

      final session = UsageSessionItem.fromMap({
        'packageName': 'com.zhiliaoapp.musically',
        'startedAt': startMillis,
        'endedAt': nowMillis,
        'durationSeconds': 900,
        'source': 'usage_events',
      });

      expect(session.packageName, 'com.zhiliaoapp.musically');
      expect(session.durationSeconds, 900);
      expect(session.source, 'usage_events');
      expect(session.startedAt.millisecondsSinceEpoch, startMillis);
      expect(session.endedAt.millisecondsSinceEpoch, nowMillis);
    });

    test('Handles missing or null attributes gracefully with defaults', () {
      final session = UsageSessionItem.fromMap({});

      expect(session.packageName, '');
      expect(session.durationSeconds, 0);
      expect(session.source, 'usage_events');
      expect(session.startedAt.millisecondsSinceEpoch, 0);
    });
  });
}

