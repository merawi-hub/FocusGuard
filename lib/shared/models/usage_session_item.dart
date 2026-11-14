class UsageSessionItem {
  final String packageName;
  final DateTime startedAt;
  final DateTime endedAt;
  final int durationSeconds;
  final String source;

  const UsageSessionItem({
    required this.packageName,
    required this.startedAt,
    required this.endedAt,
    required this.durationSeconds,
    this.source = 'usage_events',
  });

  factory UsageSessionItem.fromMap(Map<String, dynamic> map) {
    final startMillis = (map['startedAt'] as num?)?.toInt() ?? 0;
    final endMillis = (map['endedAt'] as num?)?.toInt() ?? 0;
    return UsageSessionItem(
      packageName: map['packageName'] as String? ?? '',
      startedAt: DateTime.fromMillisecondsSinceEpoch(startMillis),
      endedAt: DateTime.fromMillisecondsSinceEpoch(endMillis),
      durationSeconds: (map['durationSeconds'] as num?)?.toInt() ?? 0,
      source: map['source'] as String? ?? 'usage_events',
    );
  }
}

