import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/game_controller.dart';

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({super.key, required this.onTap});
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: GetBuilder<GameController>(
        id: 'drawerIcon',
        builder: (controller) => AnimatedRotation(
          turns: controller.iconDrawerTurns,
          duration: const Duration(milliseconds: 400),
          child: Icon(Icons.settings),
        ),
      ),
    );
  }
}
