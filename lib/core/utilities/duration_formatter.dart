class DurationFormatter {
  static String formatSeconds(int totalSeconds) {
    if (totalSeconds < 60) {
      return '${totalSeconds}s';
    }
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;

    if (hours > 0) {
      if (minutes > 0) {
        return '${hours}h ${minutes}m';
      }
      return '${hours}h';
    }
    return '${minutes}m';
  }

  static String formatMinutes(int totalMinutes) {
    if (totalMinutes < 60) {
      return '${totalMinutes}m';
    }
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    if (minutes > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${hours}h';
  }

  static String formatCompact(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

