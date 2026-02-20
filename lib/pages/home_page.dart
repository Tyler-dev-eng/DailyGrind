import 'package:daily_grind/components/habit_tile.dart';
import 'package:daily_grind/components/my_drawer.dart';
import 'package:daily_grind/models/habit.dart';
import 'package:daily_grind/providers/habit_provider.dart';
import 'package:daily_grind/util/habit_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

/// create a new habit
void createHabit(BuildContext context, WidgetRef ref) async {
  final controller = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Create a new habit', style: GoogleFonts.dmSerifText()),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Create a new habit',
          border: OutlineInputBorder(),
        ),
        maxLines: null,
        autofocus: true,
      ),
      actions: [
        MaterialButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            final habitName = controller.text.trim();
            if (habitName.isNotEmpty) {
              await ref.read(habitProvider.notifier).createHabit(habitName);
            }
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('Create'),
        ),
      ],
    ),
  ).then((_) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.dispose();
    });
  });
}

void onCheckboxChanged(Habit habit, bool? value, WidgetRef ref) {
  // update habit completion
  if (value != null) {
    ref.read(habitProvider.notifier).updateHabitCompletion(habit.id, value);
  }
}

// edit habit box
void editHabitBox(Habit habit, BuildContext context, WidgetRef ref) {
  // set the controller text to the habit name
  final controller = TextEditingController(text: habit.name);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Edit habit', style: GoogleFonts.dmSerifText()),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: 'Edit habit'),
      ),
      actions: [
        MaterialButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            final habitName = controller.text.trim();
            if (habitName.isNotEmpty) {
              await ref
                  .read(habitProvider.notifier)
                  .updateHabitName(habit.id, habitName);
            }
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    ),
  ).then((_) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.dispose();
    });
  });
}

// delete habit box
void deleteHabitBox(Habit habit, BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Delete habit', style: GoogleFonts.dmSerifText()),
      content: Text('Are you sure you want to delete this habit?'),
      actions: [
        MaterialButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            await ref.read(habitProvider.notifier).deleteHabit(habit.id);
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}

Widget _buildHabitList(WidgetRef ref) {
  final asyncHabits = ref.watch(habitProvider);

  return asyncHabits.when(
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (err, stack) => Center(child: Text('Error: $err')),
    data: (habits) => ListView.builder(
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final habit = habits[index];
        final isCompleted = isHabitCompletedToday(habit.completedDays);
        return HabitTile(
          habitName: habit.name,
          isCompleted: isCompleted,
          onCheckboxChanged: (value) => onCheckboxChanged(habit, value, ref),
          onEditPressed: (context) => editHabitBox(habit, context, ref),
          onDeletePressed: (context) => deleteHabitBox(habit, context, ref),
        );
      },
    ),
  );
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createHabit(context, ref),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: Colors.black),
      ),
      body: _buildHabitList(ref),
    );
  }
}
