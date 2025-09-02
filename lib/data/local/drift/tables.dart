import 'package:drift/drift.dart';

@DataClassName('CustomerEntity')
class Customers extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get code => text().nullable()();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  RealColumn get geoAccuracyM => real().nullable()();
  TextColumn get createdBy => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  BoolColumn get needsSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('VisitEntity')
class Visits extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get customerId => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get purpose => text()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get finishedAt => dateTime().nullable()();
  RealColumn get checkinLatitude => real().nullable()();
  RealColumn get checkinLongitude => real().nullable()();
  RealColumn get checkoutLatitude => real().nullable()();
  RealColumn get checkoutLongitude => real().nullable()();
  RealColumn get checkinAccuracyM => real().nullable()();
  RealColumn get checkoutAccuracyM => real().nullable()();
  RealColumn get distanceM => real().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ProductEntity')
class Products extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get sku => text().nullable()();
  TextColumn get name => text()();
  TextColumn get unit => text().nullable()();
  RealColumn get tax => real().withDefault(const Constant(0))();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('OrderEntity')
class Orders extends Table {
  TextColumn get id => text()();
  TextColumn get companyId => text()();
  TextColumn get customerId => text().nullable()();
  TextColumn get userId => text().nullable()();
  TextColumn get priceListId => text().nullable()();
  TextColumn get status => text()();
  RealColumn get subtotal => real().withDefault(const Constant(0))();
  RealColumn get taxTotal => real().withDefault(const Constant(0))();
  RealColumn get discountTotal => real().withDefault(const Constant(0))();
  RealColumn get grandTotal => real().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().nullable()();
  BoolColumn get needsSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('OrderItemEntity')
class OrderItems extends Table {
  TextColumn get id => text()();
  TextColumn get orderId => text()();
  TextColumn get productId => text()();
  RealColumn get qty => real()();
  RealColumn get price => real()();
  RealColumn get discount => real().withDefault(const Constant(0))();
  RealColumn get total => real()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TrackingEntity')
class TrackingLocations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get companyId => text()();
  TextColumn get userId => text()();
  DateTimeColumn get at => dateTime()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get speedMs => real().nullable()();
  RealColumn get accuracyM => real().nullable()();
  BoolColumn get needsSync => boolean().withDefault(const Constant(false))();
}
