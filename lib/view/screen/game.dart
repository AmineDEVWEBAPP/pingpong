import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/game_controller.dart';
import '../../core/config/theme_config.dart' show ThemeConfig;
import '../../core/const/enum.dart';
import '../widget/game_widget/ball.dart';
import '../widget/game_widget/paddle.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});
  final ThemeData _appTheme = ThemeConfig.theme;
  final GameController _gContr = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: size.height * 0.7),
          Ball(),
          Paddle(),
          SizedBox(height: size.height * 0.02),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(_appTheme.cardColor),
            ),
            onPressed: () {
              switch (_gContr.status) {
                case GameStatus.start || GameStatus.resume:
                  _gContr.start();
                  break;
                case GameStatus.pause:
                  _gContr.stop();
                  break;
                case GameStatus.restart:
                  _gContr.restart();
              }
            },
            child: GetBuilder<GameController>(
              id: 'controllerButton',
              builder: (contr) => Text(
                contr.status.name,
                style: _appTheme.textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
