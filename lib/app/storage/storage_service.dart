import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tetris/app/storage/i_storage_service.dart';
import 'package:tetris/features/leaderboard/data/leaderboard_dto.dart';
import 'package:tetris/features/leaderboard/domain/state/leaderboard_entity.dart';

class StorageService implements IStorageService {
  /// Объект SharedPreferences для работы с локальным хранилищем
  late final SharedPreferences _sharedPreferences;

  /// Инициализация SharedPreferences
  @override
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> clear() => _sharedPreferences.clear();
  @override
  String? getString(String key) => _sharedPreferences.getString(key);
  @override
  Future<bool> setString(String key, String value) =>
      _sharedPreferences.setString(key, value);

  @override
  Iterable<LeaderboardEntity> cacheParser() {
    final String leaderBoardValue =
        _sharedPreferences.getString('cashLeaderBoard') ?? '';
    final Iterable decodedLeaderBoardValue = json.decode(leaderBoardValue);
    final result = decodedLeaderBoardValue.map((e) {
      return LeaderboardDto.fromJson(e).toEntity();
    }).toList();
    print(result);
    return result;
  }
}
