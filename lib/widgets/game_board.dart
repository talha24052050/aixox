import 'package:flutter/material.dart';

import '../models/game_models.dart';
import 'cell_widget.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({
    super.key,
    required this.board,
    required this.onCellTap,
    required this.disabled,
    required this.winningLine,
  });

  final List<Player?> board;
  final ValueChanged<int> onCellTap;
  final bool disabled;
  final List<int>? winningLine;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return CellWidget(
            value: board[index],
            disabled: disabled,
            isWinningCell: winningLine?.contains(index) ?? false,
            onTap: () => onCellTap(index),
          );
        },
      ),
    );
  }
}
