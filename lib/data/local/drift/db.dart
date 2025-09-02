import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'tables.dart';

part 'db.g.dart';

@DriftDatabase(tables: [
  Customers,
  Visits,
  Products,
  Orders,
  OrderItems,
  TrackingLocations,
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

  Future<void> insertOrder(OrderEntity order) =>
      into(orders).insertOnConflictUpdate(order);

  Future<void> insertOrderItems(List<OrderItemEntity> items) => batch((batch) {
        batch.insertAllOnConflictUpdate(orderItems, items);
      });

  // Tracking
  Future<void> insertTrackingLocation(TrackingEntity location) =>
      into(trackingLocations).insert(location);

  Future<List<TrackingEntity>> getPendingSyncTracking() =>
      (select(trackingLocations)..where((t) => t.needsSync.equals(true))).get();

  Future<void> markTrackingSynced(List<int> ids) =>
      (update(trackingLocations)..where((t) => t.id.isIn(ids)))
          .write(const TrackingLocationsCompanion(needsSync: Value(false)));

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
