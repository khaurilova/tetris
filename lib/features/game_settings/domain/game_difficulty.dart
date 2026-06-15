enum GameDifficulty {
  easy(title: 'Легкий', level: 1, speed: 700),
  medium(title: 'Средний', level: 2, speed: 500),
  hard(title: 'Сложный', level: 3, speed: 300);

  const GameDifficulty({
    required this.title,
    required this.level,
    required this.speed,
  });

  final String title;
  final int level;
  final int speed;
}
