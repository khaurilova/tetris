import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final Color theColor;
  final Function(Color) pickingColor;
  const ColorButton({
    super.key,
    required this.theColor,
    required this.pickingColor,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pickingColor(theColor),
      child: SizedBox(
        width: 75,
        height: 75,
        child: DecoratedBox(decoration: BoxDecoration(color: theColor)),
      ),
    );
  }
}
