import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/methodes.dart';

class ThemeConfig {
  static final ThemeConfig _instance = ThemeConfig();
  late SharedPreferences shp;
  static late ThemeMode mode;
  static late ThemeData theme;

  static init() async {
    logger('init Theme');
    _instance.shp = await SharedPreferences.getInstance();
    await _instance.getTheme();
  }

  static Future<void> changeMode(ThemeMode mode) async {
    logger('change themeMode to ${mode.name}');
    ThemeConfig.mode = mode;
    await _instance.shp.setString('mode', mode.name);
    Get.appUpdate();
  }

  Future<void> getMode() async {
    String? modeName = _instance.shp.getString('mode');
    switch (modeName) {
      case 'dark':
        ThemeConfig.mode = ThemeMode.dark;
      case 'light':
        ThemeConfig.mode = ThemeMode.light;
      default:
        ThemeConfig.mode = ThemeMode.dark;
    }
  }

  Future<void> getTheme() async {
    await _instance.getMode();
    ThemeConfig.mode == ThemeMode.dark
        ? ThemeConfig.theme = _darkTheme
        : ThemeConfig.theme = _lightTheme;
  }

  final ThemeData _lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    focusColor: Colors.grey[200],
    cardColor: Colors.yellow[100],
    secondaryHeaderColor: Colors.blue,
    hintColor: Colors.grey[400],
    textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.blue)),
    iconTheme: IconThemeData(color: Colors.blue),
    dividerColor: Colors.yellow[100],
  );
  final ThemeData _darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 22, 22, 22),
    focusColor: const Color.fromARGB(255, 38, 38, 38),
    cardColor: Colors.white38,
    secondaryHeaderColor: Colors.yellow,
    hintColor: const Color.fromARGB(255, 97, 97, 97),
    textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.yellow)),
    iconTheme: IconThemeData(color: Colors.yellow),
    dividerColor: Colors.white38,
  );
}
