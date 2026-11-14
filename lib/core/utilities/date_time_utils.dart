class DateTimeUtils {
  static DateTime startOfDay([DateTime? date]) {
    final d = date ?? DateTime.now();
    return DateTime(d.year, d.month, d.day);
  }

  static DateTime endOfDay([DateTime? date]) {
    final d = date ?? DateTime.now();
    return DateTime(d.year, d.month, d.day, 23, 59, 59, 999);
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static List<DateTime> getDaysOfWeek([DateTime? referenceDate]) {
    final ref = referenceDate ?? DateTime.now();
    final monday = ref.subtract(Duration(days: ref.weekday - 1));
    return List.generate(7, (index) => startOfDay(monday.add(Duration(days: index))));
  }
}

