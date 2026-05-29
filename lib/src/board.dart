import 'blocks/blocks.dart';

class Board {
  static const int heightBoard = 20;
  static const int widthBoard = 10;
  static const int posFree = 0;
  static const int posFilled = 1;
  static const int posBoarder = 2;
  late List<List<int>> mainBoard;
  late List<List<int>> mainCpy;

  // callback-функция для создания нового блока
  Block Function() newBlockFunc;
  // callback-функция для получения следующего блока
  Block Function() nextBlockFunc;
  // callback-функция для обновления счета
  void Function() updateScore;
  // callback-функция для обновления блока
  void Function(Block block) updateBlock;
  // callback-функция завершения игры
  void Function() gameOver;
  Future<void> Function() restartGame;
  void Function() pause;
  Block currentBlock; // текущий блок с игровой фигурой
  Board({
    required this.newBlockFunc,
    required this.nextBlockFunc,
    required this.currentBlock,
    required this.updateScore,
    required this.updateBlock,
    required this.gameOver,
    required this.restartGame,
    required this.pause,
  }) {
    mainBoard = List.generate(heightBoard, (_) => List.filled(widthBoard, 0));
    mainCpy = List.generate(heightBoard, (_) => List.filled(widthBoard, 0));
    initDrawMain();
  }

  void keyboardEventHandler(int key) async {
    var x = currentBlock.x;
    var y = currentBlock.y;
    switch (key) {
      case 119: // W — поворот фигуры
        rotateBlock();
      case 97: // A — влево
        if (!isFilledBlock(x - 1, y)) {
          moveBlock(x - 1, y);
        }
      case 115: // S — вниз
        if (!isFilledBlock(x, y + 1)) {
          moveBlock(x, y + 1);
        }
      case 100: // D — вправо
        if (!isFilledBlock(x + 1, y)) {
          moveBlock(x + 1, y);
        }
      case 114:
        await restartGame();

      case 112:
        pause();
      case 113:
        gameOver();
    }
  }

  // сохранение текущего состояния игрового поля
  void savePresentBoardToCpy() {
    for (int i = 0; i < heightBoard - 1; i++) {
      for (int j = 0; j < widthBoard - 1; j++) {
        mainCpy[i][j] = mainBoard[i][j];
      }
    }
  }

  // Метод инициализации игровой доски
  void initDrawMain() {
    for (int i = 0; i <= heightBoard - 2; i++) {
      for (int j = 0; j <= widthBoard - 2; j++) {
        if (j == 0 || j == widthBoard - 2 || i == heightBoard - 2) {
          mainBoard[i][j] = posBoarder;
          mainCpy[i][j] = posBoarder;
        }
      }
    }
    newBlock();
    drawBoard();
  }

  // Метод отрисовки основной доски
  void drawBoard() {}

  // Метод генерации нового блока и его добавления на основную доску
  void newBlock() {
    currentBlock = newBlockFunc();
    var x = currentBlock.x;
    // добавляем новый блок на основную доску
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        mainBoard[i][x + j] = mainCpy[i][x + j] + currentBlock[i][j];
        // проверка на пересечение
        if (mainBoard[i][x + j] > 1) {
          gameOver(); // игра окончена
        }
      }
    }
  }

  // Метод перемещения фигуры по основной доске
  void moveBlock(int x2, int y2) {
    // убираем фигуру с текущей позиции
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (currentBlock.x + j >= 0) {
          mainBoard[currentBlock.y + i][currentBlock.x + j] -=
              currentBlock[i][j];
        }
      }
    }
    // устанавливаем новую позицию
    currentBlock.move(x2, y2);
    // добавляем фигуру на новую позицию
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        // проверка левого края
        if (currentBlock.x + j >= 0) {
          mainBoard[currentBlock.y + i][currentBlock.x + j] +=
              currentBlock[i][j];
        }
      }
    }
    drawBoard();
  }

  // Метод проверки возможности сдвига блока в заданном направлении
  bool isFilledBlock(int x2, int y2) {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (currentBlock[i][j] != 0 && mainCpy[y2 + i][x2 + j] != 0) {
          return true;
        }
      }
    }
    return false;
  }

  // Метод обработки поворота блока
  void rotateBlock() {
    // Временный блок с текущей фигурой
    var tmpBlock = currentBlock.copyWith();
    currentBlock.rotate(); // Поворачиваем фигуру
    // Проверка того, что фигура не пересекается
    // с границей или другими блоками ранее
    // помещенных на доску фигур
    if (isFilledBlock(tmpBlock.x, tmpBlock.y)) {
      currentBlock = tmpBlock;
      // обновляем текущую фигуру в классе Game
      updateBlock(currentBlock);
    }
    var x = currentBlock.x;
    var y = currentBlock.y;
    // Обновляем основную доску
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        // убираем старую фигуру
        mainBoard[y + i][x + j] -= tmpBlock[i][j];
        // добавляем новую фигуру
        mainBoard[y + i][x + j] += currentBlock[i][j];
      }
    }
    drawBoard();
  }

  // Метод очистки заполненных строк
  void clearLine() {
    for (int j = 0; j <= heightBoard - 3; j++) {
      // проверка заполненности строки
      int i = 1;
      while (i <= widthBoard - 3) {
        if (mainBoard[j][i] == posFree) {
          break;
        }
        i++;
      }
      if (i == widthBoard - 2) {
        // если строка заполнена, очистка строки
        // и сдвиг строк игровой доски вниз
        for (int k = j; k > 0; k--) {
          for (int idx = 1; idx <= widthBoard - 3; idx++) {
            mainBoard[k][idx] = mainBoard[k - 1][idx];
          }
        }
        // вызываем callback-функцию для увеличения очков
        updateScore();
      }
    }
  }
}
