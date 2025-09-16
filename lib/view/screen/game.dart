import 'package:flutter/material.dart';

import '../../core/config/theme_config.dart' show ThemeConfig;
import '../widget/game_widget/paddle.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});
  final ThemeData _appTheme = ThemeConfig.theme;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: size.height * 0.2),
          Paddle(),
          SizedBox(height: size.height * 0.02),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(_appTheme.cardColor),
            ),
            onPressed: () {},
            child: Text('Start', style: _appTheme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
