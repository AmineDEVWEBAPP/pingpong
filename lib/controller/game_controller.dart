import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:pingpong/controller/ball_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/const/enum.dart';
import '../core/utils/methodes.dart';

class GameController extends GetxController {
  GameStatus status = GameStatus.start;
  late final Ticker ticker;
  late BallController bContr;
  double paddleX = 0;
  late SharedPreferences _sh;
  late int topScore;
  late bool allowSound;
  double iconDrawerTurns = 0;
  int score = 0;

  void drawerAnimation() {
    iconDrawerTurns == 0 ? iconDrawerTurns = 0.3 : iconDrawerTurns = 0;
    update(['drawerIcon']);
  }

  @override
  void onInit() async {
    super.onInit();
    bContr = BallController(this);
    _sh = await SharedPreferences.getInstance();
    topScore = _sh.getInt('topScore') ?? 0;
    allowSound = _sh.getBool('soundAuth') ?? true;
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
    score = 0;
    update(['controllerButton', 'score']);
    bContr.reInit();
    ticker.start();
  }

  void stop() {
    logger('stop');
    status = GameStatus.resume;
    update(['controllerButton']);
    ticker.stop();
  }

  Future<void> setTopScore(int score) async {
    logger('set Top Score: $score');
    topScore = score;
    await _sh.setInt('topScore', score);
  }

  Future<void> setSoundeAuth(bool auth) async {
    logger('change sound auth to $auth');
    allowSound = auth;
    await _sh.setBool('soundAuth', auth);
  }
}
