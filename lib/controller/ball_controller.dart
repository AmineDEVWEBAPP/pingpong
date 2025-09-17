import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

import '../core/const/consts.dart';
import '../core/const/enum.dart';
import 'game_controller.dart';

class BallController {
  final GameController _gContr;
  RxDouble x = 0.0.obs;
  RxDouble y = 0.0.obs;
  double _xd = 5;
  double _yd = -5;
  double _speed = 15;
  final double _sides = 195;
  final double topSide = -520;
  final AudioPlayer _audioPlayer = AudioPlayer();

  BallController(this._gContr);

  reInit() {
    _speed = 5;
    x.value = 0.0;
    y.value = 0.0;
    _xd = _speed;
    _yd = -_speed;
  }

  void moveStep() {
    if (_gContr.status == GameStatus.pause) {
      _checkSides();
      x.value += _xd;
      y.value += _yd;
      _incrementSpeed();
    }
  }

  // check if ball touch sides or paddle or top
  void _checkSides() {
    // top
    if (y.value < topSide && _yd.isNegative) {
      _yd = _speed;
      if (_gContr.allowSound) {
        _audioPlayer.play(AssetSource(popPath));
      }
    }
    // bottom
    bool atPaddle =
        x.value >= _gContr.paddleX - 25 && x.value <= _gContr.paddleX + 25;
    if (y.value > 10 && atPaddle == false) {
      _gContr.status = GameStatus.restart;
      _gContr.update(['controllerButton']);
      _gContr.ticker.stop();
      if (_gContr.score > _gContr.topScore) {
        _gContr.setTopScore(_gContr.score);
      }
    }
    if (y.value > 0 && atPaddle) {
      _yd = -_speed;
      _gContr.score++;
      _gContr.update(['score']);
    }
    // lift
    if (x.value < -_sides && _xd.isNegative) {
      _xd = _speed;
    }
    // right
    if (x.value > _sides && !_xd.isNegative) {
      _xd = -_speed;
    }
  }

  void _incrementSpeed() {}
}
