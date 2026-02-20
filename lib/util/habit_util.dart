bool isHabitCompletedToday(List<DateTime> completedDates) {
  final today = DateTime.now();
  return completedDates.any(
    (date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day,
  );
}
