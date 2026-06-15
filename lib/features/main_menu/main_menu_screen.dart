import 'package:flutter/material.dart';
import 'package:tetris/app/context_ext.dart';
import 'package:tetris/features/game/src/blocks/block.dart';
import 'package:tetris/features/game_settings/domain/block_selecter.dart';
import 'package:tetris/features/game_settings/domain/game_difficulty.dart';
import 'package:tetris/features/game_settings/domain/state/difficulty_state.dart';
import 'package:tetris/features/main_menu/block_selector_widget.dart';
import 'package:tetris/main.dart';

/// Главное меню игры

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<DifficultyState>(
              valueListenable: context.di.difficultyCubit.stateNotifier,
              builder: (context, state, _) {
                return Column(
                  children: GameDifficulty.values.map((difficulty) {
                    final isSelected = state.selectedDifficulty == difficulty;

                    return RadioListTile<GameDifficulty>(
                      title: Text(difficulty.title),
                      subtitle: Text('Скорость: ${difficulty.speed}'),
                      value: difficulty,
                      groupValue: state.selectedDifficulty,
                      onChanged: (value) {
                        if (value == null) return;
                        context.di.difficultyCubit.selectDifficulty(value);
                      },
                      selected: isSelected,
                    );
                  }).toList(),
                );
              },
            ),
            BlockSelectorWidget(),
            ElevatedButton(
              onPressed: () {
                // Переход на экран игры
                Navigator.pushReplacementNamed(context, GameRouter.userRoute);
              },
              child: Text('Начать игру'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Переход на экран ввода имени игрока
                Navigator.pushNamed(context, GameRouter.leaderboardRoute);
              },
              child: Text('Лучшие результаты'),
            ),
          ],
        ),
      ),
    );
  }
}
