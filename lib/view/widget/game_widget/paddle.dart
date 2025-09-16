import 'package:flutter/material.dart';

class Paddle extends StatefulWidget {
  const Paddle({super.key});

  @override
  State<Paddle> createState() => _PaddleState();
}

class _PaddleState extends State<Paddle> {
  double _x = 0;
  final double _side = 153.13;
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
              _x = _x.clamp(-_side, _side);
            });
          },
          child: Container(
            width: size.width * 0.25,
            height: size.height * 0.02,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
