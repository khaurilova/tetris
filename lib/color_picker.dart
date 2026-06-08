import 'package:flutter/material.dart';
import 'package:tetris/color_button.dart';

class ColorPicker extends StatelessWidget {
  final Function(Color) onColorPick;
  const ColorPicker({super.key, required this.onColorPick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ColorButton(theColor: Colors.amber, pickingColor: onColorPick),
        ColorButton(theColor: Colors.purpleAccent, pickingColor: onColorPick),
        ColorButton(theColor: Colors.lightGreen, pickingColor: onColorPick),
      ],
    );
  }
}
