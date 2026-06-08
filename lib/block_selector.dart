import 'package:flutter/material.dart';
import 'package:tetris/src/blocks/blocks.dart';
import 'package:tetris/tetris_game.dart';

class BlockSelector extends StatefulWidget {
  final Function(List<Block>, List<Block>, int) onBlockSelection;
  final List<Block> selectedBlocks;
  const BlockSelector({
    super.key,
    required this.onBlockSelection,
    required this.selectedBlocks,
  });

  @override
  State<BlockSelector> createState() => _BlockSelectorState();
}

class _BlockSelectorState extends State<BlockSelector> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 50,
            mainAxisExtent: 60,
            crossAxisSpacing: 2,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: availableBlocks.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => widget.onBlockSelection(
                widget.selectedBlocks,
                availableBlocks,
                index,
              ),
              child: Stack(
                children: [
                  if (widget.selectedBlocks.contains(availableBlocks[index]))
                    Positioned(right: 30, child: Icon(Icons.check_circle)),

                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CustomPaint(
                      painter: NextBlockPainter(
                        20,
                        nextBlock: availableBlocks[index],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
