import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tetris/app/storage/i_storage_service.dart';
import 'package:tetris/app/storage/storage_service.dart';
import 'package:tetris/features/leaderboard/domain/i_leaderboard_repository.dart';

import 'leaderboard_state.dart';

/// Класс, использующий паттерн Cubit для управления состоянием
/// таблицы лидеров. Сами состояния таблицы хранятся в ValueNotifier
class LeaderboardCubit {
  final ILeaderboardRepository repository;
  final IStorageService storageService;

  /// Состояние таблицы лидеров
  /// Используем ValueNotifier для отслеживания состояния
  final ValueNotifier<LeaderboardState> stateNotifier = ValueNotifier(
    LeaderboardInitState(),
  );
  LeaderboardCubit({required this.repository, required this.storageService});

  /// Установка текущего состояния
  void emit(LeaderboardState cubitState) {
    stateNotifier.value = cubitState;
  }

  /// Получение таблицы лидеров
  Future<void> fetchLeaderboard() async {
    // Проверяем текущее состояние
    // Если уже состояние загрузки, то ничего не делаем
    if (stateNotifier.value is LeaderboardLoading) {
      return;
    }
    try {
      emit(const LeaderboardLoading());
      final leaderboard = await repository.fetchLeaderboard();

      emit(LeaderboardSuccessState(leaderboard.toList()));
    } on Object catch (e, stackTrace) {
      final cachedLeaderboard = await storageService.cacheParser();
      emit(
        LeaderboardErrorState(
          'Ошибка загрузки таблицы лидеров',
          error: e,
          stackTrace: stackTrace,
          cachedLeaderboard: cachedLeaderboard,
        ),
      );
    }
  }

  /// Освобождение ресурсов
  /// Закрываем ValueNotifier, чтобы избежать утечек памяти
  void dispose() {
    stateNotifier.dispose();
  }
}
