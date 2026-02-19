import 'package:daily_grind/database/habit_database.dart';
import 'package:daily_grind/pages/home_page.dart';
import 'package:daily_grind/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.init();
  await HabitDatabase.saveFirstLaunchDate();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
