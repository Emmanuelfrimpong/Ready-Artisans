import 'package:hive_flutter/adapters.dart';

class HiveApi {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('navigation');
  }
}
