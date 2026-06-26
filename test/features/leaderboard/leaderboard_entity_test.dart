import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/features/leaderboard/domain/state/leaderboard_entity.dart';

Future<void> main() async {
  group('Тестирование LeaderboardEntity', () {
    test('Проверка правильного сравнения LeaderboardEntity', () {
      // Подготовка и действие
      // Создание двух одинаковых объектов LeaderboardEntity
      const dto1 = LeaderboardEntity(id: 1, username: 'user', score: 100);
      const dto2 = LeaderboardEntity(id: 1, username: 'user', score: 100);
      // Проверка
      expect(dto1, equals(dto2));
    });
    test('Проверка неправильного сравнения LeaderboardEntity', () {
      // Подготовка и действие
      // Создание двух разных объектов LeaderboardEntity
      // с одинаковыми значениями
      const dto1 = LeaderboardEntity(id: 1, username: 'user', score: 100);
      const dto2 = LeaderboardEntity(id: 2, username: 'user', score: 100);
      // Проверка
      expect(dto1, isNot(equals(dto2)));
    });
  });
}
