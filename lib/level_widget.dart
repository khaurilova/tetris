import 'package:flutter/material.dart';

class LevelWidget extends StatelessWidget {
  const LevelWidget({
    super.key,
    required this.onLevelPicked,
    required this.startOfTheGame,
  });

  final Function(int) onLevelPicked;
  final VoidCallback startOfTheGame;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Choose your level'),

        OutlinedButton(
          onPressed: () {
            onLevelPicked(1);
            startOfTheGame();
          },
          child: Text('I'),
        ),
        OutlinedButton(
          onPressed: () {
            onLevelPicked(2);
            startOfTheGame();
          },
          child: Text('II'),
        ),
        OutlinedButton(
          onPressed: () {
            onLevelPicked(3);
            startOfTheGame();
          },
          child: Text('III'),
        ),
      ],
    );
  }
}
