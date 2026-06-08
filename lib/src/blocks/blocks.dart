import 'dart:math';
import 'block.dart';
export 'block.dart';

final class IBlock extends Block {
  IBlock()
    : super([
        [0, 0, 0, 0],
        [1, 1, 1, 1],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ]);
}

final class OBlock extends Block {
  OBlock()
    : super([
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0],
      ]);
}

final class TBlock extends Block {
  TBlock()
    : super([
        [0, 0, 0, 0],
        [1, 1, 1, 0],
        [0, 1, 0, 0],
        [0, 0, 0, 0],
      ]);
}

final class LBlock extends Block {
  LBlock()
    : super([
        [0, 0, 0, 0],
        [1, 1, 1, 0],
        [1, 0, 0, 0],
        [0, 0, 0, 0],
      ]);
}

final class JBlock extends Block {
  JBlock()
    : super([
        [0, 0, 0, 0],
        [1, 1, 1, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 0],
      ]);
}

final class SBlock extends Block {
  SBlock()
    : super([
        [0, 0, 0, 0],
        [0, 1, 1, 0],
        [1, 1, 0, 0],
        [0, 0, 0, 0],
      ]);
}

final class ZBlock extends Block {
  ZBlock()
    : super([
        [0, 0, 0, 0],
        [1, 1, 0, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0],
      ]);
}

final class DBlock extends Block {
  DBlock()
    : super([
        [0, 1, 1, 0],
        [0, 1, 0, 0],
        [0, 1, 1, 0],
        [0, 0, 0, 0],
      ]);
}

final _defBlocks = [
  OBlock(),
  IBlock(),
  IBlock()..rotate(),
  LBlock(),
  LBlock()..rotate(),
  JBlock(),
  JBlock()..rotate(),
  TBlock(),
  TBlock()..rotate(),
  TBlock()
    ..rotate()
    ..rotate(),
  TBlock()
    ..rotate()
    ..rotate()
    ..rotate(),
  SBlock(),
  SBlock()..rotate(),
  SBlock()
    ..rotate()
    ..rotate(),
  SBlock()
    ..rotate()
    ..rotate()
    ..rotate(),
  ZBlock(),
  ZBlock()..rotate(),
  ZBlock()
    ..rotate()
    ..rotate(),
  ZBlock()
    ..rotate()
    ..rotate()
    ..rotate(),
  DBlock(),
  DBlock()..rotate(),
  DBlock()
    ..rotate()
    ..rotate(),
  DBlock()
    ..rotate()
    ..rotate()
    ..rotate(),
];

Block getNewRandomBlock(List<Block> selectedBlocks) {
  return (selectedBlocks.isEmpty)
      ? _defBlocks[Random().nextInt(_defBlocks.length)].copyWith()
      : selectedBlocks[Random().nextInt(selectedBlocks.length)].copyWith();
}

final List<Block> availableBlocks = [
  IBlock(),
  OBlock(),
  TBlock(),
  LBlock(),
  JBlock(),
  SBlock(),
  ZBlock(),
  DBlock(),
];
