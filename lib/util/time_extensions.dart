extension IntTime on int {
  bool get isValidHour => this < Duration.hoursPerDay && !isNegative;

  bool get isValidMinute => this < Duration.minutesPerHour && !isNegative;
}

extension Days on DateTime {
  bool isSameDayAs(DateTime b) =>
      year == b.year && month == b.month && day == b.day;

  bool isSameMonthAs(DateTime b) => year == b.year && month == b.month;

  DateTime get firstDayOfMonth => DateTime(year, month, 1);

  DateTime get lastDayOfMonth => DateTime(year, month + 1, 0);

  List<DateTime> get daysOfMonth {
    return List.generate(
        lastDayOfMonth.day, (index) => DateTime(year, month, index));
  }
}

bool isSameDay(DateTime? a, DateTime? b) {
  if (a == null || b == null) {
    return false;
  }

  return a.year == b.year && a.month == b.month && a.day == b.day;
}
