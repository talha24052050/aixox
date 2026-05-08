import '../models/game_models.dart';
import 'game_rules.dart';

class AiLogic {
  const AiLogic();

  int findBestMove(List<Player?> board) {
    var bestScore = -1000;
    var bestMove = -1;

    for (var i = 0; i < board.length; i++) {
      if (board[i] != null) {
        continue;
      }

      final testBoard = [...board];
      testBoard[i] = Player.o;
      final score = _minimax(testBoard, false, 0);

      if (score > bestScore) {
        bestScore = score;
        bestMove = i;
      }
    }

    return bestMove;
  }

  int _minimax(List<Player?> board, bool maximizing, int depth) {
    final result = GameRules.calculateResult(board);
    if (result == GameResult.oWon) {
      return 10 - depth;
    }
    if (result == GameResult.xWon) {
      return depth - 10;
    }
    if (result == GameResult.draw) {
      return 0;
    }

    if (maximizing) {
      var bestScore = -1000;
      for (var i = 0; i < board.length; i++) {
        if (board[i] != null) {
          continue;
        }
        final testBoard = [...board];
        testBoard[i] = Player.o;
        bestScore = _max(bestScore, _minimax(testBoard, false, depth + 1));
      }
      return bestScore;
    }

    var bestScore = 1000;
    for (var i = 0; i < board.length; i++) {
      if (board[i] != null) {
        continue;
      }
      final testBoard = [...board];
      testBoard[i] = Player.x;
      bestScore = _min(bestScore, _minimax(testBoard, true, depth + 1));
    }
    return bestScore;
  }

  int _max(int a, int b) => a > b ? a : b;
  int _min(int a, int b) => a < b ? a : b;
}
