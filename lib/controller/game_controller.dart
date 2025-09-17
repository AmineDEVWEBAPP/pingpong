import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:pingpong/controller/ball_controller.dart';

import '../core/const/enum.dart';
import '../core/utils/methodes.dart';

class GameController extends GetxController {
  GameStatus status = GameStatus.start;
  late final Ticker ticker;
  late BallController bContr;
  double paddleX = 0;

  @override
  void onInit() {
    super.onInit();
    bContr = BallController(this);
  }

  void start() {
    logger('start');
    status = GameStatus.pause;
    ticker.start();
    update(['controllerButton']);
    bContr.moveStep();
  }

  void restart() {
    logger('restart');
    status = GameStatus.pause;
    update(['controllerButton']);
    bContr.reInit();
    ticker.start();
  }

  void stop() {
    logger('stop');
    status = GameStatus.resume;
    update(['controllerButton']);
    ticker.stop();
  }
}
