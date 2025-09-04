import 'dart:async';
import 'dart:isolate';

import 'package:geolocator/geolocator.dart';

import '../../config/logger.dart';
import '../../data/models/geo/location_sample.dart';

class BackgroundLocationService {
  static const String _isolateName = 'LocationIsolate';
  static const String _portName = 'LocationPort';

  static ReceivePort? _receivePort;
  static SendPort? _sendPort;
  static StreamSubscription<Position>? _locationSubscription;
  static bool _isRunning = false;

  static Future<bool> start() async {
    if (_isRunning) return true;

    try {
      // Check permissions
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        logger.w('Location permission not granted for background tracking');
        return false;
      }

      // Initialize isolate communication
      _receivePort = ReceivePort();
      final isolateReady = Completer<bool>();

      _receivePort!.listen((data) {
        if (data is SendPort) {
          _sendPort = data;
          isolateReady.complete(true);
        } else if (data is Map) {
          _handleLocationUpdate(Map<String, dynamic>.from(data));
        }
      });

      // Start isolate
      await Isolate.spawn(
        _locationIsolateEntryPoint,
        _receivePort!.sendPort,
        debugName: _isolateName,
      );

      await isolateReady.future;
      _isRunning = true;

      logger.i('Background location service started');
      return true;
    } catch (e) {
      logger.e('Failed to start background location service: $e');
      return false;
    }
  }

  static Future<void> stop() async {
    if (!_isRunning) return;

    try {
      _sendPort?.send({'command': 'stop'});
      _receivePort?.close();
      _locationSubscription?.cancel();

      _receivePort = null;
      _sendPort = null;
      _locationSubscription = null;
      _isRunning = false;

      logger.i('Background location service stopped');
    } catch (e) {
      logger.e('Error stopping background location service: $e');
    }
  }

  static void _locationIsolateEntryPoint(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    StreamSubscription<Position>? locationSubscription;

    receivePort.listen((data) async {
      if (data is Map && data['command'] == 'stop') {
        locationSubscription?.cancel();
        Isolate.exit();
      }
    });

    // Start location tracking in isolate
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // meters
      timeLimit: Duration(seconds: 30),
    );

    locationSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(
      (position) {
        sendPort.send({
          'latitude': position.latitude,
          'longitude': position.longitude,
          'accuracy': position.accuracy,
          'speed': position.speed,
          'timestamp': position.timestamp.millisecondsSinceEpoch,
        });
      },
      onError: (error) {
        sendPort.send({'error': error.toString()});
      },
    );
  }

  static void _handleLocationUpdate(Map<String, dynamic> data) {
    if (data.containsKey('error')) {
      logger.e('Background location error: ${data['error']}');
      return;
    }

    try {
      final locationSample = LocationSample(
        id: DateTime.now().millisecondsSinceEpoch,
        companyId: 'current_company_id', // TODO: Get from auth
        userId: 'current_user_id', // TODO: Get from auth
        at: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
        latitude: data['latitude'],
        longitude: data['longitude'],
        speedMs: data['speed'],
        accuracyM: data['accuracy'],
      );

      // Save to local database (this would need to be done through a service)
      // TrackingRepository().saveLocationSample(locationSample);
    } catch (e) {
      logger.e('Error handling location update: $e');
    }
  }

  static bool get isRunning => _isRunning;
}
