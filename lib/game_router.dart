part of 'main.dart';

// Маршрут игры
abstract final class GameRouter {
  // Начальный маршрут
  static const String initialRoute = '/';
  // Маршрут игры
  static const String gameRoute = '/game';
  // Маршрут окончания игры
  static const String gameOverRoute = '/game_over';
  // Маршруты приложения. Объявляются приватными,
  // чтобы исключить доступ к ним вне навигатора
  static final Map<String, WidgetBuilder> _appRoutes = {
    // Стартовый экран — главное меню
    initialRoute: (_) => const MainMenuScreen(),
    // Экран игры
    gameRoute: (_) => const GameScreen(),
    // Экран окончания игры
    gameOverRoute: (_) => const GameOverScreen(),
  };
}
