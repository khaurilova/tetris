import 'package:flutter/widgets.dart';
import 'package:tetris/app/context_ext.dart';
import 'package:tetris/features/game_settings/domain/block_selecter.dart';
import 'package:tetris/features/game_settings/domain/state/block_state.dart';

class BlockSelectorWidget extends StatelessWidget {
  const BlockSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BlockState>(
      valueListenable: context.di.blockCubit.stateNotifier,
      builder: (context, state, _) {
        return BlockSelector(
          selectedBlocks:
              context.di.blockCubit.stateNotifier.value.selectedBlocks,
        );
      },
    );
  }
}
