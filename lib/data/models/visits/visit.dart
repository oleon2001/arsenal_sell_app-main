import 'package:freezed_annotation/freezed_annotation.dart';
import '../customers/customer.dart';
import 'visit_photo.dart';
import 'signature.dart';

// Commented out until generated files are available
// part 'visit.freezed.dart';
// part 'visit.g.dart';

enum VisitPurpose {
  @JsonValue('VENTA')
  venta,
  @JsonValue('COBRO')
  cobro,
  @JsonValue('ENTREGA')
  entrega,
  @JsonValue('VISITA')
  visita,
  @JsonValue('AUDITORIA')
  auditoria,
  @JsonValue('DEVOLUCION')
  devolucion,
  @JsonValue('OTRO')
  otro,
}

// Converted from @freezed to regular class
class Visit {
  factory Visit.fromJson(Map<String, dynamic> json) => Visit(
        id: json['id'],
        companyId: json['companyId'],
        customerId: json['customerId'],
        userId: json['userId'],
        purpose:
            VisitPurpose.values.firstWhere((e) => e.name == json['purpose']),
        startedAt: json['startedAt'] != null
            ? DateTime.parse(json['startedAt'])
            : null,
        finishedAt: json['finishedAt'] != null
            ? DateTime.parse(json['finishedAt'])
            : null,
        checkinLatitude: json['checkinLatitude'],
        checkinLongitude: json['checkinLongitude'],
        checkoutLatitude: json['checkoutLatitude'],
        checkoutLongitude: json['checkoutLongitude'],
        checkinAccuracyM: json['checkinAccuracyM'],
        checkoutAccuracyM: json['checkoutAccuracyM'],
        distanceM: json['distanceM'],
        notes: json['notes'],
        isSynced: json['isSynced'] ?? false,
        customer: json['customer'] != null
            ? Customer.fromJson(json['customer'])
            : null,
        photos: (json['photos'] as List?)
                ?.map((e) => VisitPhoto.fromJson(e))
                .toList() ??
            [],
        signature: json['signature'] != null
            ? VisitSignature.fromJson(json['signature'])
            : null,
      );
  const Visit({
    required this.id,
    required this.companyId,
    required this.customerId,
    this.userId,
    required this.purpose,
    this.startedAt,
    this.finishedAt,
    this.checkinLatitude,
    this.checkinLongitude,
    this.checkoutLatitude,
    this.checkoutLongitude,
    this.checkinAccuracyM,
    this.checkoutAccuracyM,
    this.distanceM,
    this.notes,
    this.isSynced = false,
    this.customer,
    this.photos = const [],
    this.signature,
  });

  final String id;
  final String companyId;
  final String customerId;
  final String? userId;
  final VisitPurpose purpose;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final double? checkinLatitude;
  final double? checkinLongitude;
  final double? checkoutLatitude;
  final double? checkoutLongitude;
  final double? checkinAccuracyM;
  final double? checkoutAccuracyM;
  final double? distanceM;
  final String? notes;
  final bool isSynced;
  final Customer? customer;
  final List<VisitPhoto> photos;
  final VisitSignature? signature;

  Map<String, dynamic> toJson() => {
        'id': id,
        'companyId': companyId,
        'customerId': customerId,
        'userId': userId,
        'purpose': purpose.name,
        'startedAt': startedAt?.toIso8601String(),
        'finishedAt': finishedAt?.toIso8601String(),
        'checkinLatitude': checkinLatitude,
        'checkinLongitude': checkinLongitude,
        'checkoutLatitude': checkoutLatitude,
        'checkoutLongitude': checkoutLongitude,
        'checkinAccuracyM': checkinAccuracyM,
        'checkoutAccuracyM': checkoutAccuracyM,
        'distanceM': distanceM,
        'notes': notes,
        'isSynced': isSynced,
        'customer': customer?.toJson(),
        'photos': photos.map((e) => e.toJson()).toList(),
        'signature': signature?.toJson(),
      };
}
