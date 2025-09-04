import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '../../../config/logger.dart';
import 'tables.dart';

part 'db.g.dart';

@DriftDatabase(tables: [
  Customers,
  Visits,
  Products,
  Orders,
  OrderItems,
  TrackingLocations,
  Deliveries,
  Payments,
])
class DatabaseHelper extends _$DatabaseHelper {
  DatabaseHelper._internal() : super(_openConnection());

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static DatabaseHelper get instance => _instance;

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();

          // Create indexes
          await customStatement('''
        CREATE INDEX IF NOT EXISTS customers_company_idx 
        ON customers(company_id);
      ''');

          await customStatement('''
        CREATE INDEX IF NOT EXISTS visits_customer_idx 
        ON visits(customer_id, started_at DESC);
      ''');

          await customStatement('''
        CREATE INDEX IF NOT EXISTS tracking_user_time_idx 
        ON tracking_locations(user_id, at DESC);
      ''');
        },
        beforeOpen: (details) async {
          if (Platform.isAndroid) {
            await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
          }

          // Enable foreign keys
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  /// Initialize database and ensure all tables exist
  Future<void> initialize() async {
    try {
      // Check if all tables exist
      final tables = await _checkTablesExist();

      if (!(tables['payments'] ?? false) || !(tables['deliveries'] ?? false)) {
        logger.w('Missing tables detected, recreating database...');
        await _recreateDatabase();
      }

      logger.i('Database initialized successfully');
    } catch (e) {
      logger.e('Database initialization error: $e');
      rethrow;
    }
  }

  /// Check if all required tables exist
  Future<Map<String, bool>> _checkTablesExist() async {
    try {
      final result = await customSelect('''
        SELECT name FROM sqlite_master 
        WHERE type='table' AND name IN ('customers', 'visits', 'products', 'orders', 'order_items', 'tracking_locations', 'deliveries', 'payments')
      ''').get();

      final existingTables =
          result.map((row) => row.data['name'] as String).toSet();

      return {
        'customers': existingTables.contains('customers'),
        'visits': existingTables.contains('visits'),
        'products': existingTables.contains('products'),
        'orders': existingTables.contains('orders'),
        'order_items': existingTables.contains('order_items'),
        'tracking_locations': existingTables.contains('tracking_locations'),
        'deliveries': existingTables.contains('deliveries'),
        'payments': existingTables.contains('payments'),
      };
    } catch (e) {
      logger.e('Error checking tables: $e');
      return {};
    }
  }

  /// Recreate database with all tables
  Future<void> _recreateDatabase() async {
    try {
      // Drop all tables
      await customStatement('DROP TABLE IF EXISTS payments');
      await customStatement('DROP TABLE IF EXISTS deliveries');
      await customStatement('DROP TABLE IF EXISTS tracking_locations');
      await customStatement('DROP TABLE IF EXISTS order_items');
      await customStatement('DROP TABLE IF EXISTS orders');
      await customStatement('DROP TABLE IF EXISTS products');
      await customStatement('DROP TABLE IF EXISTS visits');
      await customStatement('DROP TABLE IF EXISTS customers');

      // Recreate all tables
      await customStatement('''
        CREATE TABLE customers (
          id TEXT PRIMARY KEY,
          company_id TEXT NOT NULL,
          code TEXT,
          name TEXT NOT NULL,
          email TEXT,
          phone TEXT,
          address TEXT,
          latitude REAL,
          longitude REAL,
          geo_accuracy_m REAL,
          created_by TEXT,
          created_at INTEGER,
          updated_at INTEGER,
          needs_sync INTEGER NOT NULL DEFAULT 0
        )
      ''');

      await customStatement('''
        CREATE TABLE visits (
          id TEXT PRIMARY KEY,
          company_id TEXT NOT NULL,
          customer_id TEXT NOT NULL,
          user_id TEXT,
          purpose TEXT NOT NULL,
          started_at INTEGER,
          finished_at INTEGER,
          checkin_latitude REAL,
          checkin_longitude REAL,
          checkout_latitude REAL,
          checkout_longitude REAL,
          checkin_accuracy_m REAL,
          checkout_accuracy_m REAL,
          distance_m REAL,
          notes TEXT,
          is_synced INTEGER NOT NULL DEFAULT 0
        )
      ''');

      await customStatement('''
        CREATE TABLE products (
          id TEXT PRIMARY KEY,
          company_id TEXT NOT NULL,
          sku TEXT,
          name TEXT NOT NULL,
          unit TEXT,
          tax REAL NOT NULL DEFAULT 0,
          active INTEGER NOT NULL DEFAULT 1,
          created_at INTEGER
        )
      ''');

      await customStatement('''
        CREATE TABLE orders (
          id TEXT PRIMARY KEY,
          company_id TEXT NOT NULL,
          customer_id TEXT,
          user_id TEXT,
          price_list_id TEXT,
          status TEXT NOT NULL,
          subtotal REAL NOT NULL DEFAULT 0,
          tax_total REAL NOT NULL DEFAULT 0,
          discount_total REAL NOT NULL DEFAULT 0,
          grand_total REAL NOT NULL DEFAULT 0,
          created_at INTEGER,
          needs_sync INTEGER NOT NULL DEFAULT 0
        )
      ''');

      await customStatement('''
        CREATE TABLE order_items (
          id TEXT PRIMARY KEY,
          order_id TEXT NOT NULL,
          product_id TEXT NOT NULL,
          qty REAL NOT NULL,
          price REAL NOT NULL,
          discount REAL NOT NULL DEFAULT 0,
          total REAL NOT NULL
        )
      ''');

      await customStatement('''
        CREATE TABLE tracking_locations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          company_id TEXT NOT NULL,
          user_id TEXT NOT NULL,
          at INTEGER NOT NULL,
          latitude REAL NOT NULL,
          longitude REAL NOT NULL,
          speed_ms REAL,
          accuracy_m REAL,
          needs_sync INTEGER NOT NULL DEFAULT 0
        )
      ''');

      await customStatement('''
        CREATE TABLE deliveries (
          id TEXT PRIMARY KEY,
          company_id TEXT NOT NULL,
          order_id TEXT NOT NULL,
          customer_id TEXT,
          user_id TEXT,
          status TEXT NOT NULL,
          delivered_at INTEGER,
          notes TEXT,
          created_at INTEGER,
          needs_sync INTEGER NOT NULL DEFAULT 0
        )
      ''');

      await customStatement('''
        CREATE TABLE payments (
          id TEXT PRIMARY KEY,
          company_id TEXT NOT NULL,
          customer_id TEXT NOT NULL,
          order_id TEXT,
          user_id TEXT,
          type TEXT NOT NULL,
          amount REAL NOT NULL,
          method TEXT,
          reference TEXT,
          notes TEXT,
          paid_at INTEGER,
          created_at INTEGER,
          needs_sync INTEGER NOT NULL DEFAULT 0
        )
      ''');

      // Create indexes
      await customStatement('''
        CREATE INDEX IF NOT EXISTS customers_company_idx 
        ON customers(company_id);
      ''');

      await customStatement('''
        CREATE INDEX IF NOT EXISTS visits_customer_idx 
        ON visits(customer_id, started_at DESC);
      ''');

      await customStatement('''
        CREATE INDEX IF NOT EXISTS tracking_user_time_idx 
        ON tracking_locations(user_id, at DESC);
      ''');

      logger.i('Database recreated successfully');
    } catch (e) {
      logger.e('Error recreating database: $e');
      rethrow;
    }
  }

  // Customers
  Future<List<CustomerEntity>> getAllCustomers() => select(customers).get();

  Future<CustomerEntity?> getCustomerById(String id) =>
      (select(customers)..where((c) => c.id.equals(id))).getSingleOrNull();

  Future<void> insertCustomer(CustomerEntity customer) =>
      into(customers).insertOnConflictUpdate(customer);

  Future<void> insertCustomers(List<CustomerEntity> customerList) =>
      batch((batch) {
        batch.insertAllOnConflictUpdate(customers, customerList);
      });

  // Visits
  Future<List<VisitEntity>> getVisitsByCustomer(String customerId) =>
      (select(visits)..where((v) => v.customerId.equals(customerId))).get();

  Future<List<VisitEntity>> getPendingSyncVisits() =>
      (select(visits)..where((v) => v.isSynced.equals(false))).get();

  Future<void> insertVisit(VisitEntity visit) =>
      into(visits).insertOnConflictUpdate(visit);

  Future<void> markVisitSynced(String visitId) =>
      (update(visits)..where((v) => v.id.equals(visitId)))
          .write(const VisitsCompanion(isSynced: Value(true)));

  // Products
  Future<List<ProductEntity>> getAllProducts() => select(products).get();

  Future<void> insertProducts(List<ProductEntity> productList) =>
      batch((batch) {
        batch.insertAllOnConflictUpdate(products, productList);
      });

  // Orders
  Future<List<OrderEntity>> getPendingSyncOrders() =>
      (select(orders)..where((o) => o.needsSync.equals(true))).get();

  Future<List<OrderEntity>> getAllOrders() => select(orders).get();

  Future<OrderEntity?> getOrderById(String id) =>
      (select(orders)..where((o) => o.id.equals(id))).getSingleOrNull();

  Future<List<OrderEntity>> getOrdersByCustomer(String customerId) =>
      (select(orders)..where((o) => o.customerId.equals(customerId))).get();

  Future<List<OrderEntity>> getOrdersByStatus(String status) =>
      (select(orders)..where((o) => o.status.equals(status))).get();

  Future<void> insertOrder(OrderEntity order) =>
      into(orders).insertOnConflictUpdate(order);

  Future<void> insertOrderItems(List<OrderItemEntity> items) => batch((batch) {
        batch.insertAllOnConflictUpdate(orderItems, items);
      });

  Future<void> updateOrderStatus(String orderId, String status) =>
      (update(orders)..where((o) => o.id.equals(orderId)))
          .write(OrdersCompanion(status: Value(status)));

  Future<void> deleteOrder(String orderId) =>
      (delete(orders)..where((o) => o.id.equals(orderId))).go();

  Future<void> deleteOrderItems(String orderId) =>
      (delete(orderItems)..where((i) => i.orderId.equals(orderId))).go();

  // Order Items
  Future<List<OrderItemEntity>> getOrderItems(String orderId) =>
      (select(orderItems)..where((i) => i.orderId.equals(orderId))).get();

  Future<OrderItemEntity?> getOrderItemById(String id) =>
      (select(orderItems)..where((i) => i.id.equals(id))).getSingleOrNull();

  Future<void> insertOrderItem(OrderItemEntity item) =>
      into(orderItems).insertOnConflictUpdate(item);

  Future<void> updateOrderItem(OrderItemEntity item) =>
      (update(orderItems)..where((i) => i.id.equals(item.id)))
          .write(OrderItemsCompanion(
        qty: Value(item.qty),
        price: Value(item.price),
        discount: Value(item.discount),
        total: Value(item.total),
      ));

  Future<void> deleteOrderItem(String itemId) =>
      (delete(orderItems)..where((i) => i.id.equals(itemId))).go();

  // Tracking
  Future<void> insertTrackingLocation(TrackingEntity location) =>
      into(trackingLocations).insert(location);

  Future<List<TrackingEntity>> getPendingSyncTracking() =>
      (select(trackingLocations)..where((t) => t.needsSync.equals(true))).get();

  Future<void> markTrackingSynced(List<int> ids) =>
      (update(trackingLocations)..where((t) => t.id.isIn(ids)))
          .write(const TrackingLocationsCompanion(needsSync: Value(false)));

  // Deliveries
  Future<List<DeliveryEntity>> getAllDeliveries() => select(deliveries).get();

  Future<List<DeliveryEntity>> getDeliveriesByStatus(String status) =>
      (select(deliveries)..where((d) => d.status.equals(status))).get();

  Future<List<DeliveryEntity>> getDeliveriesByCustomer(String customerId) =>
      (select(deliveries)..where((d) => d.customerId.equals(customerId))).get();

  Future<DeliveryEntity?> getDeliveryById(String id) =>
      (select(deliveries)..where((d) => d.id.equals(id))).getSingleOrNull();

  Future<void> insertDelivery(DeliveryEntity delivery) =>
      into(deliveries).insertOnConflictUpdate(delivery);

  Future<void> updateDeliveryStatus(String deliveryId, String status) =>
      (update(deliveries)..where((d) => d.id.equals(deliveryId)))
          .write(DeliveriesCompanion(status: Value(status)));

  Future<void> markDeliverySynced(String deliveryId) =>
      (update(deliveries)..where((d) => d.id.equals(deliveryId)))
          .write(const DeliveriesCompanion(needsSync: Value(false)));

  // Payments
  Future<List<PaymentEntity>> getAllPayments() => select(payments).get();

  Future<List<PaymentEntity>> getPaymentsByCustomer(String customerId) =>
      (select(payments)..where((p) => p.customerId.equals(customerId))).get();

  Future<List<PaymentEntity>> getPaymentsByOrder(String orderId) =>
      (select(payments)..where((p) => p.orderId.equals(orderId))).get();

  Future<PaymentEntity?> getPaymentById(String id) =>
      (select(payments)..where((p) => p.id.equals(id))).getSingleOrNull();

  Future<void> insertPayment(PaymentEntity payment) =>
      into(payments).insertOnConflictUpdate(payment);

  Future<void> markPaymentSynced(String paymentId) =>
      (update(payments)..where((p) => p.id.equals(paymentId)))
          .write(const PaymentsCompanion(needsSync: Value(false)));

  // Cleanup old data
  Future<void> cleanupOldTracking() async {
    final cutoff = DateTime.now().subtract(const Duration(days: 7));
    await (delete(trackingLocations)
          ..where((t) => t.at.isSmallerThanValue(cutoff)))
        .go();
  }
}

LazyDatabase _openConnection() => LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'arsenal_sell.db'));

      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      final cachebase = (await getTemporaryDirectory()).path;
      sqlite3.tempDirectory = cachebase;

      return NativeDatabase.createInBackground(file);
    });
