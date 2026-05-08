import 'package:flutter/material.dart';

abstract final class AppColors {
  static const backgroundTop = Color(0xFF0A0E27);
  static const backgroundMiddle = Color(0xFF151B3D);
  static const backgroundBottom = Color(0xFF1A1F3A);

  static const glass = Color(0x14FFFFFF);
  static const glassBorder = Color(0x33FFFFFF);
  static const gridGap = Color(0x0DFFFFFF);

  static const xColor = Color(0xFF22D3EE);
  static const oColor = Color(0xFFEC4899);

  static const xColorDark = Color(0xFF06B6D4);
  static const oColorDark = Color(0xFFDB2777);
  static const xGlow = Color(0x8022D3EE);
  static const oGlow = Color(0x80EC4899);

  static const winHighlight = Color(0xFFFDE047);
  static const winGlow = Color(0x99FDE047);

  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xB3FFFFFF);
  static const muted = Color(0x80FFFFFF);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.backgroundTop,
    colorScheme: ColorScheme.dark(
      surface: AppColors.glass,
      primary: AppColors.xColor,
      secondary: AppColors.oColor,
    ),
    fontFamily: 'Poppins',
  );
}
