import 'package:tetris/app/equals_mixin.dart';
import 'package:tetris/features/leaderboard/domain/state/leaderboard_entity.dart';

/// Состояние блока
sealed class LeaderboardState with EqualsMixin {
  const LeaderboardState();
  @override
  List<Object?> get fields => [];
}

/// Состояние инициализации
final class LeaderboardInitState extends LeaderboardState {
  const LeaderboardInitState();
}

/// Состояние загрузки
final class LeaderboardLoading extends LeaderboardState {
  const LeaderboardLoading();
}

/// Состояние успешной загрузки
final class LeaderboardSuccessState extends LeaderboardState {
  /// При успешной загрузке получаем список
  /// сущностей таблицы лидеров
  final List<LeaderboardEntity> leaderboard;
  const LeaderboardSuccessState(this.leaderboard);
  @override
  List<Object?> get fields => [leaderboard];
}

/// Состояние ошибки
final class LeaderboardErrorState extends LeaderboardState {
  final String message;
  final Object error;
  final StackTrace? stackTrace;
  final Iterable<LeaderboardEntity> cachedLeaderboard;
  LeaderboardErrorState(
    this.message, {
    required this.error,
    this.stackTrace,
    required this.cachedLeaderboard,
  });
  @override
  List<Object?> get fields => [message, error, stackTrace, cachedLeaderboard];
}
