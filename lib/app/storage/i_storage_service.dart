import 'package:tetris/features/leaderboard/domain/state/leaderboard_entity.dart';

abstract interface class IStorageService {
  /// Инициализация локального хранилища.
  /// Вызывается в самом начале приложения.
  Future<void> init();

  /// Сохранить значение по ключу.
  Future<bool> setString(String key, String value);

  /// Получить значение по ключу.
  String? getString(String key);

  /// Удалить все значения.
  Future<bool> clear();

  ///Парсинг строки
  Iterable<LeaderboardEntity> cacheParser();
}
