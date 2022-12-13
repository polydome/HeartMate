abstract class ScheduleRepository {
  int? getScheduleIdForDay(DateTime dateTime);

  double getDosageForDay(int scheduleId, DateTime dateTime);

  bool scheduleWithinPeriodExists(DateTime periodStart, DateTime periodEnd);

  List<int> findScheduleIdsWithinPeriod();

  void updateScheduleEndDate(int scheduleId, DateTime startDate);

  void createSchedule(
      {required DateTime startDate,
      required DateTime endDate,
      required List<double> dosageCycle});
}
