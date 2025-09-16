import '../../core/config/theme_config.dart';

void logger(String? message) {
  // ignore: avoid_print
  print('\x1B[34m [logger] → $message\x1B[0m');
}

Future<void> initServices() async {
  await ThemeConfig.init();
}
