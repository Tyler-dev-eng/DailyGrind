import 'package:daily_grind/models/app_settings.dart';
import 'package:daily_grind/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

/// Talks to Isar. It does not know the UI or Riverpod. It only reads/writes to the database.

class HabitDatabase {
  /// The Isar instance.
  static late Isar isar;

  /// Initialises the database. Call once before using (e.g. in main).
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([
      HabitSchema,
      AppSettingsSchema,
    ], directory: dir.path);
  }

  /// Save first date of app start up (for heat map).
  static Future<void> saveFirstLaunchDate() async {
    final existingAppSettings = await isar.appSettings.where().findFirst();
    if (existingAppSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  /// Get first date of app start up (for heat map).
  static Future<DateTime?> getFirstLaunchDate() async {
    final existingAppSettings = await isar.appSettings.where().findFirst();
    return existingAppSettings?.firstLaunchDate;
  }

  /// List of all habits.
  static Future<List<Habit>> getHabits() async {
    return await isar.habits.where().findAll();
  }

  /// Add a new habit.
  final List<Habit> habits = [];

  /// Create a new habit.
  Future<void> createHabit(String habitName) async {
    final newHabit = Habit()..name = habitName;
    await isar.writeTxn(() => isar.habits.put(newHabit));
  }

  /// Read a habit.
  Future<List<Habit>> readHabits() async {
    return await isar.habits.where().findAll();
  }

  /// Update a habit. (check habit on or off)
  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    // find the habit by id
    final habit = await isar.habits.get(id);

    // if the habit is found, update the completion status
    if (habit != null) {
      await isar.writeTxn(() async {
        // if habit is completed, add the current date to the completedDates list
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          // today
          final today = DateTime.now();

          // add the current date to the completedDates list
          habit.completedDays.add(DateTime(today.year, today.month, today.day));
        }
        // else remove the current date from the completedDates list
        else {
          // remove the current date if the habit is marked as incomplete
          habit.completedDays.removeWhere(
            (date) =>
                date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day,
          );
        }

        // save the habit
        await isar.habits.put(habit);
      });
    }
  }

  /// Update a habit. (edit habit name)
  Future<void> updateHabitName(int id, String newName) async {
    // find the specific habit by id
    final habit = await isar.habits.get(id);

    // if the habit is found, update the name
    if (habit != null) {
      await isar.writeTxn(() async {
        habit.name = newName;
        await isar.habits.put(habit);
      });
    }
  }

  /// Delete a habit.
  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });
  }
}
