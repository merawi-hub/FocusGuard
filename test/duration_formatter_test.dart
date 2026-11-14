import 'package:flutter_test/flutter_test.dart';
import 'package:focusguard/core/utilities/duration_formatter.dart';

void main() {
  group('DurationFormatter Tests', () {
    test('Formats seconds correctly', () {
      expect(DurationFormatter.formatSeconds(45), '45s');
      expect(DurationFormatter.formatSeconds(120), '2m');
      expect(DurationFormatter.formatSeconds(3600), '1h');
      expect(DurationFormatter.formatSeconds(3660), '1h 1m');
      expect(DurationFormatter.formatSeconds(7320), '2h 2m');
    });

    test('Formats minutes correctly', () {
      expect(DurationFormatter.formatMinutes(25), '25m');
      expect(DurationFormatter.formatMinutes(60), '1h');
      expect(DurationFormatter.formatMinutes(90), '1h 30m');
    });

    test('Formats compact digital timer', () {
      expect(DurationFormatter.formatCompact(45), '00:45');
      expect(DurationFormatter.formatCompact(125), '02:05');
      expect(DurationFormatter.formatCompact(3665), '01:01:05');
    });
  });
}

