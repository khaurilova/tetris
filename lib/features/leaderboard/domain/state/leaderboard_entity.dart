import 'package:flutter/foundation.dart';
import 'package:tetris/app/equals_mixin.dart';

@immutable
class LeaderboardEntity with EqualsMixin {
  /// Идентификатор пользователя
  final int id;

  /// Имя пользователя
  final String username;

  /// Лучший счет пользователя
  final int score;
  const LeaderboardEntity({
    required this.id,
    required this.username,
    required this.score,
  });
  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'score': score};
  }

  /// Переопределяем поля для сравнения объектов
  /// Используем для сравнения объектов в EqualsMixin
  @override
  List<Object?> get fields => [id, username, score];
}
