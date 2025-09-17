import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/game_controller.dart';

class Paddle extends StatefulWidget {
  const Paddle({super.key});

  @override
  State<Paddle> createState() => _PaddleState();
}

class _PaddleState extends State<Paddle> {
  double _x = 0;
  final double _sides = 153.13;
  final GameController _gContr = Get.find<GameController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height * 0.07,
      alignment: Alignment.topCenter,
      child: Transform.translate(
        offset: Offset(_x, 0),
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              _x += details.delta.dx;
              _x = _x.clamp(-_sides, _sides);
            });
            _gContr.paddleX = _x;
          },
          child: Container(
            color: Colors.transparent,
            height: double.infinity,
            width: size.width * 0.25,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: size.width * 0.25,
                height: size.height * 0.02,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
