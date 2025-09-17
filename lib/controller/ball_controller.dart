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
  final double _sides = 195;
  final double topSide = -520;
  final AudioPlayer _audioPlayer = AudioPlayer();

  BallController(this._gContr);

  reInit() {
    x.value = 0.0;
    y.value = 0.0;
    _xd = 5;
    _yd = -5;
  }

  void moveStep() {
    if (_gContr.status == GameStatus.pause) {
      x.value += _xd;
      y.value += _yd;
      _checkSides();
    }
  }

  // check if ball touch sides or paddle or top
  void _checkSides() {
    // top
    if (y < topSide && _yd.isNegative) {
      _yd = -_yd;
      if (_gContr.allowSound) {
        _audioPlayer.play(AssetSource(popPath));
      }
    }
    // bottom
    bool atPaddle =
        x.value >= _gContr.paddleX - 25 && x.value <= _gContr.paddleX + 25;
    if (y > 0 && !_yd.isNegative && atPaddle) {
      _yd = -_yd;
      _gContr.score++;
      _gContr.update(['score']);
    }
    // if the ball is not at paddle it will loss
    if (y > 100) {
      _gContr.status = GameStatus.restart;
      _gContr.update(['controllerButton']);
      _gContr.ticker.stop();
      if (_gContr.score > _gContr.topScore) {
        _gContr.setTopScore(_gContr.score);
      }
    }
    // lift
    if (x < -_sides && _xd.isNegative) {
      _xd = -_xd;
    }
    // right
    if (x > _sides && !_xd.isNegative) {
      _xd = -_xd;
    }
  }
}
