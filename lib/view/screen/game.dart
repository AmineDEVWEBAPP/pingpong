import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/game_controller.dart';
import '../../core/config/theme_config.dart' show ThemeConfig;
import '../../core/const/enum.dart';
import '../widget/drawer/icon.dart';
import '../widget/game_widget/ball.dart';
import '../widget/game_widget/paddle.dart';
import 'drawer.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});
  final ThemeData _theme = ThemeConfig.theme;
  final GameController _gContr = Get.find<GameController>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        backgroundColor: _theme.cardColor,
        iconTheme: _theme.iconTheme,
        leading: DrawerIcon(
          onTap: () {
            _scaffoldState.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 17),
        title: GetBuilder<GameController>(
          id: 'score',
          builder: (controller) => Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: _theme.scaffoldBackgroundColor,
              border: Border.all(color: _theme.secondaryHeaderColor),
            ),
            child: Text(
              'SCORE: ${controller.score}',
              style: _theme.textTheme.bodyMedium,
            ),
          ),
        ),
      ),
      onDrawerChanged: (isOpened) {
        _gContr.stop();
        _gContr.drawerAnimation();
      },
      drawer: GameDrawer(),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.7),
          Ball(),
          Paddle(),
          SizedBox(height: size.height * 0.02),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(_theme.cardColor),
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
              builder: (contr) =>
                  Text(contr.status.name, style: _theme.textTheme.bodyMedium),
            ),
          ),
        ],
      ),
    );
  }
}
