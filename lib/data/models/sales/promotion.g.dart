// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromotionImpl _$$PromotionImplFromJson(Map<String, dynamic> json) =>
    _$PromotionImpl(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: $enumDecode(_$PromotionTypeEnumMap, json['type']),
      rules: json['rules'] as Map<String, dynamic>,
      startsAt: DateTime.parse(json['startsAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
      active: json['active'] as bool? ?? true,
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      usageLimit: (json['usageLimit'] as num?)?.toInt() ?? 0,
      usageCount: (json['usageCount'] as num?)?.toInt() ?? 0,
      applicableProducts: (json['applicableProducts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      applicableCategories: (json['applicableCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      applicableCustomers: (json['applicableCustomers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      excludedProducts: (json['excludedProducts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      excludedCustomers: (json['excludedCustomers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      minimumOrderAmount: (json['minimumOrderAmount'] as num?)?.toDouble(),
      maximumDiscount: (json['maximumDiscount'] as num?)?.toDouble(),
      applicableDays: (json['applicableDays'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$DayOfWeekEnumMap, e))
              .toList() ??
          const [],
      startTime: json['startTime'] == null
          ? null
          : TimeOfDay.fromJson(json['startTime'] as Map<String, dynamic>),
      endTime: json['endTime'] == null
          ? null
          : TimeOfDay.fromJson(json['endTime'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$$PromotionImplToJson(_$PromotionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'name': instance.name,
      'description': instance.description,
      'type': _$PromotionTypeEnumMap[instance.type]!,
      'rules': instance.rules,
      'startsAt': instance.startsAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'active': instance.active,
      'priority': instance.priority,
      'usageLimit': instance.usageLimit,
      'usageCount': instance.usageCount,
      'applicableProducts': instance.applicableProducts,
      'applicableCategories': instance.applicableCategories,
      'applicableCustomers': instance.applicableCustomers,
      'excludedProducts': instance.excludedProducts,
      'excludedCustomers': instance.excludedCustomers,
      'minimumOrderAmount': instance.minimumOrderAmount,
      'maximumDiscount': instance.maximumDiscount,
      'applicableDays':
          instance.applicableDays.map((e) => _$DayOfWeekEnumMap[e]!).toList(),
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'createdAt': instance.createdAt?.toIso8601String(),
      'createdBy': instance.createdBy,
    };

const _$PromotionTypeEnumMap = {
  PromotionType.percentageDiscount: 'PERCENTAGE_DISCOUNT',
  PromotionType.fixedDiscount: 'FIXED_DISCOUNT',
  PromotionType.buyXGetY: 'BUY_X_GET_Y',
  PromotionType.freeShipping: 'FREE_SHIPPING',
  PromotionType.bundleDiscount: 'BUNDLE_DISCOUNT',
  PromotionType.volumeDiscount: 'VOLUME_DISCOUNT',
  PromotionType.firstTimeBuyer: 'FIRST_TIME_BUYER',
  PromotionType.loyaltyDiscount: 'LOYALTY_DISCOUNT',
};

const _$DayOfWeekEnumMap = {
  DayOfWeek.monday: 1,
  DayOfWeek.tuesday: 2,
  DayOfWeek.wednesday: 3,
  DayOfWeek.thursday: 4,
  DayOfWeek.friday: 5,
  DayOfWeek.saturday: 6,
  DayOfWeek.sunday: 7,
};

_$PromotionResultImpl _$$PromotionResultImplFromJson(
        Map<String, dynamic> json) =>
    _$PromotionResultImpl(
      promotionId: json['promotionId'] as String,
      promotionName: json['promotionName'] as String,
      type: $enumDecode(_$PromotionTypeEnumMap, json['type']),
      discountAmount: (json['discountAmount'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      affectedProducts: (json['affectedProducts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      freeItems: (json['freeItems'] as List<dynamic>?)
              ?.map((e) => PromotionItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$PromotionResultImplToJson(
        _$PromotionResultImpl instance) =>
    <String, dynamic>{
      'promotionId': instance.promotionId,
      'promotionName': instance.promotionName,
      'type': _$PromotionTypeEnumMap[instance.type]!,
      'discountAmount': instance.discountAmount,
      'discountPercentage': instance.discountPercentage,
      'affectedProducts': instance.affectedProducts,
      'freeItems': instance.freeItems,
      'description': instance.description,
    };

_$PromotionItemImpl _$$PromotionItemImplFromJson(Map<String, dynamic> json) =>
    _$PromotionItemImpl(
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PromotionItemImplToJson(_$PromotionItemImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'product': instance.product,
    };

_$TimeOfDayImpl _$$TimeOfDayImplFromJson(Map<String, dynamic> json) =>
    _$TimeOfDayImpl(
      hour: (json['hour'] as num).toInt(),
      minute: (json['minute'] as num).toInt(),
    );

Map<String, dynamic> _$$TimeOfDayImplToJson(_$TimeOfDayImpl instance) =>
    <String, dynamic>{
      'hour': instance.hour,
      'minute': instance.minute,
    };
