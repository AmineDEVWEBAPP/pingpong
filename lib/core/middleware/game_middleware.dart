import 'package:get/get.dart';

import '../../controller/game_controller.dart';

class GameMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    Get.put(GameController());
    return super.onPageCalled(page);
  }
}
