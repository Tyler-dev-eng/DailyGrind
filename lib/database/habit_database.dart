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

  /// Read a habit.

  /// Update a habit.

  /// Delete a habit.
}
