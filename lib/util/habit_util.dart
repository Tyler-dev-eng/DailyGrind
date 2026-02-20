import 'package:daily_grind/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDates) {
  final today = DateTime.now();
  return completedDates.any(
    (date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day,
  );
}

Map<DateTime, int> getHabitDatasets(List<Habit> habits) {
  Map<DateTime, int> datasets = {};

  for (var habit in habits) {
    for (var date in habit.completedDays) {
      final normalisedDate = DateTime(date.year, date.month, date.day);

      if (datasets.containsKey(normalisedDate)) {
        datasets[normalisedDate] = datasets[normalisedDate]! + 1;
      } else {
        datasets[normalisedDate] = 1;
      }
    }
  }

  return datasets;
}
