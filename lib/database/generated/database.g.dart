Warning: truncated output (original token count: 79004)
Total output lines: 9666

// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles
    with TableInfo<$ProfilesTable, RawProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ProfileType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ProfileType>($ProfilesTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<ManagedProfileInfo?, String>
  managed = GeneratedColumn<String>(
    'managed',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<ManagedProfileInfo?>($ProfilesTable.$convertermanaged);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentGroupNameMeta = const VerificationMeta(
    'currentGroupName',
  );
  @override
  late final GeneratedColumn<String> currentGroupName = GeneratedColumn<String>(
    'current_group_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ageSecretKeyMeta = const VerificationMeta(
    'ageSecretKey',
  );
  @override
  late final GeneratedColumn<String> ageSecretKey = GeneratedColumn<String>(
    'age_secret_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastUpdateDateMeta = const VerificationMeta(
    'lastUpdateDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdateDate =
      GeneratedColumn<DateTime>(
        'last_update_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<ExtendType, String> extendType =
      GeneratedColumn<String>(
        'extend_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ExtendType>($ProfilesTable.$converterextendType);
  static const VerificationMeta _scriptIdMeta = const VerificationMeta(
    'scriptId',
  );
  @override
  late final GeneratedColumn<int> scriptId = GeneratedColumn<int>(
    'script_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _matchTargetMeta = const VerificationMeta(
    'matchTarget',
  );
  @override
  late final GeneratedColumn<String> matchTarget = GeneratedColumn<String>(
    'match_target',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _autoUpdateDurationMillisMeta =
      const VerificationMeta('autoUpdateDurationMillis');
  @override
  late final GeneratedColumn<int> autoUpdateDurationMillis =
      GeneratedColumn<int>(
        'auto_update_duration_millis',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  @override
  late final GeneratedColumnWithTypeConverter<SubscriptionInfo?, String>
  subscriptionInfo = GeneratedColumn<String>(
    'subscription_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<SubscriptionInfo?>($ProfilesTable.$convertersubscriptionInfo);
  static const VerificationMeta _autoUpdateMeta = const VerificationMeta(
    'autoUpdate',
  );
  @override
  late final GeneratedColumn<bool> autoUpdate = GeneratedColumn<bool>(
    'auto_update',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_update" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, String>, String>
  selectedMap = GeneratedColumn<String>(
    'selected_map',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, String>>($ProfilesTable.$converterselectedMap);
  @override
  late final GeneratedColumnWithTypeConverter<Set<String>, String> unfoldSet =
      GeneratedColumn<String>(
        'unfold_set',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Set<String>>($ProfilesTable.$converterunfoldSet);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ProfileOverrides?, String>
  overrides = GeneratedColumn<String>(
    'overrides',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<ProfileOverrides?>($ProfilesTable.$converteroverrides);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    managed,
    label,
    currentGroupName,
    url,
    ageSecretKey,
    lastUpdateDate,
    extendType,
    scriptId,
    matchTarget,
    autoUpdateDurationMillis,
    subscriptionInfo,
    autoUpdate,
    selectedMap,
    unfoldSet,
    order,
    overrides,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('current_group_name')) {
      context.handle(
        _currentGroupNameMeta,
        currentGroupName.isAcceptableOrUnknown(
          data['current_group_name']!,
          _currentGroupNameMeta,
        ),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('age_secret_key')) {
      context.handle(
        _ageSecretKeyMeta,
        ageSecretKey.isAcceptableOrUnknown(
          data['age_secret_key']!,
          _ageSecretKeyMeta,
        ),
      );
    }
    if (data.containsKey('last_update_date')) {
      context.handle(
        _lastUpdateDateMeta,
        lastUpdateDate.isAcceptableOrUnknown(
          data['last_update_date']!,
          _lastUpdateDateMeta,
        ),
      );
    }
    if (data.containsKey('script_id')) {
      context.handle(
        _scriptIdMeta,
        scriptId.isAcceptableOrUnknown(data['script_id']!, _scriptIdMeta),
      );
    }
    if (data.containsKey('match_target')) {
      context.handle(
        _matchTargetMeta,
        matchTarget.isAcceptableOrUnknown(
          data['match_target']!,
          _matchTargetMeta,
        ),
      );
    }
    if (data.containsKey('auto_update_duration_millis')) {
      context.handle(
        _autoUpdateDurationMillisMeta,
        autoUpdateDurationMillis.isAcceptableOrUnknown(
          data['auto_update_duration_millis']!,
          _autoUpdateDurationMillisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_autoUpdateDurationMillisMeta);
    }
    if (data.containsKey('auto_update')) {
      context.handle(
        _autoUpdateMeta,
        autoUpdate.isAcceptableOrUnknown(data['auto_update']!, _autoUpdateMeta),
      );
    } else if (isInserting) {
      context.missing(_autoUpdateMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: $ProfilesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      managed: $ProfilesTable.$convertermanaged.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}managed'],
        ),
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      currentGroupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_group_name'],
      ),
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      ageSecretKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}age_secret_key'],
      ),
      lastUpdateDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_update_date'],
      ),
      extendType: $ProfilesTable.$converterextendType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}extend_type'],
        )!,
      ),
      scriptId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}script_id'],
      ),
      matchTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}match_target'],
      ),
      autoUpdateDurationMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}auto_update_duration_millis'],
      )!,
      subscriptionInfo: $ProfilesTable.$convertersubscriptionInfo.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}subscription_info'],
        ),
      ),
      autoUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_update'],
      )!,
      selectedMap: $ProfilesTable.$converterselectedMap.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}selected_map'],
        )!,
      ),
      unfoldSet: $ProfilesTable.$converterunfoldSet.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}unfold_set'],
        )!,
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      ),
      overrides: $ProfilesTable.$converteroverrides.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}overrides'],
        ),
      ),
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ProfileType, String, String> $convertertype =
      const EnumNameConverter<ProfileType>(ProfileType.values);
  static TypeConverter<ManagedProfileInfo?, String?> $convertermanaged =
      const ManagedProfileInfoConverter();
  static JsonTypeConverter2<ExtendType, String, String> $converterextendType =
      const EnumNameConverter<ExtendType>(ExtendType.values);
  static TypeConverter<SubscriptionInfo?, String?> $convertersubscriptionInfo =
      const SubscriptionInfoConverter();
  static TypeConverter<Map<String, String>, String> $converterselectedMap =
      const StringMapConverter();
  static TypeConverter<Set<String>, String> $converterunfoldSet =
      const StringSetConverter();
  static TypeConverter<ProfileOverrides?, String?> $converteroverrides =
      const ProfileOverridesConverter();
}

