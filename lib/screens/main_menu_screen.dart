import 'package:flutter/material.dart';
import 'package:tetris/block_selector.dart';
import 'package:tetris/color_picker.dart';
import 'package:tetris/level_widget.dart';
import 'package:tetris/main.dart';
import 'package:tetris/src/blocks/blocks.dart';

/// Главное меню игры
class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int selectedLevel = 1;
  Color pickedColor = Colors.white;
  final List<Block> selectedBlocks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          LevelWidget(
            onLevelPicked: (level) {
              setState(() {
                selectedLevel = level;
              });
            },
          ),
          Expanded(
            child: ColorPicker(
              onColorPick: (color) {
                setState(() {
                  pickedColor = color;
                });
              },
            ),
          ),
          BlockSelector(
            onBlockSelection:
                (
                  List<Block> selectedBlocks,
                  List<Block> availableBlocks,
                  int index,
                ) {
                  setState(() {
                    selectedBlocks.contains(availableBlocks[index])
                        ? selectedBlocks.remove(availableBlocks[index])
                        : selectedBlocks.add(availableBlocks[index]);
                  });
                },
            selectedBlocks: selectedBlocks,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  GameRouter.gameRoute,
                  arguments: [selectedLevel, pickedColor, selectedBlocks],
                );
              },
              child: Text('Начать игру'),
            ),
          ),
        ],
      ),
    );
  }
}
