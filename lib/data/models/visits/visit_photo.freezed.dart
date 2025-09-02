// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VisitPhoto _$VisitPhotoFromJson(Map<String, dynamic> json) {
  return _VisitPhoto.fromJson(json);
}

/// @nodoc
mixin _$VisitPhoto {
  String get id => throw _privateConstructorUsedError;
  String get visitId => throw _privateConstructorUsedError;
  String get storagePath => throw _privateConstructorUsedError;
  String? get localPath => throw _privateConstructorUsedError;
  String? get publicUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  PhotoType get type => throw _privateConstructorUsedError;
  PhotoStatus get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get uploadedAt => throw _privateConstructorUsedError;
  int get fileSize => throw _privateConstructorUsedError; // in bytes
  String? get mimeType => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  bool get isRequired => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VisitPhotoCopyWith<VisitPhoto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitPhotoCopyWith<$Res> {
  factory $VisitPhotoCopyWith(
          VisitPhoto value, $Res Function(VisitPhoto) then) =
      _$VisitPhotoCopyWithImpl<$Res, VisitPhoto>;
  @useResult
  $Res call(
      {String id,
      String visitId,
      String storagePath,
      String? localPath,
      String? publicUrl,
      String? description,
      PhotoType type,
      PhotoStatus status,
      DateTime? createdAt,
      DateTime? uploadedAt,
      int fileSize,
      String? mimeType,
      double? latitude,
      double? longitude,
      bool isRequired,
      bool isSynced});
}

/// @nodoc
class _$VisitPhotoCopyWithImpl<$Res, $Val extends VisitPhoto>
    implements $VisitPhotoCopyWith<$Res> {
  _$VisitPhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? visitId = null,
    Object? storagePath = null,
    Object? localPath = freezed,
    Object? publicUrl = freezed,
    Object? description = freezed,
    Object? type = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? uploadedAt = freezed,
    Object? fileSize = null,
    Object? mimeType = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isRequired = null,
    Object? isSynced = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      visitId: null == visitId
          ? _value.visitId
          : visitId // ignore: cast_nullable_to_non_nullable
              as String,
      storagePath: null == storagePath
          ? _value.storagePath
          : storagePath // ignore: cast_nullable_to_non_nullable
              as String,
      localPath: freezed == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      publicUrl: freezed == publicUrl
          ? _value.publicUrl
          : publicUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PhotoType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PhotoStatus,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      uploadedAt: freezed == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fileSize: null == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int,
      mimeType: freezed == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VisitPhotoImplCopyWith<$Res>
    implements $VisitPhotoCopyWith<$Res> {
  factory _$$VisitPhotoImplCopyWith(
          _$VisitPhotoImpl value, $Res Function(_$VisitPhotoImpl) then) =
      __$$VisitPhotoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String visitId,
      String storagePath,
      String? localPath,
      String? publicUrl,
      String? description,
      PhotoType type,
      PhotoStatus status,
      DateTime? createdAt,
      DateTime? uploadedAt,
      int fileSize,
      String? mimeType,
      double? latitude,
      double? longitude,
      bool isRequired,
      bool isSynced});
}

