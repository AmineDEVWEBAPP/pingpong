import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../controller/game_controller.dart';
import '../../../core/config/theme_config.dart';
import '../../../core/const/consts.dart';
import '../drawer/icon.dart';

class GameAppBar extends StatelessWidget {
  GameAppBar({super.key, required this.scaffoldState});

  final ThemeData _theme = ThemeConfig.theme;
  final GlobalKey<ScaffoldState> scaffoldState;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: size.height * 0.17,
          child: Image.asset(wallPath, fit: BoxFit.fill),
        ),
        AppBar(
          toolbarHeight: size.height * 0.12,
          backgroundColor: Colors.transparent,
          iconTheme: _theme.iconTheme,
          leading: DrawerIcon(
            onTap: () {
              scaffoldState.currentState?.openDrawer();
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
      ],
    );
  }
}
