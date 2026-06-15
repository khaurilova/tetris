import 'package:tetris/features/game_settings/domain/game_difficulty.dart';

final class DifficultyState {
  const DifficultyState({required this.selectedDifficulty});

  final GameDifficulty selectedDifficulty;

  DifficultyState copyWith({GameDifficulty? selectedDifficulty}) {
    return DifficultyState(
      selectedDifficulty: selectedDifficulty ?? this.selectedDifficulty,
    );
  }
}
