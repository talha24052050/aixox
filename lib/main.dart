import 'package:flutter/material.dart';

import 'screens/game_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AiXoxApp());
}

class AiXoxApp extends StatelessWidget {
  const AiXoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const GameScreen(),
    );
  }
}
