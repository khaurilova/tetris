import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tetris/level_widget.dart';
import 'package:tetris/main.dart';
import 'package:tetris/src/blocks/blocks.dart';

import 'package:tetris/game_scores.dart';
import '/src/board.dart';
import '/src/game.dart';

// Класс отрисовки игрового поля
class _GamePainter extends CustomPainter {
  // Игровое поле
  final List<List<int>> board;
  // Размер блока
  final double blockSize;
  _GamePainter(this.board, this.blockSize);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        Rect rect = Rect.fromLTWH(
          j * blockSize,
          i * blockSize,
          blockSize,
          blockSize,
        );
        switch (board[i][j]) {
          // Отрисовка пустых клеток поля
          case Board.posFree:
            paint.color = Colors.black;
          // Отрисовка блоков и заполненных клеток поля
          case Board.posFilled:
            paint.color = Colors.white;

          // Отрисовка границ поля
          case Board.posBoarder:
            paint.color = Colors.red;
        }
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _NextBlockPainter extends CustomPainter {
  final Block nextBlock;
  final double blockSize;

  _NextBlockPainter(this.blockSize, {required this.nextBlock});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (nextBlock[i][j] != 0) {
          paint.color = Colors.white;

          Rect rect = Rect.fromLTWH(
            j * blockSize,
            i * blockSize,
            blockSize,
            blockSize,
          );

          canvas.drawRect(rect, paint);

          // рамка
          paint
            ..style = PaintingStyle.stroke
            ..color = Colors.black;

          canvas.drawRect(rect, paint);

          paint.style = PaintingStyle.fill;
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TetrisGame extends StatefulWidget {
  const TetrisGame({super.key});
  @override
  State<TetrisGame> createState() => _TetrisGameState();
}

class _TetrisGameState extends State<TetrisGame> {
  late Game game;
  bool isGameStarted = false;

  // Метод для отображения диалогового окна при завершении игры
  // Принимает параметр scores в виде строки, содержащей набранные очки
  void _showGameOverDialog(String scores) {
    // Проверяем, что виджет все еще находится в дереве виджетов
    // Если виджет удален, прерываем выполнение метода
    if (!mounted) return;
    // Планируем показ диалога на следующий кадр отрисовки.
    // Это гарантирует, что диалог появится после
    // полной инициализации виджета
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Показываем диалоговое окно
      showDialog(
        // Передаем контекст для правильного позиционирования диалога
        context: context,
        // Запрещаем закрытие диалога при щелчке вне его области
        barrierDismissible: true,
        // Функция построения содержимого диалога
        builder: (BuildContext context) {
          // Возвращаем виджет AlertDialog с информацией
          // об окончании игры
          return AlertDialog(
            // Заголовок диалога
            title: const Text('Game Over'),
            // Текст с количеством набранных очков
            content: Text('Your score: $scores'),
            // Список кнопок действий (пока пустой)
            actions: [
              TextButton.icon(
                icon: Icon(Icons.repeat),
                onPressed: () {
                  game.restartGame();
                  Navigator.of(context).pop();
                },
                label: Text('Restart game'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    game = Game(
      onGameOver: (scores) {
        // Переход на экран окончания игры
        // Передаем scores в аргументах
        Navigator.pushReplacementNamed(
          context,
          GameRouter.gameOverRoute,
          arguments: scores,
        );
      },
    );
    // game.start();
  }

  void startGame() {
    game.start();
    setState(() {
      isGameStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListenableBuilder(
          listenable: game,
          builder: (context, child) => Text('Score: ${game.score}'),
        ),
      ),
      body: !isGameStarted
          ? LevelWidget(
              onLevelPicked: game.currentLevel,
              startOfTheGame: startGame,
            )
          : ListenableBuilder(
              // Передаем игру в качестве объекта, реализующего Listenable
              listenable: game,
              // Перестраиваем виджет при изменении состояния игры
              builder: (context, _) {
                return Focus(
                  autofocus: true,
                  onKeyEvent: (FocusNode node, KeyEvent event) {
                    if (event is KeyDownEvent || event is KeyRepeatEvent) {
                      game.board.keyboardEventHandler(event.logicalKey.keyId);
                      return KeyEventResult.handled;
                    }

                    // Если событие не обработано, возвращаем ignored
                    return KeyEventResult.ignored;
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        child: Align(
                          alignment: Alignment.center,
                          // Получаем размеры виджета
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final board = game.board.mainBoard;
                              // Вычисляем размер клетки поля
                              double blockSize = min(
                                constraints.maxWidth / board[0].length,
                                constraints.maxHeight / board.length,
                              );
                              return Column(
                                children: [
                                  Expanded(
                                    child: CustomPaint(
                                      painter: _GamePainter(board, blockSize),
                                      size: Size(
                                        board[0].length * blockSize,
                                        board.length * blockSize,
                                      ),
                                    ),
                                  ),
                                  // Отображение текущего счета
                                  Text(
                                    'Очки: ${game.score}',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        child: Container(
                          color: Colors.black,
                          width: 70,
                          height: 70,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final board = game.board.mainBoard;
                              // Вычисляем размер клетки поля
                              double blockSize = min(
                                constraints.maxWidth / 4,
                                constraints.maxHeight / 4,
                              );
                              return CustomPaint(
                                painter: _NextBlockPainter(
                                  blockSize,
                                  nextBlock: game.getNextBlock(),
                                ),
                                size: Size(
                                  board[0].length * blockSize,
                                  board.length * blockSize,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
