import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/game_controller.dart';

class Ball extends StatefulWidget {
  const Ball({super.key});

  @override
  State<Ball> createState() => _BallState();
}

class _BallState extends State<Ball> with SingleTickerProviderStateMixin {
  final GameController _gContr = Get.find<GameController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Size size = MediaQuery.of(context).size;
      double ballDiameter = size.width * 0.05;
      _gContr.bContr.setBoundaries(size, ballDiameter);
    });
    _gContr.ticker = createTicker((_) {
      _gContr.bContr.moveStep();
    });
  }

  @override
  void dispose() {
    _gContr.ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Obx(
      () => Transform.translate(
        offset: Offset(_gContr.bContr.x.value, _gContr.bContr.y.value),
        child: Container(
          width: size.width * 0.05,
          height: size.width * 0.05,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(200),
          ),
        ),
      ),
    );
  }
}
