import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({
    super.key,
    required this.playerScore,
    required this.aiScore,
  });

  final int playerScore;
  final int aiScore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ScoreCard(
            label: 'PLAYER',
            score: playerScore,
            color: AppColors.xColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ScoreCard(
            label: 'AI MASTER',
            score: aiScore,
            color: AppColors.oColor,
          ),
        ),
      ],
    );
  }
}

class _ScoreCard extends StatelessWidget {
  const _ScoreCard({
    required this.label,
    required this.score,
    required this.color,
  });

  final String label;
  final int score;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.glass,
        border: Border.all(color: color.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.25), blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color.withValues(alpha: 0.7),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$score',
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
