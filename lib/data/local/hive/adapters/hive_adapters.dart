import 'package:hive_flutter/hive_flutter.dart';
import '../../../models/auth/user_profile.dart';
import '../../../models/customers/customer.dart';
import '../../../models/visits/visit.dart';
import '../../../models/sales/order.dart';
import '../../../models/sales/product.dart';
import '../../../models/geo/location_sample.dart';
import '../../../models/geo/geofence.dart';

class HiveAdapters {
  static Future<void> registerAdapters() async {
    // Register enum adapters
    Hive.registerAdapter(UserRoleAdapter());
    Hive.registerAdapter(VisitPurposeAdapter());
    Hive.registerAdapter(OrderStatusAdapter());
    Hive.registerAdapter(GeofenceTypeAdapter());
    Hive.registerAdapter(GeofenceEventTypeAdapter());

    // Register model adapters
    Hive.registerAdapter(UserProfileHiveAdapter());
    Hive.registerAdapter(CustomerHiveAdapter());
    Hive.registerAdapter(VisitHiveAdapter());
    Hive.registerAdapter(OrderHiveAdapter());
    Hive.registerAdapter(ProductHiveAdapter());
    Hive.registerAdapter(LocationSampleHiveAdapter());
    Hive.registerAdapter(GeofenceHiveAdapter());

    // Register helper adapters
    Hive.registerAdapter(DateTimeAdapter());
  }
}

// Enum Adapters
class UserRoleAdapter extends TypeAdapter<UserRole> {
  @override
  final int typeId = 0;

  @override
  UserRole read(BinaryReader reader) => UserRole.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, UserRole obj) {
    writer.writeByte(obj.index);
  }
}

class VisitPurposeAdapter extends TypeAdapter<VisitPurpose> {
  @override
  final int typeId = 1;

  @override
  VisitPurpose read(BinaryReader reader) =>
      VisitPurpose.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, VisitPurpose obj) {
    writer.writeByte(obj.index);
  }
}

class OrderStatusAdapter extends TypeAdapter<OrderStatus> {
  @override
  final int typeId = 2;

  @override
  OrderStatus read(BinaryReader reader) =>
      OrderStatus.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, OrderStatus obj) {
    writer.writeByte(obj.index);
  }
}

class GeofenceTypeAdapter extends TypeAdapter<GeofenceType> {
  @override
  final int typeId = 3;

  @override
  GeofenceType read(BinaryReader reader) =>
      GeofenceType.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, GeofenceType obj) {
    writer.writeByte(obj.index);
  }
}

class GeofenceEventTypeAdapter extends TypeAdapter<GeofenceEventType> {
  @override
  final int typeId = 4;

  @override
  GeofenceEventType read(BinaryReader reader) =>
      GeofenceEventType.values[reader.readByte()];

  @override
  void write(BinaryWriter writer, GeofenceEventType obj) {
    writer.writeByte(obj.index);
  }
}

// Model Adapters
class UserProfileHiveAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 10;

  @override
  UserProfile read(BinaryReader reader) {
    final map = Map<String, dynamic>.from(reader.read());
    return UserProfile.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer.write(obj.toJson());
  }
}

class CustomerHiveAdapter extends TypeAdapter<Customer> {
  @override
  final int typeId = 11;

  @override
  Customer read(BinaryReader reader) {
    final map = Map<String, dynamic>.from(reader.read());
    return Customer.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer.write(obj.toJson());
  }
}

class VisitHiveAdapter extends TypeAdapter<Visit> {
  @override
  final int typeId = 12;

  @override
  Visit read(BinaryReader reader) {
    final map = Map<String, dynamic>.from(reader.read());
    return Visit.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, Visit obj) {
    writer.write(obj.toJson());
  }
}

class OrderHiveAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 13;

  @override
  Order read(BinaryReader reader) {
    final map = Map<String, dynamic>.from(reader.read());
    return Order.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer.write(obj.toJson());
  }
}

class ProductHiveAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 14;

  @override
  Product read(BinaryReader reader) {
    final map = Map<String, dynamic>.from(reader.read());
    return Product.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.write(obj.toJson());
  }
}

class LocationSampleHiveAdapter extends TypeAdapter<LocationSample> {
  @override
  final int typeId = 15;

  @override
  LocationSample read(BinaryReader reader) {
    final map = Map<String, dynamic>.from(reader.read());
    return LocationSample.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, LocationSample obj) {
    writer.write(obj.toJson());
  }
}

class GeofenceHiveAdapter extends TypeAdapter<Geofence> {
  @override
  final int typeId = 16;

  @override
  Geofence read(BinaryReader reader) {
    final data = reader.read();
    if (data is Map) {
      return Geofence.fromJson(Map<String, dynamic>.from(data));
    }
    // Fallback for dynamic data
    return (data as dynamic) as Geofence;
  }

  @override
  void write(BinaryWriter writer, Geofence obj) {
    // Store the object directly - Hive will handle serialization
    writer.write(obj);
  }
}

// Helper Adapters
class DateTimeAdapter extends TypeAdapter<DateTime> {
  @override
  final int typeId = 20;

