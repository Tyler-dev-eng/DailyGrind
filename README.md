# Daily Grind

A Flutter habit-tracking app to build and visualize your daily routines. Track habits, mark completions, and see your consistency over time with a heat map calendar.

## Features

- **Create & manage habits** — Add habits by name, edit them, or remove them with swipe actions
- **Daily check-ins** — Mark habits as done for today with a single tap
- **Heat map calendar** — See your completion history at a glance (GitHub-style activity view)
- **Light & dark theme** — Toggle app theme from the drawer
- **Local-first** — All data stored on device with [Isar](https://isar.dev); no account or sync required

## Screenshots

![Daily Grind — home screen with date selector, habit list, and FAB](screenshots/home.png)

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (SDK ^3.11.0)
- A device or emulator (iOS, Android, or desktop)

### Run the app

```bash
# Install dependencies
flutter pub get

# Generate Isar code (if you change models)
dart run build_runner build

# Run
flutter run
```

### Project structure

```
lib/
├── main.dart              # App entry, DB init, theme
├── database/              # Isar persistence (habit_database.dart)
├── models/                # Habit, AppSettings (Isar collections)
├── providers/             # Riverpod (habit_provider, theme_provider)
├── pages/                 # HomePage and habit UI logic
├── components/            # HabitTile, HeatMap, MyDrawer
├── theme/                 # App theme definitions
└── util/                  # Helpers (e.g. habit_util)
```

## Tech stack

| Area            | Choice              |
|-----------------|---------------------|
| State           | [flutter_riverpod](https://riverpod.dev) |
| Local database  | [Isar](https://isar.dev)                 |
| UI              | Material Design, [Google Fonts](https://pub.dev/packages/google_fonts) |
| Heat map        | [flutter_heatmap_calendar](https://pub.dev/packages/flutter_heatmap_calendar) |
| Swipe actions   | [flutter_slidable](https://pub.dev/packages/flutter_slidable) |

## Learn more

- [Flutter documentation](https://docs.flutter.dev/)
- [Riverpod](https://riverpod.dev)
- [Isar](https://isar.dev)
