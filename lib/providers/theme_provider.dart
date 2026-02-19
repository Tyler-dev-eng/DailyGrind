import 'package:daily_grind/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(lightMode);

  bool get isDarkMode => state == darkMode;

  void toggleTheme() {
    state = isDarkMode ? lightMode : darkMode;
  }

  void setTheme(ThemeData theme) {
    state = theme;
  }
}