/// @nodoc
class __$$VisitPhotoImplCopyWithImpl<$Res>
    extends _$VisitPhotoCopyWithImpl<$Res, _$VisitPhotoImpl>
    implements _$$VisitPhotoImplCopyWith<$Res> {
  __$$VisitPhotoImplCopyWithImpl(
      _$VisitPhotoImpl _value, $Res Function(_$VisitPhotoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? visitId = null,
    Object? storagePath = null,
    Object? localPath = freezed,
    Object? publicUrl = freezed,
    Object? description = freezed,
    Object? type = null,
    Object? status = null,
    Object? createdAt = freezed,
    Object? uploadedAt = freezed,
    Object? fileSize = null,
    Object? mimeType = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isRequired = null,
    Object? isSynced = null,
  }) {
    return _then(_$VisitPhotoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      visitId: null == visitId
          ? _value.visitId
          : visitId // ignore: cast_nullable_to_non_nullable
              as String,
      storagePath: null == storagePath
          ? _value.storagePath
          : storagePath // ignore: cast_nullable_to_non_nullable
              as String,
      localPath: freezed == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      publicUrl: freezed == publicUrl
          ? _value.publicUrl
          : publicUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PhotoType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PhotoStatus,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      uploadedAt: freezed == uploadedAt
          ? _value.uploadedAt
          : uploadedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fileSize: null == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int,
      mimeType: freezed == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      isRequired: null == isRequired
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VisitPhotoImpl implements _VisitPhoto {
  const _$VisitPhotoImpl(
      {required this.id,
      required this.visitId,
      required this.storagePath,
      this.localPath,
      this.publicUrl,
      this.description,
      this.type = PhotoType.general,
      this.status = PhotoStatus.pendingUpload,
      this.createdAt,
      this.uploadedAt,
      this.fileSize = 0,
      this.mimeType,
      this.latitude,
      this.longitude,
      this.isRequired = false,
      this.isSynced = false});

  factory _$VisitPhotoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitPhotoImplFromJson(json);

  @override
  final String id;
  @override
  final String visitId;
  @override
  final String storagePath;
  @override
  final String? localPath;
  @override
  final String? publicUrl;
  @override
  final String? description;
  @override
  @JsonKey()
  final PhotoType type;
  @override
  @JsonKey()
  final PhotoStatus status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? uploadedAt;
  @override
  @JsonKey()
  final int fileSize;
// in bytes
  @override
  final String? mimeType;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey()
  final bool isRequired;
  @override
  @JsonKey()
  final bool isSynced;

  @override
  String toString() {
    return 'VisitPhoto(id: $id, visitId: $visitId, storagePath: $storagePath, localPath: $localPath, publicUrl: $publicUrl, description: $description, type: $type, status: $status, createdAt: $createdAt, uploadedAt: $uploadedAt, fileSize: $fileSize, mimeType: $mimeType, latitude: $latitude, longitude: $longitude, isRequired: $isRequired, isSynced: $isSynced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitPhotoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.visitId, visitId) || other.visitId == visitId) &&
            (identical(other.storagePath, storagePath) ||
                other.storagePath == storagePath) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.publicUrl, publicUrl) ||
                other.publicUrl == publicUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      visitId,
      storagePath,
      localPath,
      publicUrl,
      description,
      type,
      status,
      createdAt,
      uploadedAt,
      fileSize,
      mimeType,
      latitude,
      longitude,
      isRequired,
      isSynced);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitPhotoImplCopyWith<_$VisitPhotoImpl> get copyWith =>
      __$$VisitPhotoImplCopyWithImpl<_$VisitPhotoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitPhotoImplToJson(
      this,
    );
  }
}

abstract class _VisitPhoto implements VisitPhoto {
  const factory _VisitPhoto(
      {required final String id,
      required final String visitId,
      required final String storagePath,
      final String? localPath,
      final String? publicUrl,
      final String? description,
      final PhotoType type,
      final PhotoStatus status,
      final DateTime? createdAt,
      final DateTime? uploadedAt,
      final int fileSize,
      final String? mimeType,
      final double? latitude,
      final double? longitude,
      final bool isRequired,
      final bool isSynced}) = _$VisitPhotoImpl;

  factory _VisitPhoto.fromJson(Map<String, dynamic> json) =
      _$VisitPhotoImpl.fromJson;

  @override
  String get id;
  @override
  String get visitId;
  @override
  String get storagePath;
  @override
  String? get localPath;
  @override
  String? get publicUrl;
  @override
  String? get description;
  @override
  PhotoType get type;
  @override
  PhotoStatus get status;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get uploadedAt;
  @override
  int get fileSize;
  @override // in bytes
  String? get mimeType;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  bool get isRequired;
  @override
  bool get isSynced;
  @override
  @JsonKey(ignore: true)
  _$$VisitPhotoImplCopyWith<_$VisitPhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
