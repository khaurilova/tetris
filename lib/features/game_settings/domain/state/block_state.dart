import 'package:tetris/features/game/src/blocks/blocks.dart';

final class BlockState {
  List<Block> selectedBlocks;
  BlockState({required this.selectedBlocks});

  BlockState copyWith({required List<Block> selectedBlocks}) {
    return BlockState(selectedBlocks: selectedBlocks);
  }
}
