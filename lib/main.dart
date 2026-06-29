// import 'package:flutter/material.dart';
// import 'tetris_game.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(body: TetrisGame()),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:tetris/app/di/depends.dart';
import 'package:tetris/app/di/di_container.dart';
import 'package:tetris/features/leaderboard/presentation/leaderboard_screen.dart';
import 'package:tetris/features/user/presentation/user_screen.dart';
import 'package:tetris/features/game/game_over_screen.dart';
import 'package:tetris/features/game/game_screen.dart';
import 'package:tetris/features/main_menu/main_menu_screen.dart';
import 'package:tetris/l10n/app_localizations.dart';
part 'app/game_router.dart';

void main() async {
  // Инициализируем Flutter binding
  WidgetsFlutterBinding.ensureInitialized();
  // Создаем экземпляр класса Depends
  final Depends depends = Depends();
  try {
    // Инициализируем зависимости
    await depends.init();
    // При успешной инициализации зависимостей запускаем приложение
    // Передаем зависимости в контейнер зависимостей
    runApp(MyApp(depends: depends));
  } on Object catch (error, stackTrace) {
    // В случае ошибки при инициализации
    // зависимостей запускаем приложение с экраном ошибки
    runApp(AppError(error: error, stackTrace: stackTrace));
  }
}

class AppError extends StatelessWidget {
  const AppError({super.key, required this.error, required this.stackTrace});
  final Object error;
  final StackTrace stackTrace;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Произошла ошибка:'),
              Text(error.toString()),
              Text(stackTrace.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({required this.depends});

  /// Передаем зависимости в приложение
  /// и используем их в контейнере зависимостей
  final Depends depends;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale _locale = const Locale('ru');
  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final storage = widget.depends.storageService;
    final localeCode = storage.getString('locale') ?? 'ru';
    setState(() {
      _locale = Locale(localeCode);
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
    _saveLocale(locale.languageCode);
  }

  Future<void> _saveLocale(String localeCode) async {
    final storage = widget.depends.storageService;
    await storage.setString('locale', localeCode);
  }

  Widget build(BuildContext context) {
    return DiContainer(
      depends: widget.depends,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: _locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: GameRouter.initialRoute,
        routes: GameRouter._appRoutes,
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return DiContainer(
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: GameRouter.initialRoute,
//         routes: GameRouter._appRoutes,
//       ),
//     );
//   }
// }
