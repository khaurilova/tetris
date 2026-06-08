import 'package:flutter/material.dart';

class LevelWidget extends StatelessWidget {
  const LevelWidget({super.key, required this.onLevelPicked});

  final Function(int) onLevelPicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Choose your level'),

        OutlinedButton(
          onPressed: () {
            onLevelPicked(1);
          },
          child: Text('I'),
        ),
        OutlinedButton(
          onPressed: () {
            onLevelPicked(2);
          },
          child: Text('II'),
        ),
        OutlinedButton(
          onPressed: () {
            onLevelPicked(3);
          },
          child: Text('III'),
        ),
      ],
    );
  }
}
