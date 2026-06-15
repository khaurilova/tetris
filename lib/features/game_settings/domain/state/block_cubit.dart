import 'package:flutter/foundation.dart';
import 'package:tetris/features/game/src/blocks/block.dart';
import 'package:tetris/features/game/src/blocks/blocks.dart';
import 'package:tetris/features/game_settings/domain/state/block_state.dart';

final class BlockCubit {
  final ValueNotifier<BlockState> stateNotifier = ValueNotifier(
    BlockState(selectedBlocks: []),
  );

  void chosenBlocks(Block block) {
    List<Block> massivOfBlocks = stateNotifier.value.selectedBlocks;

    massivOfBlocks.contains(block)
        ? massivOfBlocks.remove(block)
        : massivOfBlocks.add(block);

    emit(stateNotifier.value.copyWith(selectedBlocks: massivOfBlocks));
  }

  void emit(BlockState state) {
    stateNotifier.value = state;
  }
}
