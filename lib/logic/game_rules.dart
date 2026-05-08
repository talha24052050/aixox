import '../models/game_models.dart';

class GameRules {
  static const List<List<int>> winningLines = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  static GameResult calculateResult(List<Player?> board) {
    final winner = findWinningLine(board);
    if (winner != null) {
      return board[winner.first] == Player.x ? GameResult.xWon : GameResult.oWon;
    }
    if (board.every((cell) => cell != null)) {
      return GameResult.draw;
    }
    return GameResult.inProgress;
  }

  static List<int>? findWinningLine(List<Player?> board) {
    for (final line in winningLines) {
      final a = line[0];
      final b = line[1];
      final c = line[2];
      if (board[a] != null && board[a] == board[b] && board[b] == board[c]) {
        return line;
      }
    }
    return null;
  }
}
