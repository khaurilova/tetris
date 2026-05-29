import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'blocks/blocks.dart';
import 'board.dart';

final class Game extends ChangeNotifier {
  late Board board;
  late Block currentBlock; // текущий блок
  late Block nextBlock; // следующий блок

  bool _isGameOver = false;
  bool isPaused = false;
  int level = 0;
  int score = 0;
  int speed = 500;
  int currentSpeed = 500;
  final Function(String scores) onGameOver;
  Game({required this.onGameOver}) {
    currentBlock = getNewRandomBlock();
    nextBlock = getNewRandomBlock();

    board = Board(
      currentBlock: currentBlock,
      newBlockFunc: newBlock,
      nextBlockFunc: getNextBlock,
      updateScore: updateScore,
      updateBlock: updateBlock,
      gameOver: gameOver,
      restartGame: restartGame,
      pause: pause,
    );
  }
  Future<void> start() async {
    // Запускаем игровой цикл
    while (!_isGameOver) {
      nextStep();
      await Future.delayed(Duration(milliseconds: currentSpeed));
    }
    onGameOver(score.toString()); // Вызывается при завершении игры
  }

  void pause() {
    isPaused = !isPaused;
  }

  // Метод обновления блока фигуры
  void updateBlock(Block block) {
    currentBlock = block;
    notifyListeners();
  }

  // Метод обновления счета
  void updateScore() {
    score += 10;
    updateLevel();
    notifyListeners();
  }

  void updateLevel() {
    level = score ~/ 50 + 1;
    currentSpeed = max(100, speed - level * 50);
  }

  // Метод генерации новой фигуры
  Block newBlock() {
    currentBlock = nextBlock;
    nextBlock = getNewRandomBlock();
    return currentBlock;
  }

  // Возвращает следующую фигуру для панели предпросмотра.
  // Важно: этот метод не обращается к _board, поэтому его безопасно
  // вызывать даже во время создания Board.
  Block getNextBlock() => nextBlock;

  // Метод установки прослушивания нажатий клавиш
  // и передачи ASCII-кода нажатой клавиши на уровень ниже
  void keyboardEventHandler() {
    updateBlock(currentBlock);
  }

  void currentLevel(int input) {
    switch (input) {
      case 1:
        level = 1;
        speed = 500;
        break;
      case 2:
        level = 3;
        speed = 300;
        break;
      case 3:
        level = 5;
        speed = 100;
        break;
    }
  }

  void printScore() {}
  bool get isGameOver => _isGameOver;
  void gameOver() {
    _isGameOver = true;
  }

  Future<void> restartGame() async {
    if (_isGameOver) {
      _isGameOver = false;
      score = 0;
      level = 0;
      speed = 500;
      currentSpeed = 500;
      // обнуляем набранные очки
      // level = 0;
      board = Board(
        currentBlock: currentBlock,
        newBlockFunc: newBlock,
        nextBlockFunc: getNextBlock,
        updateScore: updateScore,
        updateBlock: updateBlock,
        gameOver: gameOver,
        restartGame: restartGame,
        pause: pause,
      );
      start(); //TODO:
    }
  }

  // Метод обработки шага игрового цикла
  void nextStep() {
    var x = currentBlock.x;
    var y = currentBlock.y;
    if (!isPaused) {
      if (!board.isFilledBlock(x, y + 1)) {
        board.moveBlock(x, y + 1);
      } else {
        board.clearLine();
        board.savePresentBoardToCpy();
        board.newBlock();
        board.drawBoard();
      }
      notifyListeners();
    }
  }
}
