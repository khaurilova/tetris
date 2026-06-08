import 'package:flutter/material.dart';
import 'package:tetris/tetris_game.dart';

/// Экран игры
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    final level = int.tryParse(args[0].toString()) ?? 1;
    final pickedColor = args[1] ?? Colors.white;
    final selectedBlocks = args[2] ?? [];
    print(pickedColor);
    return Scaffold(
      body: TetrisGame(
        level: level,
        pickedColor: pickedColor,
        selectedBlocks: selectedBlocks,
      ),
    );
  }
}
