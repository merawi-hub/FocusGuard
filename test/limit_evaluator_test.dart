import 'package:flutter_test/flutter_test.dart';
import 'package:focusguard/features/restrictions/domain/limit_evaluator.dart';

void main() {
  group('LimitEvaluator Tests', () {
    const limitSeconds = 1800; // 30 minutes

    test('Returns normal status when usage is below all thresholds', () {
      final res = LimitEvaluator.evaluate(
        usedSeconds: 600, // 10 minutes (33%)
        limitSeconds: limitSeconds,
      );

      expect(res.status, LimitStatus.normal);
      expect(res.shouldRestrict, isFalse);
      expect(res.shouldWarn, isFalse);
      expect(res.triggeredThreshold, isNull);
    });

    test('Triggers 50% warning at exactly half usage', () {
      final res = LimitEvaluator.evaluate(
        usedSeconds: 900, // 15 minutes (50%)
        limitSeconds: limitSeconds,
      );

      expect(res.status, LimitStatus.warning);
      expect(res.shouldWarn, isTrue);
      expect(res.shouldRestrict, isFalse);
      expect(res.triggeredThreshold, 50);
    });

    test('Does not re-trigger 50% warning if already sent', () {
      final res = LimitEvaluator.evaluate(
        usedSeconds: 1000, // ~55%
        limitSeconds: limitSeconds,
        alreadySentThresholds: {50},
      );

      expect(res.status, LimitStatus.normal);
      expect(res.shouldWarn, isFalse);
      expect(res.shouldRestrict, isFalse);
    });

    test('Triggers 80% warning at 24 minutes', () {
      final res = LimitEvaluator.evaluate(
        usedSeconds: 1440, // 24 minutes (80%)
        limitSeconds: limitSeconds,
        alreadySentThresholds: {50},
      );

      expect(res.status, LimitStatus.warning);
      expect(res.shouldWarn, isTrue);
      expect(res.shouldRestrict, isFalse);
      expect(res.triggeredThreshold, 80);
    });

    test('Restricts application when limit is reached (100%)', () {
      final res = LimitEvaluator.evaluate(
        usedSeconds: 1800, // 30 minutes (100%)
        limitSeconds: limitSeconds,
        alreadySentThresholds: {50, 80},
      );

      expect(res.status, LimitStatus.exceeded);
      expect(res.shouldRestrict, isTrue);
      expect(res.shouldWarn, isTrue);
      expect(res.triggeredThreshold, 100);
    });

    test('Enforces restriction when usage exceeds limit even if already warned', () {
      final res = LimitEvaluator.evaluate(
        usedSeconds: 2100, // 35 minutes
        limitSeconds: limitSeconds,
        alreadySentThresholds: {50, 80, 100},
      );

      expect(res.status, LimitStatus.exceeded);
      expect(res.shouldRestrict, isTrue);
      expect(res.shouldWarn, isFalse); // warning already sent
    });

    test('Handles zero or negative limit seconds gracefully', () {
      final res = LimitEvaluator.evaluate(
        usedSeconds: 500,
        limitSeconds: 0,
      );

      expect(res.status, LimitStatus.normal);
      expect(res.shouldRestrict, isFalse);
      expect(res.shouldWarn, isFalse);
    });
  });
}