class RawProfile extends DataClass implements Insertable<RawProfile> {
  final int id;
  final ProfileType type;
  final ManagedProfileInfo? managed;
  final String label;
  final String? currentGroupName;
  final String url;
  final String? ageSecretKey;
  final DateTime? lastUpdateDate;
  final ExtendType extendType;
  final int? scriptId;
  final String? matchTarget;
  final int autoUpdateDurationMillis;
  final SubscriptionInfo? subscriptionInfo;
  final bool autoUpdate;
  final Map<String, String> selectedMap;
  final Set<String> unfoldSet;
  final int? order;
  final ProfileOverrides? overrides;
  const RawProfile({
    required this.id,
    required this.type,
    this.managed,
    required this.label,
    this.currentGroupName,
    required this.url,
    this.ageSecretKey,
    this.lastUpdateDate,
    required this.extendType,
    this.scriptId,
    this.matchTarget,
    required this.autoUpdateDurationMillis,
    this.subscriptionInfo,
    required this.autoUpdate,
    required this.selectedMap,
    required this.unfoldSet,
    this.order,
    this.overrides,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] = Variable<String>($ProfilesTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || managed != null) {
      map['managed'] = Variable<String>(
        $ProfilesTable.$convertermanaged.toSql(managed),
      );
    }
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || currentGroupName != null) {
      map['current_group_name'] = Variable<String>(currentGroupName);
    }
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || ageSecretKey != null) {
      map['age_secret_key'] = Variable<String>(ageSecretKey);
    }
    if (!nullToAbsent || lastUpdateDate != null) {
      map['last_update_date'] = Variable<DateTime>(lastUpdateDate);
    }
    {
      map['extend_type'] = Variable<String>(
        $ProfilesTable.$converterextendType.toSql(extendType),
      );
    }
    if (!nullToAbsent || scriptId != null) {
      map['script_id'] = Variable<int>(scriptId);
    }
    if (!nullToAbsent || matchTarget != null) {
      map['match_target'] = Variable<String>(matchTarget);
    }
    map['auto_update_duration_millis'] = Variable<int>(
      autoUpdateDurationMillis,
    );
    if (!nullToAbsent || subscriptionInfo != null) {
      map['subscription_info'] = Variable<String>(
        $ProfilesTable.$convertersubscriptionInfo.toSql(subscriptionInfo),
      );
    }
    map['auto_update'] = Variable<bool>(autoUpdate);
    {
      map['selected_map'] = Variable<String>(
        $ProfilesTable.$converterselectedMap.toSql(selectedMap),
      );
    }
    {
      map['unfold_set'] = Variable<String>(
        $ProfilesTable.$converterunfoldSet.toSql(unfoldSet),
      );
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    if (!nullToAbsent || overrides != null) {
      map['overrides'] = Variable<String>(
        $ProfilesTable.$converteroverrides.toSql(overrides),
      );
    }
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      type: Value(type),
      managed: managed == null && nullToAbsent
          ? const Value.absent()
          : Value(managed),
      label: Value(label),
      currentGroupName: currentGroupName == null && nullToAbsent
          ? const Value.absent()
          : Value(currentGroupName),
      url: Value(url),
      ageSecretKey: ageSecretKey == null && nullToAbsent
          ? const Value.absent()
          : Value(ageSecretKey),
      lastUpdateDate: lastUpdateDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdateDate),
      extendType: Value(extendType),
      scriptId: scriptId == null && nullToAbsent
          ? const Value.absent()
          : Value(scriptId),
      matchTarget: matchTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(matchTarget),
      autoUpdateDurationMillis: Value(autoUpdateDurationMillis),
      subscriptionInfo: subscriptionInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(subscriptionInfo),
      autoUpdate: Value(autoUpdate),
      selectedMap: Value(selectedMap),
      unfoldSet: Value(unfoldSet),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
      overrides: overrides == null && nullToAbsent
          ? const Value.absent()
          : Value(overrides),
    );
  }

  factory RawProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawProfile(
      id: serializer.fromJson<int>(json['id']),
      type: $ProfilesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      managed: serializer.fromJson<ManagedProfileInfo?>(json['managed']),
      label: serializer.fromJson<String>(json['label']),
      currentGroupName: serializer.fromJson<String?>(json['currentGroupName']),
      url: serializer.fromJson<String>(json['url']),
      ageSecretKey: serializer.fromJson<String?>(json['ageSecretKey']),
      lastUpdateDate: serializer.fromJson<DateTime?>(json['lastUpdateDate']),
      extendType: $ProfilesTable.$converterextendType.fromJson(
        serializer.fromJson<String>(json['extendType']),
      ),
      scriptId: serializer.fromJson<int?>(json['scriptId']),
      matchTarget: serializer.fromJson<String?>(json['matchTarget']),
      autoUpdateDurationMillis: serializer.fromJson<int>(
        json['autoUpdateDurationMillis'],
      ),
      subscriptionInfo: serializer.fromJson<SubscriptionInfo?>(
        json['subscriptionInfo'],
      ),
      autoUpdate: serializer.fromJson<bool>(json['autoUpdate']),
      selectedMap: serializer.fromJson<Map<String, String>>(
        json['selectedMap'],
      ),
      unfoldSet: serializer.fromJson<Set<String>>(json['unfoldSet']),
      order: serializer.fromJson<int?>(json['order']),
      overrides: serializer.fromJson<ProfileOverrides?>(json['overrides']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(
        $ProfilesTable.$convertertype.toJson(type),
      ),
      'managed': serializer.toJson<ManagedProfileInfo?>(managed),
      'label': serializer.toJson<String>(label),
      'currentGroupName': serializer.toJson<String?>(currentGroupName),
      'url': serializer.toJson<String>(url),
      'ageSecretKey': serializer.toJson<String?>(ageSecretKey),
      'lastUpdateDate': serializer.toJson<DateTime?>(lastUpdateDate),
      'extendType': serializer.toJson<String>(
        $ProfilesTable.$converterextendType.toJson(extendType),
      ),
      'scriptId': serializer.toJson<int?>(scriptId),
      'matchTarget': serializer.toJson<String?>(matchTarget),
      'autoUpdateDurationMillis': serializer.toJson<int>(
        autoUpdateDurationMillis,
      ),
      'subscriptionInfo': serializer.toJson<SubscriptionInfo?>(
        subscriptionInfo,
      ),
      'autoUpdate': serializer.toJson<bool>(autoUpdate),
      'selectedMap': serializer.toJson<Map<String, String>>(selectedMap),
      'unfoldSet': serializer.toJson<Set<String>>(unfoldSet),
      'order': serializer.toJson<int?>(order),
      'overrides': serializer.toJson<ProfileOverrides?>(overrides),
    };
  }

  RawProfile copyWith({
    int? id,
    ProfileType? type,
    Value<ManagedProfileInfo?> managed = const Value.absent(),
    String? label,
    Value<String?> currentGroupName = const Value.absent(),
    String? url,
    Value<String?> ageSecretKey = const Value.absent(),
    Value<DateTime?> lastUpdateDate = const Value.absent(),
    ExtendType? extendType,
    Value<int?> scriptId = const Value.absent(),
    Value<String?> matchTarget = const Value.absent(),
    int? autoUpdateDurationMillis,
    Value<SubscriptionInfo?> subscriptionInfo = const Value.absent(),
    bool? autoUpdate,
    Map<String, String>? selectedMap,
    Set<String>? unfoldSet,
    Value<int?> order = const Value.absent(),
    Value<ProfileOverrides?> overrides = const Value.absent(),
  }) => RawProfile(
    id: id ?? this.id,
    type: type ?? this.type,
    managed: managed.present ? managed.value : this.managed,
    label: label ?? this.label,
    currentGroupName: currentGroupName.present
        ? currentGroupName.value
        : this.currentGroupName,
    url: url ?? this.url,
    ageSecretKey: ageSecretKey.present ? ageSecretKey.value : this.ageSecretKey,
    lastUpdateDate: lastUpdateDate.present
        ? lastUpdateDate.value
        : this.lastUpdateDate,
    extendType: extendType ?? this.extendType,
    scriptId: scriptId.present ? scriptId.value : this.scriptId,
    matchTarget: matchTarget.present ? matchTarget.value : this.matchTarget,
    autoUpdateDurationMillis:
        autoUpdateDurationMillis ?? this.autoUpdateDurationMillis,
    subscriptionInfo: subscriptionInfo.present
        ? subscriptionInfo.value
        : this.subscriptionInfo,
    autoUpdate: autoUpdate ?? this.autoUpdate,
    selectedMap: selectedMap ?? this.selectedMap,
    unfoldSet: unfoldSet ?? this.unfoldSet,
    order: order.present ? order.value : this.order,
    overrides: overrides.present ? overrides.value : this.overrides,
  );
  RawProfile copyWithCompanion(ProfilesCompanion data) {
    return RawProfile(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      managed: data.managed.present ? data.managed.value : this.managed,
      label: data.label.present ? data.label.value : this.label,
      currentGroupName: data.currentGroupName.present
          ? data.currentGroupName.value
          : this.currentGroupName,
      url: data.url.present ? data.url.value : this.url,
      ageSecretKey: data.ageSecretKey.present
          ? data.ageSecretKey.value
          : this.ageSecretKey,
      lastUpdateDate: data.lastUpdateDate.present
          ? data.lastUpdateDate.value
          : this.lastUpdateDate,
      extendType: data.extendType.present
          ? data.extendType.value
          : this.extendType,
      scriptId: data.scriptId.present ? data.scriptId.value : this.scriptId,
      matchTarget: data.matchTarget.present
          ? data.matchTarget.value
          : this.matchTarget,
      autoUpdateDurationMillis: data.autoUpdateDurationMillis.present
          ? data.autoUpdateDurationMillis.value
          : this.autoUpdateDurationMillis,
      subscriptionInfo: data.subscriptionInfo.present
          ? data.subscriptionInfo.value
          : this.subscriptionInfo,
      autoUpdate: data.autoUpdate.present
          ? data.autoUpdate.value
          : this.autoUpdate,
      selectedMap: data.selectedMap.present
          ? data.selectedMap.value
          : this.selectedMap,
      unfoldSet: data.unfoldSet.present ? data.unfoldSet.value : this.unfoldSet,
      order: data.order.present ? data.order.value : this.order,
      overrides: data.overrides.present ? data.overrides.value : this.overrides,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawProfile(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('managed: $managed, ')
          ..write('label: $label, ')
          ..write('currentGroupName: $currentGroupName, ')
          ..write('url: $url, ')
          ..write('ageSecretKey: $ageSecretKey, ')
          ..write('lastUpdateDate: $lastUpdateDate, ')
          ..write('extendType: $extendType, ')
          ..write('scriptId: $scriptId, ')
          ..write('matchTarget: $matchTarget, ')
          ..write('autoUpdateDurationMillis: $autoUpdateDurationMillis, ')
          ..write('subscriptionInfo: $subscriptionInfo, ')
          ..write('autoUpdate: $autoUpdate, ')
          ..write('selectedMap: $selectedMap, ')
          ..write('unfoldSet: $unfoldSet, ')
          ..write('order: $order, ')
          ..write('overrides: $overrides')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    managed,
    label,
    currentGroupName,
    url,
    ageSecretKey,
    lastUpdateDate,
    extendType,
    scriptId,
    matchTarget,
    autoUpdateDurationMillis,
    subscriptionInfo,
    autoUpdate,
    selectedMap,
    unfoldSet,
    order,
    overrides,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawProfile &&
          other.id == this.id &&
          other.type == this.type &&
          other.managed == this.managed &&
          other.label == this.label &&
          other.currentGroupName == this.currentGroupName &&
          other.url == this.url &&
          other.ageSecretKey == this.ageSecretKey &&
          other.lastUpdateDate == this.lastUpdateDate &&
          other.extendType == this.extendType &&
          other.scriptId == this.scriptId &&
          other.matchTarget == this.matchTarget &&
          other.autoUpdateDurationMillis == this.autoUpdateDurationMillis &&
          other.subscriptionInfo == this.subscriptionInfo &&
          other.autoUpdate == this.autoUpdate &&
          other.selectedMap == this.selectedMap &&
          other.unfoldSet == this.unfoldSet &&
          other.order == this.order &&
          other.overrides == this.overrides);
}

class ProfilesCompanion extends UpdateCompanion<RawProfile> {
  final Value<int> id;
  final Value<ProfileType> type;
  final Value<ManagedProfileInfo?> managed;
  final Value<String> label;
  final Value<String?> currentGroupName;
  final Value<String> url;
  final Value<String?> ageSecretKey;
  final Value<DateTime?> lastUpdateDate;
  final Value<ExtendType> extendType;
  final Value<int?> scriptId;
  final Value<String?> matchTarget;
  final Value<int> autoUpdateDurationMillis;
  final Value<SubscriptionInfo?> subscriptionInfo;
  final Value<bool> autoUpdate;
  final Value<Map<String, String>> selectedMap;
  final Value<Set<String>> unfoldSet;
  final Value<int?> order;
  final Value<ProfileOverrides?> overrides;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.managed = const Value.absent(),
    this.label = const Value.absent(),
    this.currentGroupName = const Value.absent(),
    this.url = const Value.absent(),
    this.ageSecretKey = const Value.absent(),
    this.lastUpdateDate = const Value.absent(),
    this.extendType = const Value.absent(),
    this.scriptId = const Value.absent(),
    this.matchTarget = const Value.absent(),
    this.autoUpdateDurationMillis = const Value.absent(),
    this.subscriptionInfo = const Value.absent(),
    this.autoUpdate = const Value.absent(),
    this.selectedMap = const Value.absent(),
    this.unfoldSet = const Value.absent(),
    this.order = const Value.absent(),
    this.overrides = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    required ProfileType type,
    this.managed = const Value.absent(),
    required String label,
    this.currentGroupName = const Value.absent(),
    required String url,
    this.ageSecretKey = const Value.absent(),
    this.lastUpdateDate = const Value.absent(),
    required ExtendType extendType,
    this.scriptId = const Value.absent(),
    this.matchTarget = const Value.absent(),
    required int autoUpdateDurationMillis,
    this.subscriptionInfo = const Value.absent(),
    required bool autoUpdate,
    required Map<String, String> selectedMap,
    required Set<String> unfoldSet,
    this.order = const Value.absent(),
    this.overrides = const Value.absent(),
  }) : type = Value(type),
       label = Value(label),
       url = Value(url),
       extendType = Value(extendType),
       autoUpdateDurationMillis = Value(autoUpdateDurationMillis),
       autoUpdate = Value(autoUpdate),
       selectedMap = Value(selectedMap),
       unfoldSet = Value(unfoldSet);
  static Insertable<RawProfile> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? managed,
    Expression<String>? label,
    Expression<String>? currentGroupName,
    Expression<String>? url,
    Expression<String>? ageSecretKey,
    Expression<DateTime>? lastUpdateDate,
    Expression<String>? extendType,
    Expression<int>? scriptId,
    Expression<String>? matchTarget,
    Expression<int>? autoUpdateDurationMillis,
    Expression<String>? subscriptionInfo,
    Expression<bool>? autoUpdate,
    Expression<String>? selectedMap,
    Expression<String>? unfoldSet,
    Expression<int>? order,
    Expression<String>? overrides,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (managed != null) 'managed': managed,
      if (label != null) 'label': label,
      if (currentGroupName != null) 'current_group_name': currentGroupName,
      if (url != null) 'url': url,
      if (ageSecretKey != null) 'age_secret_key': ageSecretKey,
      if (lastUpdateDate != null) 'last_update_date': lastUpdateDate,
      if (extendType != null) 'extend_type': extendType,
      if (scriptId != null) 'script_id': scriptId,
      if (matchTarget != null) 'match_target': matchTarget,
      if (autoUpdateDurationMillis != null)
        'auto_update_duration_millis': autoUpdateDurationMillis,
      if (subscriptionInfo != null) 'subscription_info': subscriptionInfo,
      if (autoUpdate != null) 'auto_update': autoUpdate,
      if (selectedMap != null) 'selected_map': selectedMap,
      if (unfoldSet != null) 'unfold_set': unfoldSet,
      if (order != null) 'order': order,
      if (overrides != null) 'overrides': overrides,
    });
  }

  ProfilesCompanion copyWith({
    Value<int>? id,
    Value<ProfileType>? type,
    Value<ManagedProfileInfo?>? managed,
    Value<String>? label,
    Value<String?>? currentGroupName,
    Value<String>? url,
    Value<String?>? ageSecretKey,
    Value<DateTime?>? lastUpdateDate,
    Value<ExtendType>? extendType,
    Value<int?>? scriptId,
    Value<String?>? matchTarget,
    Value<int>? autoUpdateDurationMillis,
    Value<SubscriptionInfo?>? subscriptionInfo,
    Value<bool>? autoUpdate,
    Value<Map<String, String>>? selectedMap,
    Value<Set<String>>? unfoldSet,
    Value<int?>? order,
    Value<ProfileOverrides?>? overrides,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      managed: managed ?? this.managed,
      label: label ?? this.label,
      currentGroupName: currentGroupName ?? this.currentGroupName,
      url: url ?? this.url,
      ageSecretKey: ageSecretKey ?? this.ageSecretKey,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      extendType: extendType ?? this.extendType,
      scriptId: scriptId ?? this.scriptId,
      matchTarget: matchTarget ?? this.matchTarget,
      autoUpdateDurationMillis:
          autoUpdateDurationMillis ?? this.autoUpdateDurationMillis,
      subscriptionInfo: subscriptionInfo ?? this.subscriptionInfo,
      autoUpdate: autoUpdate ?? this.autoUpdate,
      selectedMap: selectedMap ?? this.selectedMap,
      unfoldSet: unfoldSet ?? this.unfoldSet,
      order: order ?? this.order,
      overrides: overrides ?? this.overrides,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $ProfilesTable.$convertertype.toSql(type.value),
      );
    }
    if (managed.present) {
      map['managed'] = Variable<String>(
        $ProfilesTable.$convertermanaged.toSql(managed.value),
      );
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (currentGroupName.present) {
      map['current_group_name'] = Variable<String>(currentGroupName.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (ageSecretKey.present) {
      map['age_secret_key'] = Variable<String>(ageSecretKey.value);
    }
    if (lastUpdateDate.present) {
      map['last_update_date'] = Variable<DateTime>(lastUpdateDate.value);
    }
    if (extendType.present) {
      map['extend_type'] = Variable<String>(
        $ProfilesTable.$converterextendType.toSql(extendType.value),
      );
    }
    if (scriptId.present) {
      map['script_id'] = Variable<int>(scriptId.value);
    }
    if (matchTarget.present) {
      map['match_target'] = Variable<String>(matchTarget.value);
    }
    if (autoUpdateDurationMillis.present) {
      map['auto_update_duration_millis'] = Variable<int>(
        autoUpdateDurationMillis.value,
      );
    }
    if (subscriptionInfo.present) {
      map['subscription_info'] = Variable<String>(
        $ProfilesTable.$convertersubscriptionInfo.toSql(subscriptionInfo.value),
      );
    }
    if (autoUpdate.present) {
      map['auto_update'] = Variable<bool>(autoUpdate.value);
    }
    if (selectedMap.present) {
      map['selected_map'] = Variable<String>(
        $ProfilesTable.$converterselectedMap.toSql(selectedMap.value),
      );
    }
    if (unfoldSet.present) {
      map['unfold_set'] = Variable<String>(
        $ProfilesTable.$converterunfoldSet.toSql(unfoldSet.value),
      );
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (overrides.present) {
      map['overrides'] = Variable<String>(
        $ProfilesTable.$converteroverrides.toSql(overrides.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('managed: $managed, ')
          ..write('label: $label, ')
          ..write('currentGroupName: $currentGroupName, ')
          ..write('url: $url, ')
          ..write('ageSecretKey: $ageSecretKey, ')
          ..write('lastUpdateDate: $lastUpdateDate, ')
          ..write('extendType: $extendType, ')
          ..write('scriptId: $scriptId, ')
          ..write('matchTarget: $matchTarget, ')
          ..write('autoUpdateDurationMillis: $autoUpdateDurationMillis, ')
          ..write('subscriptionInfo: $subscriptionInfo, ')
          ..write('autoUpdate: $autoUpdate, ')
          ..write('selectedMap: $selectedMap, ')
          ..write('unfoldSet: $unfoldSet, ')
          ..write('order: $order, ')
          ..write('overrides: $overrides')
          ..write(')'))
        .toString();
  }
}

class $ScriptsTable extends Scripts with TableInfo<$ScriptsTable, RawScript> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScriptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdateTimeMeta = const VerificationMeta(
    'lastUpdateTime',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdateTime =
      GeneratedColumn<DateTime>(
        'last_update_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, label, lastUpdateTime, url, order];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scripts';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawScript> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('last_update_time')) {
      context.handle(
        _lastUpdateTimeMeta,
        lastUpdateTime.isAcceptableOrUnknown(
          data['last_update_time']!,
          _lastUpdateTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdateTimeMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawScript map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawScript(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      lastUpdateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_update_time'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      ),
    );
  }

  @override
  $ScriptsTable createAlias(String alias) {
    return $ScriptsTable(attachedDatabase, alias);
  }
}

class RawScript extends DataClass implements Insertable<RawScript> {
  final int id;
  final String label;
  final DateTime lastUpdateTime;
  final String? url;
  final int? order;
  const RawScript({
    required this.id,
    required this.label,
    required this.lastUpdateTime,
    this.url,
    this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['label'] = Variable<String>(label);
    map['last_update_time'] = Variable<DateTime>(lastUpdateTime);
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    return map;
  }

  ScriptsCompanion toCompanion(bool nullToAbsent) {
    return ScriptsCompanion(
      id: Value(id),
      label: Value(label),
      lastUpdateTime: Value(lastUpdateTime),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
    );
  }

  factory RawScript.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawScript(
      id: serializer.fromJson<int>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      lastUpdateTime: serializer.fromJson<DateTime>(json['lastUpdateTime']),
      url: serializer.fromJson<String?>(json['url']),
      order: serializer.fromJson<int?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'label': serializer.toJson<String>(label),
      'lastUpdateTime': serializer.toJson<DateTime>(lastUpdateTime),
      'url': serializer.toJson<String?>(url),
      'order': serializer.toJson<int?>(order),
    };
  }

  RawScript copyWith({
    int? id,
    String? label,
    DateTime? lastUpdateTime,
    Value<String?> url = const Value.absent(),
    Value<int?> order = const Value.absent(),
  }) => RawScript(
    id: id ?? this.id,
    label: label ?? this.label,
    lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
    url: url.present ? url.value : this.url,
    order: order.present ? order.value : this.order,
  );
  RawScript copyWithCompanion(ScriptsCompanion data) {
    return RawScript(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      lastUpdateTime: data.lastUpdateTime.present
          ? data.lastUpdateTime.value
          : this.lastUpdateTime,
      url: data.url.present ? data.url.value : this.url,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawScript(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('url: $url, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, lastUpdateTime, url, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawScript &&
          other.id == this.id &&
          other.label == this.label &&
          other.lastUpdateTime == this.lastUpdateTime &&
          other.url == this.url &&
          other.order == this.order);
}

class ScriptsCompanion extends UpdateCompanion<RawScript> {
  final Value<int> id;
  final Value<String> label;
  final Value<DateTime> lastUpdateTime;
  final Value<String?> url;
  final Value<int?> order;
  const ScriptsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.lastUpdateTime = const Value.absent(),
    this.url = const Value.absent(),
    this.order = const Value.absent(),
  });
  ScriptsCompanion.insert({
    this.id = const Value.absent(),
    required String label,
    required DateTime lastUpdateTime,
    this.url = const Value.absent(),
    this.order = const Value.absent(),
  }) : label = Value(label),
       lastUpdateTime = Value(lastUpdateTime);
  static Insertable<RawScript> custom({
    Expression<int>? id,
    Expression<String>? label,
    Expression<DateTime>? lastUpdateTime,
    Expression<String>? url,
    Expression<int>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (lastUpdateTime != null) 'last_update_time': lastUpdateTime,
      if (url != null) 'url': url,
      if (order != null) 'order': order,
    });
  }

  ScriptsCompanion copyWith({
    Value<int>? id,
    Value<String>? label,
    Value<DateTime>? lastUpdateTime,
    Value<String?>? url,
    Value<int?>? order,
  }) {
    return ScriptsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      url: url ?? this.url,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (lastUpdateTime.present) {
      map['last_update_time'] = Variable<DateTime>(lastUpdateTime.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScriptsCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('lastUpdateTime: $lastUpdateTime, ')
          ..write('url: $url, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class $RulesTable extends Rules with TableInfo<$RulesTable, RawRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RuleAction, String> ruleAction =
      GeneratedColumn<String>(
        'rule_action',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RuleAction>($RulesTable.$converterruleAction);
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleTargetMeta = const VerificationMeta(
    'ruleTarget',
  );
  @override
  late final GeneratedColumn<String> ruleTarget = GeneratedColumn<String>(
    'rule_target',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ruleProviderMeta = const VerificationMeta(
    'ruleProvider',
  );
  @override
  late final GeneratedColumn<String> ruleProvider = GeneratedColumn<String>(
    'rule_provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subRuleMeta = const VerificationMeta(
    'subRule',
  );
  @override
  late final GeneratedColumn<String> subRule = GeneratedColumn<String>(
    'sub_rule',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noResolveMeta = const VerificationMeta(
    'noResolve',
  );
  @override
  late final GeneratedColumn<bool> noResolve = GeneratedColumn<bool>(
    'no_resolve',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("no_resolve" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _srcMeta = const VerificationMeta('src');
  @override
  late final GeneratedColumn<bool> src = GeneratedColumn<bool>(
    'src',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("src" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<String> order = GeneratedColumn<String>(
    'order',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    ruleAction,
    content,
    ruleTarget,
    ruleProvider,
    subRule,
    noResolve,
    src,
    order,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('rule_target')) {
      context.handle(
        _ruleTargetMeta,
        ruleTarget.isAcceptableOrUnknown(data['rule_target']!, _ruleTargetMeta),
      );
    }
    if (data.containsKey('rule_provider')) {
      context.handle(
        _ruleProviderMeta,
        ruleProvider.isAcceptableOrUnknown(
          data['rule_provider']!,
          _ruleProviderMeta,
        ),
      );
    }
    if (data.containsKey('sub_rule')) {
      context.handle(
        _subRuleMeta,
        subRule.isAcceptableOrUnknown(data['sub_rule']!, _subRuleMeta),
      );
    }
    if (data.containsKey('no_resolve')) {
      context.handle(
        _noResolveMeta,
        noResolve.isAcceptableOrUnknown(data['no_resolve']!, _noResolveMeta),
      );
    }
    if (data.containsKey('src')) {
      context.handle(
        _srcMeta,
        src.isAcceptableOrUnknown(data['src']!, _srcMeta),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RawRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      ),
      ruleAction: $RulesTable.$converterruleAction.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}rule_action'],
        )!,
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      ruleTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_target'],
      ),
      ruleProvider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_provider'],
      ),
      subRule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_rule'],
      ),
      noResolve: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}no_resolve'],
      )!,
      src: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}src'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order'],
      ),
    );
  }

  @override
  $RulesTable createAlias(String alias) {
    return $RulesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RuleAction, String, String> $converterruleAction =
      const EnumNameConverter<RuleAction>(RuleAction.values);
}

class RawRule extends DataClass implements Insertable<RawRule> {
  final int id;
  final int? profileId;
  final RuleAction ruleAction;
  final String? content;
  final String? ruleTarget;
  final String? ruleProvider;
  final String? subRule;
  final bool noResolve;
  final bool src;
  final String? order;
  const RawRule({
    required this.id,
    this.profileId,
    required this.ruleAction,
    this.content,
    this.ruleTarget,
    this.ruleProvider,
    this.subRule,
    required this.noResolve,
    required this.src,
    this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || profileId != null) {
      map['profile_id'] = Variable<int>(profileId);
    }
    {
      map['rule_action'] = Variable<String>(
        $RulesTable.$converterruleAction.toSql(ruleAction),
      );
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || ruleTarget != null) {
      map['rule_target'] = Variable<String>(ruleTarget);
    }
    if (!nullToAbsent || ruleProvider != null) {
      map['rule_provider'] = Variable<String>(ruleProvider);
    }
    if (!nullToAbsent || subRule != null) {
      map['sub_rule'] = Variable<String>(subRule);
    }
    map['no_resolve'] = Variable<bool>(noResolve);
    map['src'] = Variable<bool>(src);
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<String>(order);
    }
    return map;
  }

  RulesCompanion toCompanion(bool nullToAbsent) {
    return RulesCompanion(
      id: Value(id),
      profileId: profileId == null && nullToAbsent
          ? const Value.absent()
          : Value(profileId),
      ruleAction: Value(ruleAction),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      ruleTarget: ruleTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleTarget),
      ruleProvider: ruleProvider == null && nullToAbsent
          ? const Value.absent()
          : Value(ruleProvider),
      subRule: subRule == null && nullToAbsent
          ? const Value.absent()
          : Value(subRule),
      noResolve: Value(noResolve),
      src: Value(src),
      order: order == null && nullToAbsent
          ? const Value.absent()
          : Value(order),
    );
  }

  factory RawRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawRule(
      id: serializer.fromJson<int>(json['id']),
      profileId: serializer.fromJson<int?>(json['profileId']),
      ruleAction: $RulesTable.$converterruleAction.fromJson(
        serializer.fromJson<String>(json['ruleAction']),
      ),
      content: serializer.fromJson<String?>(json['content']),
      ruleTarget: serializer.fromJson<String?>(json['ruleTarget']),
      ruleProvider: serializer.fromJson<String?>(json['ruleProvider']),
      subRule: serializer.fromJson<String?>(json['subRule']),
      noResolve: serializer.fromJson<bool>(json['noResolve']),
      src: serializer.fromJson<bool>(json['src']),
      order: serializer.fromJson<String?>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileId': serializer.toJson<int?>(profileId),
      'ruleAction': serializer.toJson<String>(
        $RulesTable.$converterruleAction.toJson(ruleAction),
      ),
      'content': serializer.toJson<String?>(content),
      'ruleTarget': serializer.toJson<String?>(ruleTarget),
      'ruleProvider': serializer.toJson<String?>(ruleProvider),
      'subRule': serializer.toJson<String?>(subRule),
      'noResolve': serializer.toJson<bool>(noResolve),
      'src': serializer.toJson<bool>(src),
      'order': serializer.toJson<String?>(order),
    };
  }

  RawRule copyWith({
    int? id,
    Value<int?> profileId = const Value.absent(),
    RuleAction? ruleAction,
    Value<String?> content = const Value.absent(),
    Value<String?> ruleTarget = const Value.absent(),
    Value<String?> ruleProvider = const Value.absent(),
    Value<String?> subRule = const Value.absent(),
    bool? noResolve,
    bool? src,
    Value<String?> order = const Value.absent(),
  }) => RawRule(
    id: id ?? this.id,
    profileId: profileId.present ? profileId.value : this.profileId,
    ruleAction: ruleAction ?? this.ruleAction,
    content: content.present ? content.value : this.content,
    ruleTarget: ruleTarget.present ? ruleTarget.value : this.ruleTarget,
    ruleProvider: ruleProvider.present ? ruleProvider.value : this.ruleProvider,
    subRule: subRule.present ? subRule.value : this.subRule,
    noResolve: noResolve ?? this.noResolve,
    src: src ?? this.src,
    order: order.present ? order.value : this.order,
  );
  RawRule copyWithCompanion(RulesCompanion data) {
    return RawRule(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      ruleAction: data.ruleAction.present
          ? data.ruleAction.value
          : this.ruleAction,
      content: data.content.present ? data.content.value : this.content,
      ruleTarget: data.ruleTarget.present
          ? data.ruleTarget.value
          : this.ruleTarget,
      ruleProvider: data.ruleProvider.present
          ? data.ruleProvider.value
          : this.ruleProvider,
      subRule: data.subRule.present ? data.subRule.value : this.subRule,
      noResolve: data.noResolve.present ? data.noResolve.value : this.noResolve,
      src: data.src.present ? data.src.value : this.src,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawRule(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('ruleAction: $ruleAction, ')
          ..write('content: $content, ')
          ..write('ruleTarget: $ruleTarget, ')
          ..write('ruleProvider: $ruleP…49004 tokens truncated…IconSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icons => $composableBuilder(
    column: $table.icons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IconSetsTableAnnotationComposer
    extends Composer<_$Database, $IconSetsTable> {
  $$IconSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<IconSetIcon>, String> get icons =>
      $composableBuilder(column: $table.icons, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);
}

class $$IconSetsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $IconSetsTable,
          RawIconSet,
          $$IconSetsTableFilterComposer,
          $$IconSetsTableOrderingComposer,
          $$IconSetsTableAnnotationComposer,
          $$IconSetsTableCreateCompanionBuilder,
          $$IconSetsTableUpdateCompanionBuilder,
          (RawIconSet, BaseReferences<_$Database, $IconSetsTable, RawIconSet>),
          RawIconSet,
          PrefetchHooks Function()
        > {
  $$IconSetsTableTableManager(_$Database db, $IconSetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IconSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IconSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IconSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<List<IconSetIcon>> icons = const Value.absent(),
                Value<DateTime?> lastUpdateTime = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => IconSetsCompanion(
                id: id,
                name: name,
                url: url,
                icons: icons,
                lastUpdateTime: lastUpdateTime,
                order: order,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String url,
                required List<IconSetIcon> icons,
                Value<DateTime?> lastUpdateTime = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => IconSetsCompanion.insert(
                id: id,
                name: name,
                url: url,
                icons: icons,
                lastUpdateTime: lastUpdateTime,
                order: order,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IconSetsTable, RawIconSet>(table),
                  BaseReferences<_$Database, $IconSetsTable, RawIconSet>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IconSetsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $IconSetsTable,
      RawIconSet,
      $$IconSetsTableFilterComposer,
      $$IconSetsTableOrderingComposer,
      $$IconSetsTableAnnotationComposer,
      $$IconSetsTableCreateCompanionBuilder,
      $$IconSetsTableUpdateCompanionBuilder,
      (RawIconSet, BaseReferences<_$Database, $IconSetsTable, RawIconSet>),
      RawIconSet,
      PrefetchHooks Function()
    >;
typedef $$ClashProvidersTableCreateCompanionBuilder =
    ClashProvidersCompanion Function({
      Value<int> id,
      required ProviderKind kind,
      required String label,
      required String url,
      Value<RuleProviderBehavior?> behavior,
      Value<RuleProviderFormat?> format,
      Value<int?> order,
    });
typedef $$ClashProvidersTableUpdateCompanionBuilder =
    ClashProvidersCompanion Function({
      Value<int> id,
      Value<ProviderKind> kind,
      Value<String> label,
      Value<String> url,
      Value<RuleProviderBehavior?> behavior,
      Value<RuleProviderFormat?> format,
      Value<int?> order,
    });

class $$ClashProvidersTableFilterComposer
    extends Composer<_$Database, $ClashProvidersTable> {
  $$ClashProvidersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ProviderKind, ProviderKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    RuleProviderBehavior?,
    RuleProviderBehavior,
    String
  >
  get behavior => $composableBuilder(
    column: $table.behavior,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    RuleProviderFormat?,
    RuleProviderFormat,
    String
  >
  get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClashProvidersTableOrderingComposer
    extends Composer<_$Database, $ClashProvidersTable> {
  $$ClashProvidersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get behavior => $composableBuilder(
    column: $table.behavior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClashProvidersTableAnnotationComposer
    extends Composer<_$Database, $ClashProvidersTable> {
  $$ClashProvidersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProviderKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RuleProviderBehavior?, String>
  get behavior =>
      $composableBuilder(column: $table.behavior, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RuleProviderFormat?, String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);
}

class $$ClashProvidersTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ClashProvidersTable,
          RawClashProvider,
          $$ClashProvidersTableFilterComposer,
          $$ClashProvidersTableOrderingComposer,
          $$ClashProvidersTableAnnotationComposer,
          $$ClashProvidersTableCreateCompanionBuilder,
          $$ClashProvidersTableUpdateCompanionBuilder,
          (
            RawClashProvider,
            BaseReferences<_$Database, $ClashProvidersTable, RawClashProvider>,
          ),
          RawClashProvider,
          PrefetchHooks Function()
        > {
  $$ClashProvidersTableTableManager(_$Database db, $ClashProvidersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClashProvidersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClashProvidersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClashProvidersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<ProviderKind> kind = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<RuleProviderBehavior?> behavior = const Value.absent(),
                Value<RuleProviderFormat?> format = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => ClashProvidersCompanion(
                id: id,
                kind: kind,
                label: label,
                url: url,
                behavior: behavior,
                format: format,
                order: order,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required ProviderKind kind,
                required String label,
                required String url,
                Value<RuleProviderBehavior?> behavior = const Value.absent(),
                Value<RuleProviderFormat?> format = const Value.absent(),
                Value<int?> order = const Value.absent(),
              }) => ClashProvidersCompanion.insert(
                id: id,
                kind: kind,
                label: label,
                url: url,
                behavior: behavior,
                format: format,
                order: order,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ClashProvidersTable, RawClashProvider>(table),
                  BaseReferences<
                    _$Database,
                    $ClashProvidersTable,
                    RawClashProvider
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClashProvidersTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ClashProvidersTable,
      RawClashProvider,
      $$ClashProvidersTableFilterComposer,
      $$ClashProvidersTableOrderingComposer,
      $$ClashProvidersTableAnnotationComposer,
      $$ClashProvidersTableCreateCompanionBuilder,
      $$ClashProvidersTableUpdateCompanionBuilder,
      (
        RawClashProvider,
        BaseReferences<_$Database, $ClashProvidersTable, RawClashProvider>,
      ),
      RawClashProvider,
      PrefetchHooks Function()
    >;
typedef $$CustomProxiesTableCreateCompanionBuilder =
    CustomProxiesCompanion Function({
      Value<int> id,
      required Map<String, dynamic> definition,
      Value<String?> order,
      Value<Set<String>?> emptyOptions,
    });
typedef $$CustomProxiesTableUpdateCompanionBuilder =
    CustomProxiesCompanion Function({
      Value<int> id,
      Value<Map<String, dynamic>> definition,
      Value<String?> order,
      Value<Set<String>?> emptyOptions,
    });

final class $$CustomProxiesTableReferences
    extends BaseReferences<_$Database, $CustomProxiesTable, RawCustomProxy> {
  $$CustomProxiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ProxyDialersTable, List<RawProxyDialer>>
  _proxyDialersRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.proxyDialers,
    aliasName: 'custom_proxies__id__proxy_dialers__proxy_id',
  );

  $$ProxyDialersTableProcessedTableManager get proxyDialersRefs {
    final manager = $$ProxyDialersTableTableManager(
      $_db,
      $_db.proxyDialers,
    ).filter((f) => f.proxyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_proxyDialersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomProxiesTableFilterComposer
    extends Composer<_$Database, $CustomProxiesTable> {
  $$CustomProxiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>,
    Map<String, dynamic>,
    String
  >
  get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Set<String>?, Set<String>, String>
  get emptyOptions => $composableBuilder(
    column: $table.emptyOptions,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  Expression<bool> proxyDialersRefs(
    Expression<bool> Function($$ProxyDialersTableFilterComposer f) f,
  ) {
    final $$ProxyDialersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyDialers,
      getReferencedColumn: (t) => t.proxyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyDialersTableFilterComposer(
            $db: $db,
            $table: $db.proxyDialers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomProxiesTableOrderingComposer
    extends Composer<_$Database, $CustomProxiesTable> {
  $$CustomProxiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emptyOptions => $composableBuilder(
    column: $table.emptyOptions,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomProxiesTableAnnotationComposer
    extends Composer<_$Database, $CustomProxiesTable> {
  $$CustomProxiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>, String>
  get definition => $composableBuilder(
    column: $table.definition,
    builder: (column) => column,
  );

  GeneratedColumn<String> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Set<String>?, String> get emptyOptions =>
      $composableBuilder(
        column: $table.emptyOptions,
        builder: (column) => column,
      );

  Expression<T> proxyDialersRefs<T extends Object>(
    Expression<T> Function($$ProxyDialersTableAnnotationComposer a) f,
  ) {
    final $$ProxyDialersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.proxyDialers,
      getReferencedColumn: (t) => t.proxyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProxyDialersTableAnnotationComposer(
            $db: $db,
            $table: $db.proxyDialers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomProxiesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $CustomProxiesTable,
          RawCustomProxy,
          $$CustomProxiesTableFilterComposer,
          $$CustomProxiesTableOrderingComposer,
          $$CustomProxiesTableAnnotationComposer,
          $$CustomProxiesTableCreateCompanionBuilder,
          $$CustomProxiesTableUpdateCompanionBuilder,
          (RawCustomProxy, $$CustomProxiesTableReferences),
          RawCustomProxy,
          PrefetchHooks Function({bool proxyDialersRefs})
        > {
  $$CustomProxiesTableTableManager(_$Database db, $CustomProxiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomProxiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomProxiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomProxiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Map<String, dynamic>> definition = const Value.absent(),
                Value<String?> order = const Value.absent(),
                Value<Set<String>?> emptyOptions = const Value.absent(),
              }) => CustomProxiesCompanion(
                id: id,
                definition: definition,
                order: order,
                emptyOptions: emptyOptions,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required Map<String, dynamic> definition,
                Value<String?> order = const Value.absent(),
                Value<Set<String>?> emptyOptions = const Value.absent(),
              }) => CustomProxiesCompanion.insert(
                id: id,
                definition: definition,
                order: order,
                emptyOptions: emptyOptions,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CustomProxiesTable, RawCustomProxy>(table),
                  $$CustomProxiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({proxyDialersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (proxyDialersRefs) db.proxyDialers],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (proxyDialersRefs)
                    await $_getPrefetchedData<
                      RawCustomProxy,
                      $CustomProxiesTable,
                      RawProxyDialer
                    >(
                      currentTable: table,
                      referencedTable: $$CustomProxiesTableReferences
                          ._proxyDialersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CustomProxiesTableReferences(
                            db,
                            table,
                            p0,
                          ).proxyDialersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.proxyId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomProxiesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $CustomProxiesTable,
      RawCustomProxy,
      $$CustomProxiesTableFilterComposer,
      $$CustomProxiesTableOrderingComposer,
      $$CustomProxiesTableAnnotationComposer,
      $$CustomProxiesTableCreateCompanionBuilder,
      $$CustomProxiesTableUpdateCompanionBuilder,
      (RawCustomProxy, $$CustomProxiesTableReferences),
      RawCustomProxy,
      PrefetchHooks Function({bool proxyDialersRefs})
    >;
typedef $$ProxyDialersTableCreateCompanionBuilder =
    ProxyDialersCompanion Function({
      required int profileId,
      required int proxyId,
      required String target,
      Value<int> rowid,
    });
typedef $$ProxyDialersTableUpdateCompanionBuilder =
    ProxyDialersCompanion Function({
      Value<int> profileId,
      Value<int> proxyId,
      Value<String> target,
      Value<int> rowid,
    });

final class $$ProxyDialersTableReferences
    extends BaseReferences<_$Database, $ProxyDialersTable, RawProxyDialer> {
  $$ProxyDialersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$Database db) =>
      db.profiles.createAlias('proxy_dialers__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<int>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomProxiesTable _proxyIdTable(_$Database db) => db.customProxies
      .createAlias('proxy_dialers__proxy_id__custom_proxies__id');

  $$CustomProxiesTableProcessedTableManager get proxyId {
    final $_column = $_itemColumn<int>('proxy_id')!;

    final manager = $$CustomProxiesTableTableManager(
      $_db,
      $_db.customProxies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_proxyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProxyDialersTableFilterComposer
    extends Composer<_$Database, $ProxyDialersTable> {
  $$ProxyDialersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomProxiesTableFilterComposer get proxyId {
    final $$CustomProxiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proxyId,
      referencedTable: $db.customProxies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomProxiesTableFilterComposer(
            $db: $db,
            $table: $db.customProxies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyDialersTableOrderingComposer
    extends Composer<_$Database, $ProxyDialersTable> {
  $$ProxyDialersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomProxiesTableOrderingComposer get proxyId {
    final $$CustomProxiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proxyId,
      referencedTable: $db.customProxies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomProxiesTableOrderingComposer(
            $db: $db,
            $table: $db.customProxies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyDialersTableAnnotationComposer
    extends Composer<_$Database, $ProxyDialersTable> {
  $$ProxyDialersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomProxiesTableAnnotationComposer get proxyId {
    final $$CustomProxiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proxyId,
      referencedTable: $db.customProxies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomProxiesTableAnnotationComposer(
            $db: $db,
            $table: $db.customProxies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProxyDialersTableTableManager
    extends
        RootTableManager<
          _$Database,
          $ProxyDialersTable,
          RawProxyDialer,
          $$ProxyDialersTableFilterComposer,
          $$ProxyDialersTableOrderingComposer,
          $$ProxyDialersTableAnnotationComposer,
          $$ProxyDialersTableCreateCompanionBuilder,
          $$ProxyDialersTableUpdateCompanionBuilder,
          (RawProxyDialer, $$ProxyDialersTableReferences),
          RawProxyDialer,
          PrefetchHooks Function({bool profileId, bool proxyId})
        > {
  $$ProxyDialersTableTableManager(_$Database db, $ProxyDialersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProxyDialersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProxyDialersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProxyDialersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> profileId = const Value.absent(),
                Value<int> proxyId = const Value.absent(),
                Value<String> target = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProxyDialersCompanion(
                profileId: profileId,
                proxyId: proxyId,
                target: target,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int profileId,
                required int proxyId,
                required String target,
                Value<int> rowid = const Value.absent(),
              }) => ProxyDialersCompanion.insert(
                profileId: profileId,
                proxyId: proxyId,
                target: target,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProxyDialersTable, RawProxyDialer>(table),
                  $$ProxyDialersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, proxyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $$ProxyDialersTableReferences
                                    ._profileIdTable(db),
                                referencedColumn: $$ProxyDialersTableReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (proxyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.proxyId,
                                referencedTable: $$ProxyDialersTableReferences
                                    ._proxyIdTable(db),
                                referencedColumn: $$ProxyDialersTableReferences
                                    ._proxyIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProxyDialersTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $ProxyDialersTable,
      RawProxyDialer,
      $$ProxyDialersTableFilterComposer,
      $$ProxyDialersTableOrderingComposer,
      $$ProxyDialersTableAnnotationComposer,
      $$ProxyDialersTableCreateCompanionBuilder,
      $$ProxyDialersTableUpdateCompanionBuilder,
      (RawProxyDialer, $$ProxyDialersTableReferences),
      RawProxyDialer,
      PrefetchHooks Function({bool profileId, bool proxyId})
    >;
typedef $$IpQualitiesTableCreateCompanionBuilder =
    IpQualitiesCompanion Function({
      required String ip,
      required IpQuality quality,
      required DateTime checkedAt,
      Value<int> rowid,
    });
typedef $$IpQualitiesTableUpdateCompanionBuilder =
    IpQualitiesCompanion Function({
      Value<String> ip,
      Value<IpQuality> quality,
      Value<DateTime> checkedAt,
      Value<int> rowid,
    });

class $$IpQualitiesTableFilterComposer
    extends Composer<_$Database, $IpQualitiesTable> {
  $$IpQualitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get ip => $composableBuilder(
    column: $table.ip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<IpQuality, IpQuality, String> get quality =>
      $composableBuilder(
        column: $table.quality,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get checkedAt => $composableBuilder(
    column: $table.checkedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$IpQualitiesTableOrderingComposer
    extends Composer<_$Database, $IpQualitiesTable> {
  $$IpQualitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get ip => $composableBuilder(
    column: $table.ip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkedAt => $composableBuilder(
    column: $table.checkedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IpQualitiesTableAnnotationComposer
    extends Composer<_$Database, $IpQualitiesTable> {
  $$IpQualitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get ip =>
      $composableBuilder(column: $table.ip, builder: (column) => column);

  GeneratedColumnWithTypeConverter<IpQuality, String> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<DateTime> get checkedAt =>
      $composableBuilder(column: $table.checkedAt, builder: (column) => column);
}

class $$IpQualitiesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $IpQualitiesTable,
          IpQualityRecord,
          $$IpQualitiesTableFilterComposer,
          $$IpQualitiesTableOrderingComposer,
          $$IpQualitiesTableAnnotationComposer,
          $$IpQualitiesTableCreateCompanionBuilder,
          $$IpQualitiesTableUpdateCompanionBuilder,
          (
            IpQualityRecord,
            BaseReferences<_$Database, $IpQualitiesTable, IpQualityRecord>,
          ),
          IpQualityRecord,
          PrefetchHooks Function()
        > {
  $$IpQualitiesTableTableManager(_$Database db, $IpQualitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IpQualitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IpQualitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IpQualitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> ip = const Value.absent(),
                Value<IpQuality> quality = const Value.absent(),
                Value<DateTime> checkedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IpQualitiesCompanion(
                ip: ip,
                quality: quality,
                checkedAt: checkedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String ip,
                required IpQuality quality,
                required DateTime checkedAt,
                Value<int> rowid = const Value.absent(),
              }) => IpQualitiesCompanion.insert(
                ip: ip,
                quality: quality,
                checkedAt: checkedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IpQualitiesTable, IpQualityRecord>(table),
                  BaseReferences<
                    _$Database,
                    $IpQualitiesTable,
                    IpQualityRecord
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IpQualitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $IpQualitiesTable,
      IpQualityRecord,
      $$IpQualitiesTableFilterComposer,
      $$IpQualitiesTableOrderingComposer,
      $$IpQualitiesTableAnnotationComposer,
      $$IpQualitiesTableCreateCompanionBuilder,
      $$IpQualitiesTableUpdateCompanionBuilder,
      (
        IpQualityRecord,
        BaseReferences<_$Database, $IpQualitiesTable, IpQualityRecord>,
      ),
      IpQualityRecord,
      PrefetchHooks Function()
    >;
typedef $$MitmModulesTableCreateCompanionBuilder =
    MitmModulesCompanion Function({
      Value<int> id,
      required String name,
      Value<String> description,
      Value<String?> url,
      Value<bool> enabled,
      Value<int?> order,
      Value<Map<String, String>> arguments,
      Value<Map<String, String>> resources,
      Value<String?> system,
      Value<int> scripts,
      required DateTime lastUpdateTime,
    });
typedef $$MitmModulesTableUpdateCompanionBuilder =
    MitmModulesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<String?> url,
      Value<bool> enabled,
      Value<int?> order,
      Value<Map<String, String>> arguments,
      Value<Map<String, String>> resources,
      Value<String?> system,
      Value<int> scripts,
      Value<DateTime> lastUpdateTime,
    });

class $$MitmModulesTableFilterComposer
    extends Composer<_$Database, $MitmModulesTable> {
  $$MitmModulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, String>,
    Map<String, String>,
    String
  >
  get arguments => $composableBuilder(
    column: $table.arguments,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, String>,
    Map<String, String>,
    String
  >
  get resources => $composableBuilder(
    column: $table.resources,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get system => $composableBuilder(
    column: $table.system,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scripts => $composableBuilder(
    column: $table.scripts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MitmModulesTableOrderingComposer
    extends Composer<_$Database, $MitmModulesTable> {
  $$MitmModulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arguments => $composableBuilder(
    column: $table.arguments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resources => $composableBuilder(
    column: $table.resources,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get system => $composableBuilder(
    column: $table.system,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scripts => $composableBuilder(
    column: $table.scripts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MitmModulesTableAnnotationComposer
    extends Composer<_$Database, $MitmModulesTable> {
  $$MitmModulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String> get arguments =>
      $composableBuilder(column: $table.arguments, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, String>, String> get resources =>
      $composableBuilder(column: $table.resources, builder: (column) => column);

  GeneratedColumn<String> get system =>
      $composableBuilder(column: $table.system, builder: (column) => column);

  GeneratedColumn<int> get scripts =>
      $composableBuilder(column: $table.scripts, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdateTime => $composableBuilder(
    column: $table.lastUpdateTime,
    builder: (column) => column,
  );
}

class $$MitmModulesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $MitmModulesTable,
          RawMitmModule,
          $$MitmModulesTableFilterComposer,
          $$MitmModulesTableOrderingComposer,
          $$MitmModulesTableAnnotationComposer,
          $$MitmModulesTableCreateCompanionBuilder,
          $$MitmModulesTableUpdateCompanionBuilder,
          (
            RawMitmModule,
            BaseReferences<_$Database, $MitmModulesTable, RawMitmModule>,
          ),
          RawMitmModule,
          PrefetchHooks Function()
        > {
  $$MitmModulesTableTableManager(_$Database db, $MitmModulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MitmModulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MitmModulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MitmModulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int?> order = const Value.absent(),
                Value<Map<String, String>> arguments = const Value.absent(),
                Value<Map<String, String>> resources = const Value.absent(),
                Value<String?> system = const Value.absent(),
                Value<int> scripts = const Value.absent(),
                Value<DateTime> lastUpdateTime = const Value.absent(),
              }) => MitmModulesCompanion(
                id: id,
                name: name,
                description: description,
                url: url,
                enabled: enabled,
                order: order,
                arguments: arguments,
                resources: resources,
                system: system,
                scripts: scripts,
                lastUpdateTime: lastUpdateTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String> description = const Value.absent(),
                Value<String?> url = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int?> order = const Value.absent(),
                Value<Map<String, String>> arguments = const Value.absent(),
                Value<Map<String, String>> resources = const Value.absent(),
                Value<String?> system = const Value.absent(),
                Value<int> scripts = const Value.absent(),
                required DateTime lastUpdateTime,
              }) => MitmModulesCompanion.insert(
                id: id,
                name: name,
                description: description,
                url: url,
                enabled: enabled,
                order: order,
                arguments: arguments,
                resources: resources,
                system: system,
                scripts: scripts,
                lastUpdateTime: lastUpdateTime,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MitmModulesTable, RawMitmModule>(table),
                  BaseReferences<_$Database, $MitmModulesTable, RawMitmModule>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MitmModulesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $MitmModulesTable,
      RawMitmModule,
      $$MitmModulesTableFilterComposer,
      $$MitmModulesTableOrderingComposer,
      $$MitmModulesTableAnnotationComposer,
      $$MitmModulesTableCreateCompanionBuilder,
      $$MitmModulesTableUpdateCompanionBuilder,
      (
        RawMitmModule,
        BaseReferences<_$Database, $MitmModulesTable, RawMitmModule>,
      ),
      RawMitmModule,
      PrefetchHooks Function()
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$ScriptsTableTableManager get scripts =>
      $$ScriptsTableTableManager(_db, _db.scripts);
  $$RulesTableTableManager get rules =>
      $$RulesTableTableManager(_db, _db.rules);
  $$DisabledRulesTableTableManager get disabledRules =>
      $$DisabledRulesTableTableManager(_db, _db.disabledRules);
  $$ProxyGroupsTableTableManager get proxyGroups =>
      $$ProxyGroupsTableTableManager(_db, _db.proxyGroups);
  $$IconRecordsTableTableManager get iconRecords =>
      $$IconRecordsTableTableManager(_db, _db.iconRecords);
  $$IconSetsTableTableManager get iconSets =>
      $$IconSetsTableTableManager(_db, _db.iconSets);
  $$ClashProvidersTableTableManager get clashProviders =>
      $$ClashProvidersTableTableManager(_db, _db.clashProviders);
  $$CustomProxiesTableTableManager get customProxies =>
      $$CustomProxiesTableTableManager(_db, _db.customProxies);
  $$ProxyDialersTableTableManager get proxyDialers =>
      $$ProxyDialersTableTableManager(_db, _db.proxyDialers);
  $$IpQualitiesTableTableManager get ipQualities =>
      $$IpQualitiesTableTableManager(_db, _db.ipQualities);
  $$MitmModulesTableTableManager get mitmModules =>
      $$MitmModulesTableTableManager(_db, _db.mitmModules);
}

mixin _$ProfilesDaoMixin on DatabaseAccessor<Database> {
  $ProfilesTable get profiles => attachedDatabase.profiles;
  ProfilesDaoManager get managers => ProfilesDaoManager(this);
}

class ProfilesDaoManager {
  final _$ProfilesDaoMixin _db;
  ProfilesDaoManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
}

mixin _$ScriptsDaoMixin on DatabaseAccessor<Database> {
  $ScriptsTable get scripts => attachedDatabase.scripts;
  ScriptsDaoManager get managers => ScriptsDaoManager(this);
}

class ScriptsDaoManager {
  final _$ScriptsDaoMixin _db;
  ScriptsDaoManager(this._db);
  $$ScriptsTableTableManager get scripts =>
      $$ScriptsTableTableManager(_db.attachedDatabase, _db.scripts);
}

mixin _$RulesDaoMixin on DatabaseAccessor<Database> {
  $ProfilesTable get profiles => attachedDatabase.profiles;
  $RulesTable get rules => attachedDatabase.rules;
  $DisabledRulesTable get disabledRules => attachedDatabase.disabledRules;
  RulesDaoManager get managers => RulesDaoManager(this);
}

class RulesDaoManager {
  final _$RulesDaoMixin _db;
  RulesDaoManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
  $$RulesTableTableManager get rules =>
      $$RulesTableTableManager(_db.attachedDatabase, _db.rules);
  $$DisabledRulesTableTableManager get disabledRules =>
      $$DisabledRulesTableTableManager(_db.attachedDatabase, _db.disabledRules);
}

mixin _$ProxyGroupsDaoMixin on DatabaseAccessor<Database> {
  $ProfilesTable get profiles => attachedDatabase.profiles;
  $ProxyGroupsTable get proxyGroups => attachedDatabase.proxyGroups;
  ProxyGroupsDaoManager get managers => ProxyGroupsDaoManager(this);
}

class ProxyGroupsDaoManager {
  final _$ProxyGroupsDaoMixin _db;
  ProxyGroupsDaoManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
  $$ProxyGroupsTableTableManager get proxyGroups =>
      $$ProxyGroupsTableTableManager(_db.attachedDatabase, _db.proxyGroups);
}

mixin _$IconRecordsDaoMixin on DatabaseAccessor<Database> {
  $IconRecordsTable get iconRecords => attachedDatabase.iconRecords;
  IconRecordsDaoManager get managers => IconRecordsDaoManager(this);
}

class IconRecordsDaoManager {
  final _$IconRecordsDaoMixin _db;
  IconRecordsDaoManager(this._db);
  $$IconRecordsTableTableManager get iconRecords =>
      $$IconRecordsTableTableManager(_db.attachedDatabase, _db.iconRecords);
}

mixin _$IconSetsDaoMixin on DatabaseAccessor<Database> {
  $IconSetsTable get iconSets => attachedDatabase.iconSets;
  IconSetsDaoManager get managers => IconSetsDaoManager(this);
}

class IconSetsDaoManager {
  final _$IconSetsDaoMixin _db;
  IconSetsDaoManager(this._db);
  $$IconSetsTableTableManager get iconSets =>
      $$IconSetsTableTableManager(_db.attachedDatabase, _db.iconSets);
}

mixin _$ClashProvidersDaoMixin on DatabaseAccessor<Database> {
  $ClashProvidersTable get clashProviders => attachedDatabase.clashProviders;
  ClashProvidersDaoManager get managers => ClashProvidersDaoManager(this);
}

class ClashProvidersDaoManager {
  final _$ClashProvidersDaoMixin _db;
  ClashProvidersDaoManager(this._db);
  $$ClashProvidersTableTableManager get clashProviders =>
      $$ClashProvidersTableTableManager(
        _db.attachedDatabase,
        _db.clashProviders,
      );
}

mixin _$CustomProxiesDaoMixin on DatabaseAccessor<Database> {
  $CustomProxiesTable get customProxies => attachedDatabase.customProxies;
  CustomProxiesDaoManager get managers => CustomProxiesDaoManager(this);
}

class CustomProxiesDaoManager {
  final _$CustomProxiesDaoMixin _db;
  CustomProxiesDaoManager(this._db);
  $$CustomProxiesTableTableManager get customProxies =>
      $$CustomProxiesTableTableManager(_db.attachedDatabase, _db.customProxies);
}

mixin _$ProxyDialersDaoMixin on DatabaseAccessor<Database> {
  $ProfilesTable get profiles => attachedDatabase.profiles;
  $CustomProxiesTable get customProxies => attachedDatabase.customProxies;
  $ProxyDialersTable get proxyDialers => attachedDatabase.proxyDialers;
  ProxyDialersDaoManager get managers => ProxyDialersDaoManager(this);
}

class ProxyDialersDaoManager {
  final _$ProxyDialersDaoMixin _db;
  ProxyDialersDaoManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db.attachedDatabase, _db.profiles);
  $$CustomProxiesTableTableManager get customProxies =>
      $$CustomProxiesTableTableManager(_db.attachedDatabase, _db.customProxies);
  $$ProxyDialersTableTableManager get proxyDialers =>
      $$ProxyDialersTableTableManager(_db.attachedDatabase, _db.proxyDialers);
}

mixin _$IpQualitiesDaoMixin on DatabaseAccessor<Database> {
  $IpQualitiesTable get ipQualities => attachedDatabase.ipQualities;
  IpQualitiesDaoManager get managers => IpQualitiesDaoManager(this);
}

class IpQualitiesDaoManager {
  final _$IpQualitiesDaoMixin _db;
  IpQualitiesDaoManager(this._db);
  $$IpQualitiesTableTableManager get ipQualities =>
      $$IpQualitiesTableTableManager(_db.attachedDatabase, _db.ipQualities);
}

mixin _$MitmModulesDaoMixin on DatabaseAccessor<Database> {
  $MitmModulesTable get mitmModules => attachedDatabase.mitmModules;
  MitmModulesDaoManager get managers => MitmModulesDaoManager(this);
}

class MitmModulesDaoManager {
  final _$MitmModulesDaoMixin _db;
  MitmModulesDaoManager(this._db);
  $$MitmModulesTableTableManager get mitmModules =>
      $$MitmModulesTableTableManager(_db.attachedDatabase, _db.mitmModules);
}
