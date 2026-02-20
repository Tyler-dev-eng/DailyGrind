import 'dart:async';

import 'package:daily_grind/database/habit_database.dart';
import 'package:daily_grind/models/habit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider = "Give me an instance of HabitDatabase"
final habitDatabaseProvider = Provider<HabitDatabase>((ref) => HabitDatabase());

final habitProvider = AsyncNotifierProvider<HabitNotifier, List<Habit>>(
  HabitNotifier.new,
);

class HabitNotifier extends AsyncNotifier<List<Habit>> {
  @override
  FutureOr<List<Habit>> build() {
    final db = ref.read(habitDatabaseProvider);
    return db.readHabits();
  }

  Future<void> createHabit(String habitName) async {
    final db = ref.read(habitDatabaseProvider);
    await db.createHabit(habitName);
    state = const AsyncValue.loading();
    state = AsyncValue.data(await db.readHabits());
  }

  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    final db = ref.read(habitDatabaseProvider);
    await db.updateHabitCompletion(id, isCompleted);
    state = const AsyncValue.loading();
    state = AsyncValue.data(await db.readHabits());
  }

  Future<void> updateHabitName(int id, String newName) async {
    final db = ref.read(habitDatabaseProvider);
    await db.updateHabitName(id, newName);
    state = const AsyncValue.loading();
    state = AsyncValue.data(await db.readHabits());
  }

  Future<void> deleteHabit(int id) async {
    final db = ref.read(habitDatabaseProvider);
    await db.deleteHabit(id);
    state = const AsyncValue.loading();
    state = AsyncValue.data(await db.readHabits());
  }
}
