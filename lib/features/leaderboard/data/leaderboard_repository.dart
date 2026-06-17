import 'dart:convert';
import 'package:tetris/app/http/i_http_client.dart';
import 'package:tetris/app/storage/i_storage_service.dart';
import 'package:tetris/features/leaderboard/domain/i_leaderboard_repository.dart';
import 'package:tetris/features/leaderboard/domain/state/leaderboard_entity.dart';

import 'leaderboard_dto.dart';

/// Реализация репозитория для таблицы лидеров
final class LeaderboardRepository implements ILeaderboardRepository {
  /// HTTP-клиент для отправки запросов к API
  final IHttpClient httpClient;
  final IStorageService storageService;
  LeaderboardRepository({
    required this.httpClient,
    required this.storageService,
  });
  @override
  Future<Iterable<LeaderboardEntity>> fetchLeaderboard() async {
    // Получение данных
    final response = await httpClient.get('/users/');

    // Проверка статуса ответа
    if (response.statusCode != 200) {
      throw Exception('Ошибка при загрузке: ${response.statusCode}');
    }
    final Iterable data = json.decode(response.body);
    await storageService.setString('cashLeaderBoard', response.body);
    // Преобразование данных в список сущностей
    final resList = data.map((item) {
      return LeaderboardDto.fromJson(item).toEntity();
    }).toList();

    // Возвращаем список сущностей
    return resList;
  }
}
