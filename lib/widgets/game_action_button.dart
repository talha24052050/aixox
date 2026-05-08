import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class GameActionButton extends StatelessWidget {
  const GameActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 64,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColors.glass,
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: AppColors.xColor),
        ),
      ),
    );
  }
}
