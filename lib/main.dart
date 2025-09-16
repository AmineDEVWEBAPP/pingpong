import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'core/config/theme_config.dart';
import 'core/utils/methodes.dart';
import 'view/screen/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeConfig.theme,
    themeMode: ThemeConfig.mode,
    initialRoute: '/game',
    getPages: [GetPage(name: '/game', page: () => GamePage())],
  );
}
