// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionInfo _$SubscriptionInfoFromJson(Map<String, dynamic> json) =>
    _SubscriptionInfo(
      upload: (json['upload'] as num?)?.toInt() ?? 0,
      download: (json['download'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      expire: (json['expire'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SubscriptionInfoToJson(_SubscriptionInfo instance) =>
    <String, dynamic>{
      'upload': instance.upload,
      'download': instance.download,
      'total': instance.total,
      'expire': instance.expire,
    };

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  id: (json['id'] as num).toInt(),
  type:
      $enumDecodeNullable(_$ProfileTypeEnumMap, json['type']) ??
      ProfileType.file,
  label: json['label'] as String? ?? '',
  managed: json['managed'] == null
      ? null
      : ManagedProfileInfo.fromJson(json['managed'] as Map<String, dynamic>),
  currentGroupName: json['currentGroupName'] as String?,
  url: json['url'] as String? ?? '',
  ageSecretKey: json['ageSecretKey'] as String? ?? '',
  lastUpdateDate: json['lastUpdateDate'] == null
      ? null
      : DateTime.parse(json['lastUpdateDate'] as String),
  autoUpdateDuration: Duration(
    microseconds: (json['autoUpdateDuration'] as num).toInt(),
  ),
  subscriptionInfo: json['subscriptionInfo'] == null
      ? null
      : SubscriptionInfo.fromJson(
          json['subscriptionInfo'] as Map<String, dynamic>,
        ),
  autoUpdate: json['autoUpdate'] as bool? ?? true,
  selectedMap:
      (json['selectedMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  unfoldSet:
      (json['unfoldSet'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
      const {},
  extendType:
      $enumDecodeNullable(_$ExtendTypeEnumMap, json['extendType']) ??
      ExtendType.standard,
  scriptId: (json['scriptId'] as num?)?.toInt(),
  matchTarget: json['matchTarget'] as String?,
  order: (json['order'] as num?)?.toInt(),
  overrides: json['overrides'] == null
      ? const ProfileOverrides()
      : ProfileOverrides.safeFromJson(
          json['overrides'] as Map<String, Object?>,
        ),
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'id': instance.id,
  'type': _$ProfileTypeEnumMap[instance.type]!,
  'label': instance.label,
  'managed': instance.managed,
  'currentGroupName': instance.currentGroupName,
  'url': instance.url,
  'ageSecretKey': instance.ageSecretKey,
  'lastUpdateDate': instance.lastUpdateDate?.toIso8601String(),
  'autoUpdateDuration': instance.autoUpdateDuration.inMicroseconds,
  'subscriptionInfo': instance.subscriptionInfo,
  'autoUpdate': instance.autoUpdate,
  'selectedMap': instance.selectedMap,
  'unfoldSet': instance.unfoldSet.toList(),
  'extendType': _$ExtendTypeEnumMap[instance.extendType]!,
  'scriptId': instance.scriptId,
  'matchTarget': instance.matchTarget,
  'order': instance.order,
  'overrides': instance.overrides,
};

const _$ProfileTypeEnumMap = {
  ProfileType.file: 'file',
  ProfileType.url: 'url',
  ProfileType.custom: 'custom',
  ProfileType.heysocks: 'heysocks',
};

const _$ExtendTypeEnumMap = {
  ExtendType.standard: 'standard',
  ExtendType.script: 'script',
};

_ManagedProfileInfo _$ManagedProfileInfoFromJson(Map<String, dynamic> json) =>
    _ManagedProfileInfo(
      accountRef: json['accountRef'] as String? ?? 'heysocks',
      catalogAt: json['catalogAt'] == null
          ? null
          : DateTime.parse(json['catalogAt'] as String),
      fullRefreshAt: json['fullRefreshAt'] == null
          ? null
          : DateTime.parse(json['fullRefreshAt'] as String),
      lineNames:
          (json['lineNames'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      countryNames:
          (json['countryNames'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      checkedAt:
          (json['checkedAt'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, DateTime.parse(e as String)),
          ) ??
          const {},
      selectionRequired: json['selectionRequired'] as bool? ?? false,
      requiresLogin: json['requiresLogin'] as bool? ?? true,
    );

Map<String, dynamic> _$ManagedProfileInfoToJson(_ManagedProfileInfo instance) =>
    <String, dynamic>{
      'accountRef': instance.accountRef,
      'catalogAt': instance.catalogAt?.toIso8601String(),
      'fullRefreshAt': instance.fullRefreshAt?.toIso8601String(),
      'lineNames': instance.lineNames,
      'countryNames': instance.countryNames,
      'checkedAt': instance.checkedAt.map(
        (k, e) => MapEntry(k, e.toIso8601String()),
      ),
      'selectionRequired': instance.selectionRequired,
      'requiresLogin': instance.requiresLogin,
    };