  @override
  DateTime read(BinaryReader reader) =>
      DateTime.fromMillisecondsSinceEpoch(reader.readInt());

  @override
  void write(BinaryWriter writer, DateTime obj) {
    writer.writeInt(obj.millisecondsSinceEpoch);
  }
}

// Sync Item Adapter for offline queue
class SyncItemHiveAdapter extends TypeAdapter<SyncItemData> {
  @override
  final int typeId = 21;

  @override
  SyncItemData read(BinaryReader reader) {
    final map = Map<String, dynamic>.from(reader.read());
    return SyncItemData.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, SyncItemData obj) {
    writer.write(obj.toJson());
  }
}

// Helper class for sync queue items
class SyncItemData {
  SyncItemData({
    required this.id,
    required this.type,
    required this.data,
    required this.createdAt,
    this.retryCount = 0,
    this.error,
  });

  factory SyncItemData.fromJson(Map<String, dynamic> json) => SyncItemData(
        id: json['id'],
        type: json['type'],
        data: Map<String, dynamic>.from(json['data']),
        createdAt: DateTime.parse(json['createdAt']),
        retryCount: json['retryCount'] ?? 0,
        error: json['error'],
      );
  final String id;
  final String type;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  final int retryCount;
  final String? error;

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'data': data,
        'createdAt': createdAt.toIso8601String(),
        'retryCount': retryCount,
        'error': error,
      };

  SyncItemData copyWith({
    String? id,
    String? type,
    Map<String, dynamic>? data,
    DateTime? createdAt,
    int? retryCount,
    String? error,
  }) =>
      SyncItemData(
        id: id ?? this.id,
        type: type ?? this.type,
        data: data ?? this.data,
        createdAt: createdAt ?? this.createdAt,
        retryCount: retryCount ?? this.retryCount,
        error: error ?? this.error,
      );
}

// Cache Entry Adapter for caching API responses
class CacheEntryHiveAdapter extends TypeAdapter<CacheEntry> {
  @override
  final int typeId = 22;

  @override
  CacheEntry read(BinaryReader reader) {
    final map = Map<String, dynamic>.from(reader.read());
    return CacheEntry.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, CacheEntry obj) {
    writer.write(obj.toJson());
  }
}

class CacheEntry {
  CacheEntry({
    required this.key,
    required this.data,
    required this.createdAt,
    this.expiresAt,
  });

  factory CacheEntry.fromJson(Map<String, dynamic> json) => CacheEntry(
        key: json['key'],
        data: json['data'],
        createdAt: DateTime.parse(json['createdAt']),
        expiresAt: json['expiresAt'] != null
            ? DateTime.parse(json['expiresAt'])
            : null,
      );
  final String key;
  final dynamic data;
  final DateTime createdAt;
  final DateTime? expiresAt;

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'data': data,
        'createdAt': createdAt.toIso8601String(),
        'expiresAt': expiresAt?.toIso8601String(),
      };
}

// Settings Adapter for app preferences
class AppSettingsHiveAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 23;

  @override
  AppSettings read(BinaryReader reader) {
    final map = Map<String, dynamic>.from(reader.read());
    return AppSettings.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer.write(obj.toJson());
  }
}

class AppSettings {
  AppSettings({
    this.enableNotifications = true,
    this.enableLocationTracking = true,
    this.enableOfflineMode = true,
    this.syncInterval = 15,
    this.lastSyncAt,
    this.userPreferences = const {},
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        enableNotifications: json['enableNotifications'] ?? true,
        enableLocationTracking: json['enableLocationTracking'] ?? true,
        enableOfflineMode: json['enableOfflineMode'] ?? true,
        syncInterval: json['syncInterval'] ?? 15,
        lastSyncAt: json['lastSyncAt'],
        userPreferences:
            Map<String, dynamic>.from(json['userPreferences'] ?? {}),
      );
  final bool enableNotifications;
  final bool enableLocationTracking;
  final bool enableOfflineMode;
  final int syncInterval; // in minutes
  final String? lastSyncAt;
  final Map<String, dynamic> userPreferences;

  Map<String, dynamic> toJson() => {
        'enableNotifications': enableNotifications,
        'enableLocationTracking': enableLocationTracking,
        'enableOfflineMode': enableOfflineMode,
        'syncInterval': syncInterval,
        'lastSyncAt': lastSyncAt,
        'userPreferences': userPreferences,
      };

  AppSettings copyWith({
    bool? enableNotifications,
    bool? enableLocationTracking,
    bool? enableOfflineMode,
    int? syncInterval,
    String? lastSyncAt,
    Map<String, dynamic>? userPreferences,
  }) =>
      AppSettings(
        enableNotifications: enableNotifications ?? this.enableNotifications,
        enableLocationTracking:
            enableLocationTracking ?? this.enableLocationTracking,
        enableOfflineMode: enableOfflineMode ?? this.enableOfflineMode,
        syncInterval: syncInterval ?? this.syncInterval,
        lastSyncAt: lastSyncAt ?? this.lastSyncAt,
        userPreferences: userPreferences ?? this.userPreferences,
      );
}
