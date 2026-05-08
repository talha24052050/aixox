import 'package:flutter/material.dart';

import '../controllers/game_controller.dart';
import '../models/game_models.dart';
import '../theme/app_theme.dart';
import '../widgets/game_action_button.dart';
import '../widgets/game_board.dart';
import '../widgets/score_board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GameController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GameController()..addListener(_onControllerUpdate);
  }

  void _onControllerUpdate() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onControllerUpdate)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.backgroundTop,
              AppColors.backgroundMiddle,
              AppColors.backgroundBottom,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    ScoreBoard(
                      playerScore: _controller.playerScore,
                      aiScore: _controller.aiScore,
                    ),
                    const SizedBox(height: 18),
                    _buildStatusPill(),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Center(
                        child: GameBoard(
                          board: _controller.board,
                          disabled: !_controller.isPlayerTurn ||
                              _controller.result != GameResult.inProgress,
                          winningLine: _controller.winningLine,
                          onCellTap: _controller.onPlayerMove,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GameActionButton(
                          icon: Icons.refresh_rounded,
                          onPressed: _controller.resetBoard,
                        ),
                        const SizedBox(width: 16),
                        GameActionButton(
                          icon: Icons.undo_rounded,
                          onPressed: _controller.canUndo ? _controller.undoMove : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusPill() {
    final isFinished = _controller.result != GameResult.inProgress;
    final statusColor = switch (_controller.result) {
      GameResult.xWon => AppColors.xColor,
      GameResult.oWon => AppColors.oColor,
      GameResult.draw => AppColors.winHighlight,
      GameResult.inProgress => _controller.isAiThinking ? AppColors.oColor : AppColors.xColor,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.glass,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: isFinished ? 0.35 : 0.2),
            blurRadius: isFinished ? 18 : 12,
          ),
        ],
      ),
      child: Text(
        _controller.statusText,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
