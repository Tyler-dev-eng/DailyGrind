import 'package:daily_grind/models/habit.dart';
import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  const HabitTile({super.key, required this.habit});

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(habit.name));
  }
}
