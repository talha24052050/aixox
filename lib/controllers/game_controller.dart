import 'dart:async';

import 'package:flutter/foundation.dart';

import '../logic/ai_logic.dart';
import '../logic/game_rules.dart';
import '../models/game_models.dart';

class GameController extends ChangeNotifier {
  GameController({AiLogic aiLogic = const AiLogic()}) : _aiLogic = aiLogic;

  final AiLogic _aiLogic;

  List<Player?> _board = List<Player?>.filled(9, null);
  final List<BoardSnapshot> _history = [
    const BoardSnapshot(board: [null, null, null, null, null, null, null, null, null], isPlayerTurn: true),
  ];

  bool _isPlayerTurn = true;
  bool _isAiThinking = false;
  GameResult _result = GameResult.inProgress;
  List<int>? _winningLine;
  int _playerScore = 0;
  int _aiScore = 0;

  List<Player?> get board => _board;
  bool get isPlayerTurn => _isPlayerTurn;
  bool get isAiThinking => _isAiThinking;
  bool get canUndo => _history.length > 1 && !_isAiThinking;
  GameResult get result => _result;
  List<int>? get winningLine => _winningLine;
  int get playerScore => _playerScore;
  int get aiScore => _aiScore;

  String get statusText {
    switch (_result) {
      case GameResult.xWon:
        return 'You Win!';
      case GameResult.oWon:
        return 'AI Wins!';
      case GameResult.draw:
        return 'Draw!';
      case GameResult.inProgress:
        return _isPlayerTurn ? 'Your Turn' : 'AI Turn';
    }
  }

  void onPlayerMove(int index) {
    if (!_isPlayerTurn || _isAiThinking || _result != GameResult.inProgress || _board[index] != null) {
      return;
    }

    _applyMove(index, Player.x);

    if (_result == GameResult.inProgress) {
      _startAiTurn();
    }
  }

  void undoMove() {
    if (!canUndo) {
      return;
    }

    // Remove AI move and player move together to keep the turn consistent.
    if (_history.length >= 3) {
      _history.removeLast();
      _history.removeLast();
    } else {
      _history.removeLast();
    }

    final last = _history.last;
    _board = [...last.board];
    _isPlayerTurn = last.isPlayerTurn;
    _result = GameRules.calculateResult(_board);
    _winningLine = GameRules.findWinningLine(_board);
    _isAiThinking = false;
    notifyListeners();
  }

  void resetBoard() {
    _board = List<Player?>.filled(9, null);
    _isPlayerTurn = true;
    _isAiThinking = false;
    _result = GameResult.inProgress;
    _winningLine = null;
    _history
      ..clear()
      ..add(
        const BoardSnapshot(
          board: [null, null, null, null, null, null, null, null, null],
          isPlayerTurn: true,
        ),
      );
    notifyListeners();
  }

  void _startAiTurn() {
    _isPlayerTurn = false;
    _isAiThinking = true;
    notifyListeners();

    Future<void>.delayed(const Duration(milliseconds: 320), () {
      if (_result != GameResult.inProgress) {
        _isAiThinking = false;
        notifyListeners();
        return;
      }

      final bestMove = _aiLogic.findBestMove(_board);
      if (bestMove == -1) {
        _isAiThinking = false;
        notifyListeners();
        return;
      }
      _applyMove(bestMove, Player.o);
      _isAiThinking = false;
      notifyListeners();
    });
  }

  void _applyMove(int index, Player player) {
    _board = [..._board];
    _board[index] = player;
    _result = GameRules.calculateResult(_board);
    _winningLine = GameRules.findWinningLine(_board);

    if (_result == GameResult.xWon) {
      _playerScore++;
    } else if (_result == GameResult.oWon) {
      _aiScore++;
    }

    _isPlayerTurn = _result == GameResult.inProgress ? player == Player.o : _isPlayerTurn;
    _history.add(BoardSnapshot(board: [..._board], isPlayerTurn: _isPlayerTurn));
    notifyListeners();
  }
}
