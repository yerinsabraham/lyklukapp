String getDuration({required DateTime startDate, required DateTime endDate}) {
  Duration duration = endDate.difference(startDate);

  // ${duration.inHours.remainder(24)} hours, ${duration.inMinutes.remainder(60)} minutes
  final day = duration.inDays <= 1 ? "day" : "days";
  return '${duration.inDays} $day';
}

int getDurationInNumber({
  required DateTime startDate,
  required DateTime endDate,
}) {
  Duration duration = endDate.difference(startDate);

  // ${duration.inHours.remainder(24)} hours, ${duration.inMinutes.remainder(60)} minutes
  return duration.inDays;
}

/// get duration from timestamp
int getDurationFromTimestamp({required int start, required int end}) {
  DateTime startDate = DateTime.fromMillisecondsSinceEpoch(start);
  DateTime endDate = DateTime.fromMillisecondsSinceEpoch(end);
  Duration duration = endDate.difference(startDate);

  // ${duration.inHours.remainder(24)} hours, ${duration.inMinutes.remainder(60)} minutes
  return duration.inDays;
}

num div(num up, num down) {
  if (up == 0 || down == 0) return 0;
  return up / down;
}
