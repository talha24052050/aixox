import 'package:flutter/material.dart';

import '../models/game_models.dart';
import '../theme/app_theme.dart';

class CellWidget extends StatelessWidget {
  const CellWidget({
    super.key,
    required this.value,
    required this.onTap,
    required this.disabled,
    required this.isWinningCell,
  });

  final Player? value;
  final VoidCallback onTap;
  final bool disabled;
  final bool isWinningCell;

  @override
  Widget build(BuildContext context) {
    final glow = isWinningCell
        ? [
            BoxShadow(color: AppColors.winGlow, blurRadius: 30, spreadRadius: 1),
          ]
        : value == Player.x
            ? [BoxShadow(color: AppColors.xGlow, blurRadius: 18, spreadRadius: 1)]
            : value == Player.o
                ? [BoxShadow(color: AppColors.oGlow, blurRadius: 18, spreadRadius: 1)]
                : <BoxShadow>[];

    return GestureDetector(
      onTap: disabled || value != null ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.gridGap,
          border: Border.all(
            color: isWinningCell ? AppColors.winHighlight : AppColors.glassBorder,
            width: isWinningCell ? 2 : 1,
          ),
          boxShadow: glow,
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: value == null
                ? const SizedBox.shrink()
                : Text(
                    value == Player.x ? 'X' : 'O',
                    key: ValueKey<Player>(value!),
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: value == Player.x ? AppColors.xColor : AppColors.oColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
