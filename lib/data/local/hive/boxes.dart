import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxes {
  static const String settings = 'settings';
  static const String syncQueue = 'sync_queue';
  static const String cache = 'cache';

  static late Box<dynamic> settingsBox;
  static late Box<Map<dynamic, dynamic>> syncQueueBox;
  static late Box<dynamic> cacheBox;

  static Future<void> init() async {
    settingsBox = await Hive.openBox(settings);
    syncQueueBox = await Hive.openBox<Map<dynamic, dynamic>>(syncQueue);
    cacheBox = await Hive.openBox(cache);
  }

  static Future<void> close() async {
    await settingsBox.close();
    await syncQueueBox.close();
    await cacheBox.close();
  }
}
