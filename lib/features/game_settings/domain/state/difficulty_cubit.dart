import 'package:flutter/foundation.dart';
import 'package:tetris/features/game_settings/domain/game_difficulty.dart';
import 'difficulty_state.dart';

final class DifficultyCubit {
  final ValueNotifier<DifficultyState> stateNotifier = ValueNotifier(
    const DifficultyState(selectedDifficulty: GameDifficulty.easy),
  );

  void selectDifficulty(GameDifficulty difficulty) {
    emit(stateNotifier.value.copyWith(selectedDifficulty: difficulty));
  }

  void emit(DifficultyState state) {
    stateNotifier.value = state;
  }
}
