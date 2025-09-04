import 'dart:async';

// import 'package:firebase_messaging/firebase_messaging.dart'; // Temporarily commented out
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'config/env.dart';
import 'config/logger.dart';
import 'data/local/drift/db.dart';
import 'data/local/hive/boxes.dart';
import 'data/local/preferences.dart';
// import 'services/notifications/fcm_service.dart'; // Temporarily commented out

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  final stopwatch = Stopwatch()..start();

  print(' BOOTSTRAP: Iniciando...');

  // Load environment variables
  print(' Cargando .env...');
  try {
    await dotenv.load();
    print(' .env cargado en ${stopwatch.elapsedMilliseconds}ms');
  } catch (e) {
    print('⚠️  No se pudo cargar .env: $e');
    print('⚠️  Usando valores por defecto de config/env.dart');
  }

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Hive (crítico para rendimiento)
  print(' Inicializando Hive...');
  await Hive.initFlutter();
  await HiveBoxes.init();
  print(' Hive inicializado en ${stopwatch.elapsedMilliseconds}ms');

  // Initialize AppPreferences
  print(' Inicializando AppPreferences...');
  await AppPreferences.init();
  print(' AppPreferences inicializado en ${stopwatch.elapsedMilliseconds}ms');

  // Initialize Supabase (puede ser lento)
  print('☁️ Inicializando Supabase...');
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );
  print(' Supabase inicializado en ${stopwatch.elapsedMilliseconds}ms');

  // Request location permissions (mover a background)
  print(' Solicitando permisos...');
  _requestLocationPermissionsInBackground();

  // Initialize Database
  print(' Inicializando base de datos...');
  await DatabaseHelper.instance.initialize();
  print(' Base de datos inicializada en ${stopwatch.elapsedMilliseconds}ms');

  // Initialize Firebase Messaging - Temporarily commented out
  // TODO: Configure Firebase properly with google-services.json and firebase_options.dart
  // await Firebase.initializeApp();
  // await FirebaseMessaging.instance.requestPermission();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize Local Notifications (mover a background)
  print(' Inicializando notificaciones...');
  _initializeNotificationsInBackground();

  stopwatch.stop();
  print(' BOOTSTRAP completado en ${stopwatch.elapsedMilliseconds}ms');

  // Handle errors
  FlutterError.onError = (details) {
    logger.e('Flutter Error',
        error: details.exception, stackTrace: details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.e('Platform Error', error: error, stackTrace: stack);
    return true;
  };

  runApp(const ArsenalSellApp());
}

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Supabase.initialize(
//     url: Env.supabaseUrl,
//     anonKey: Env.supabaseAnonKey,
//   );
//   await FCMService.handleBackgroundMessage(message);
// }

// Mover permisos a background para no bloquear la inicialización
void _requestLocationPermissionsInBackground() {
  Future.delayed(const Duration(seconds: 2), () async {
    try {
      final locationStatus = await Permission.location.request();
      if (locationStatus.isGranted) {
        logger.i('Location permission granted');
        await Permission.locationAlways.request();
      }

      await Permission.notification.request();
    } catch (e) {
      logger.e('Error requesting permissions: $e');
    }
  });
}

// Mover notificaciones a background
void _initializeNotificationsInBackground() {
  Future.delayed(const Duration(seconds: 1), () async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
    print('✅ Notificaciones inicializadas en background');
  });
}
