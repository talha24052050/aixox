enum Player { x, o }

enum GameResult { xWon, oWon, draw, inProgress }

class BoardSnapshot {
  const BoardSnapshot({
    required this.board,
    required this.isPlayerTurn,
  });

  final List<Player?> board;
  final bool isPlayerTurn;
}
