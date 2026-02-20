import 'package:daily_grind/providers/theme_provider.dart';
import 'package:daily_grind/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Center(
        child: CupertinoSwitch(
          value: ref.watch(themeProvider) == darkMode,
          onChanged: (value) {
            ref.read(themeProvider.notifier).toggleTheme();
          },
        ),
      ),
    );
  }
}
