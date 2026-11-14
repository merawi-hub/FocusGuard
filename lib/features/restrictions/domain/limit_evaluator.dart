enum LimitStatus {
  normal,
  warning,
  exceeded,
}

class LimitEvaluationResult {
  final LimitStatus status;
  final int usedSeconds;
  final int limitSeconds;
  final double usageRatio;
  final int? triggeredThreshold; // e.g. 50, 80, 100
  final bool shouldRestrict;
  final bool shouldWarn;

  const LimitEvaluationResult({
    required this.status,
    required this.usedSeconds,
    required this.limitSeconds,
    required this.usageRatio,
    this.triggeredThreshold,
    required this.shouldRestrict,
    required this.shouldWarn,
  });
}

class LimitEvaluator {
  /// Evaluates application usage against configured daily limit and warning thresholds.
  /// [alreadySentThresholds] is a set of threshold percentages (e.g. {50, 80}) that have already fired today.
  static LimitEvaluationResult evaluate({
    required int usedSeconds,
    required int limitSeconds,
    List<int> thresholds = const [50, 80, 100],
    Set<int> alreadySentThresholds = const {},
  }) {
    if (limitSeconds <= 0) {
      return LimitEvaluationResult(
        status: LimitStatus.normal,
        usedSeconds: usedSeconds,
        limitSeconds: limitSeconds,
        usageRatio: 0.0,
        shouldRestrict: false,
        shouldWarn: false,
      );
    }

    final ratio = (usedSeconds / limitSeconds).clamp(0.0, 2.0);
    final percentage = (ratio * 100).floor();

    // Check if limit exceeded (100% or more)
    if (usedSeconds >= limitSeconds) {
      final shouldWarn = !alreadySentThresholds.contains(100);
      return LimitEvaluationResult(
        status: LimitStatus.exceeded,
        usedSeconds: usedSeconds,
        limitSeconds: limitSeconds,
        usageRatio: ratio,
        triggeredThreshold: 100,
        shouldRestrict: true,
        shouldWarn: shouldWarn,
      );
    }

    // Check warning thresholds in descending order
    final sortedThresholds = List<int>.from(thresholds)..sort((a, b) => b.compareTo(a));
    for (final th in sortedThresholds) {
      if (th < 100 && percentage >= th) {
        if (!alreadySentThresholds.contains(th)) {
          return LimitEvaluationResult(
            status: LimitStatus.warning,
            usedSeconds: usedSeconds,
            limitSeconds: limitSeconds,
            usageRatio: ratio,
            triggeredThreshold: th,
            shouldRestrict: false,
            shouldWarn: true,
          );
        }
        break; // Already sent this highest active threshold
      }
    }

    return LimitEvaluationResult(
      status: LimitStatus.normal,
      usedSeconds: usedSeconds,
      limitSeconds: limitSeconds,
      usageRatio: ratio,
      shouldRestrict: false,
      shouldWarn: false,
    );
  }
}

