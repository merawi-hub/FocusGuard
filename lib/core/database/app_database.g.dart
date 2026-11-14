// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MonitoredAppsTable extends MonitoredApps
    with TableInfo<$MonitoredAppsTable, MonitoredApp> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonitoredAppsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _platformAppIdMeta = const VerificationMeta(
    'platformAppId',
  );
  @override
  late final GeneratedColumn<String> platformAppId = GeneratedColumn<String>(
    'platform_app_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _appNameMeta = const VerificationMeta(
    'appName',
  );
  @override
  late final GeneratedColumn<String> appName = GeneratedColumn<String>(
    'app_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconReferenceMeta = const VerificationMeta(
    'iconReference',
  );
  @override
  late final GeneratedColumn<String> iconReference = GeneratedColumn<String>(
    'icon_reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isMonitoredMeta = const VerificationMeta(
    'isMonitored',
  );
  @override
  late final GeneratedColumn<bool> isMonitored = GeneratedColumn<bool>(
    'is_monitored',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_monitored" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    platformAppId,
    appName,
    iconReference,
    isMonitored,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monitored_apps';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonitoredApp> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('platform_app_id')) {
      context.handle(
        _platformAppIdMeta,
        platformAppId.isAcceptableOrUnknown(
          data['platform_app_id']!,
          _platformAppIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_platformAppIdMeta);
    }
    if (data.containsKey('app_name')) {
      context.handle(
        _appNameMeta,
        appName.isAcceptableOrUnknown(data['app_name']!, _appNameMeta),
      );
    } else if (isInserting) {
      context.missing(_appNameMeta);
    }
    if (data.containsKey('icon_reference')) {
      context.handle(
        _iconReferenceMeta,
        iconReference.isAcceptableOrUnknown(
          data['icon_reference']!,
          _iconReferenceMeta,
        ),
      );
    }
    if (data.containsKey('is_monitored')) {
      context.handle(
        _isMonitoredMeta,
        isMonitored.isAcceptableOrUnknown(
          data['is_monitored']!,
          _isMonitoredMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonitoredApp map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonitoredApp(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      platformAppId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform_app_id'],
      )!,
      appName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_name'],
      )!,
      iconReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_reference'],
      ),
      isMonitored: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_monitored'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MonitoredAppsTable createAlias(String alias) {
    return $MonitoredAppsTable(attachedDatabase, alias);
  }
}

class MonitoredApp extends DataClass implements Insertable<MonitoredApp> {
  final int id;
  final String platformAppId;
  final String appName;
  final String? iconReference;
  final bool isMonitored;
  final DateTime createdAt;
  const MonitoredApp({
    required this.id,
    required this.platformAppId,
    required this.appName,
    this.iconReference,
    required this.isMonitored,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['platform_app_id'] = Variable<String>(platformAppId);
    map['app_name'] = Variable<String>(appName);
    if (!nullToAbsent || iconReference != null) {
      map['icon_reference'] = Variable<String>(iconReference);
    }
    map['is_monitored'] = Variable<bool>(isMonitored);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MonitoredAppsCompanion toCompanion(bool nullToAbsent) {
    return MonitoredAppsCompanion(
      id: Value(id),
      platformAppId: Value(platformAppId),
      appName: Value(appName),
      iconReference: iconReference == null && nullToAbsent
          ? const Value.absent()
          : Value(iconReference),
      isMonitored: Value(isMonitored),
      createdAt: Value(createdAt),
    );
  }

  factory MonitoredApp.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonitoredApp(
      id: serializer.fromJson<int>(json['id']),
      platformAppId: serializer.fromJson<String>(json['platformAppId']),
      appName: serializer.fromJson<String>(json['appName']),
      iconReference: serializer.fromJson<String?>(json['iconReference']),
      isMonitored: serializer.fromJson<bool>(json['isMonitored']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'platformAppId': serializer.toJson<String>(platformAppId),
      'appName': serializer.toJson<String>(appName),
      'iconReference': serializer.toJson<String?>(iconReference),
      'isMonitored': serializer.toJson<bool>(isMonitored),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MonitoredApp copyWith({
    int? id,
    String? platformAppId,
    String? appName,
    Value<String?> iconReference = const Value.absent(),
    bool? isMonitored,
    DateTime? createdAt,
  }) => MonitoredApp(
    id: id ?? this.id,
    platformAppId: platformAppId ?? this.platformAppId,
    appName: appName ?? this.appName,
    iconReference: iconReference.present
        ? iconReference.value
        : this.iconReference,
    isMonitored: isMonitored ?? this.isMonitored,
    createdAt: createdAt ?? this.createdAt,
  );
  MonitoredApp copyWithCompanion(MonitoredAppsCompanion data) {
    return MonitoredApp(
      id: data.id.present ? data.id.value : this.id,
      platformAppId: data.platformAppId.present
          ? data.platformAppId.value
          : this.platformAppId,
      appName: data.appName.present ? data.appName.value : this.appName,
      iconReference: data.iconReference.present
          ? data.iconReference.value
          : this.iconReference,
      isMonitored: data.isMonitored.present
          ? data.isMonitored.value
          : this.isMonitored,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonitoredApp(')
          ..write('id: $id, ')
          ..write('platformAppId: $platformAppId, ')
          ..write('appName: $appName, ')
          ..write('iconReference: $iconReference, ')
          ..write('isMonitored: $isMonitored, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    platformAppId,
    appName,
    iconReference,
    isMonitored,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonitoredApp &&
          other.id == this.id &&
          other.platformAppId == this.platformAppId &&
          other.appName == this.appName &&
          other.iconReference == this.iconReference &&
          other.isMonitored == this.isMonitored &&
          other.createdAt == this.createdAt);
}

class MonitoredAppsCompanion extends UpdateCompanion<MonitoredApp> {
  final Value<int> id;
  final Value<String> platformAppId;
  final Value<String> appName;
  final Value<String?> iconReference;
  final Value<bool> isMonitored;
  final Value<DateTime> createdAt;
  const MonitoredAppsCompanion({
    this.id = const Value.absent(),
    this.platformAppId = const Value.absent(),
    this.appName = const Value.absent(),
    this.iconReference = const Value.absent(),
    this.isMonitored = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MonitoredAppsCompanion.insert({
    this.id = const Value.absent(),
    required String platformAppId,
    required String appName,
    this.iconReference = const Value.absent(),
    this.isMonitored = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : platformAppId = Value(platformAppId),
       appName = Value(appName);
  static Insertable<MonitoredApp> custom({
    Expression<int>? id,
    Expression<String>? platformAppId,
    Expression<String>? appName,
    Expression<String>? iconReference,
    Expression<bool>? isMonitored,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (platformAppId != null) 'platform_app_id': platformAppId,
      if (appName != null) 'app_name': appName,
      if (iconReference != null) 'icon_reference': iconReference,
      if (isMonitored != null) 'is_monitored': isMonitored,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MonitoredAppsCompanion copyWith({
    Value<int>? id,
    Value<String>? platformAppId,
    Value<String>? appName,
    Value<String?>? iconReference,
    Value<bool>? isMonitored,
    Value<DateTime>? createdAt,
  }) {
    return MonitoredAppsCompanion(
      id: id ?? this.id,
      platformAppId: platformAppId ?? this.platformAppId,
      appName: appName ?? this.appName,
      iconReference: iconReference ?? this.iconReference,
      isMonitored: isMonitored ?? this.isMonitored,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (platformAppId.present) {
      map['platform_app_id'] = Variable<String>(platformAppId.value);
    }
    if (appName.present) {
      map['app_name'] = Variable<String>(appName.value);
    }
    if (iconReference.present) {
      map['icon_reference'] = Variable<String>(iconReference.value);
    }
    if (isMonitored.present) {
      map['is_monitored'] = Variable<bool>(isMonitored.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonitoredAppsCompanion(')
          ..write('id: $id, ')
          ..write('platformAppId: $platformAppId, ')
          ..write('appName: $appName, ')
          ..write('iconReference: $iconReference, ')
          ..write('isMonitored: $isMonitored, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppLimitsTable extends AppLimits
    with TableInfo<$AppLimitsTable, AppLimit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppLimitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _monitoredAppIdMeta = const VerificationMeta(
    'monitoredAppId',
  );
  @override
  late final GeneratedColumn<int> monitoredAppId = GeneratedColumn<int>(
    'monitored_app_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES monitored_apps (id)',
    ),
  );
  static const VerificationMeta _dailyLimitSecondsMeta = const VerificationMeta(
    'dailyLimitSeconds',
  );
  @override
  late final GeneratedColumn<int> dailyLimitSeconds = GeneratedColumn<int>(
    'daily_limit_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _warningThresholdsMeta = const VerificationMeta(
    'warningThresholds',
  );
  @override
  late final GeneratedColumn<String> warningThresholds =
      GeneratedColumn<String>(
        'warning_thresholds',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[50, 80, 100]'),
      );
  static const VerificationMeta _enforcementModeMeta = const VerificationMeta(
    'enforcementMode',
  );
  @override
  late final GeneratedColumn<String> enforcementMode = GeneratedColumn<String>(
    'enforcement_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('strict'),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    monitoredAppId,
    dailyLimitSeconds,
    warningThresholds,
    enforcementMode,
    isEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_limits';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppLimit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('monitored_app_id')) {
      context.handle(
        _monitoredAppIdMeta,
        monitoredAppId.isAcceptableOrUnknown(
          data['monitored_app_id']!,
          _monitoredAppIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_monitoredAppIdMeta);
    }
    if (data.containsKey('daily_limit_seconds')) {
      context.handle(
        _dailyLimitSecondsMeta,
        dailyLimitSeconds.isAcceptableOrUnknown(
          data['daily_limit_seconds']!,
          _dailyLimitSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyLimitSecondsMeta);
    }
    if (data.containsKey('warning_thresholds')) {
      context.handle(
        _warningThresholdsMeta,
        warningThresholds.isAcceptableOrUnknown(
          data['warning_thresholds']!,
          _warningThresholdsMeta,
        ),
      );
    }
    if (data.containsKey('enforcement_mode')) {
      context.handle(
        _enforcementModeMeta,
        enforcementMode.isAcceptableOrUnknown(
          data['enforcement_mode']!,
          _enforcementModeMeta,
        ),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppLimit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppLimit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      monitoredAppId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monitored_app_id'],
      )!,
      dailyLimitSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_limit_seconds'],
      )!,
      warningThresholds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warning_thresholds'],
      )!,
      enforcementMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}enforcement_mode'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
    );
  }

  @override
  $AppLimitsTable createAlias(String alias) {
    return $AppLimitsTable(attachedDatabase, alias);
  }
}

class AppLimit extends DataClass implements Insertable<AppLimit> {
  final int id;
  final int monitoredAppId;
  final int dailyLimitSeconds;
  final String warningThresholds;
  final String enforcementMode;
  final bool isEnabled;
  const AppLimit({
    required this.id,
    required this.monitoredAppId,
    required this.dailyLimitSeconds,
    required this.warningThresholds,
    required this.enforcementMode,
    required this.isEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['monitored_app_id'] = Variable<int>(monitoredAppId);
    map['daily_limit_seconds'] = Variable<int>(dailyLimitSeconds);
    map['warning_thresholds'] = Variable<String>(warningThresholds);
    map['enforcement_mode'] = Variable<String>(enforcementMode);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  AppLimitsCompanion toCompanion(bool nullToAbsent) {
    return AppLimitsCompanion(
      id: Value(id),
      monitoredAppId: Value(monitoredAppId),
      dailyLimitSeconds: Value(dailyLimitSeconds),
      warningThresholds: Value(warningThresholds),
      enforcementMode: Value(enforcementMode),
      isEnabled: Value(isEnabled),
    );
  }

  factory AppLimit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppLimit(
      id: serializer.fromJson<int>(json['id']),
      monitoredAppId: serializer.fromJson<int>(json['monitoredAppId']),
      dailyLimitSeconds: serializer.fromJson<int>(json['dailyLimitSeconds']),
      warningThresholds: serializer.fromJson<String>(json['warningThresholds']),
      enforcementMode: serializer.fromJson<String>(json['enforcementMode']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'monitoredAppId': serializer.toJson<int>(monitoredAppId),
      'dailyLimitSeconds': serializer.toJson<int>(dailyLimitSeconds),
      'warningThresholds': serializer.toJson<String>(warningThresholds),
      'enforcementMode': serializer.toJson<String>(enforcementMode),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  AppLimit copyWith({
    int? id,
    int? monitoredAppId,
    int? dailyLimitSeconds,
    String? warningThresholds,
    String? enforcementMode,
    bool? isEnabled,
  }) => AppLimit(
    id: id ?? this.id,
    monitoredAppId: monitoredAppId ?? this.monitoredAppId,
    dailyLimitSeconds: dailyLimitSeconds ?? this.dailyLimitSeconds,
    warningThresholds: warningThresholds ?? this.warningThresholds,
    enforcementMode: enforcementMode ?? this.enforcementMode,
    isEnabled: isEnabled ?? this.isEnabled,
  );
  AppLimit copyWithCompanion(AppLimitsCompanion data) {
    return AppLimit(
      id: data.id.present ? data.id.value : this.id,
      monitoredAppId: data.monitoredAppId.present
          ? data.monitoredAppId.value
          : this.monitoredAppId,
      dailyLimitSeconds: data.dailyLimitSeconds.present
          ? data.dailyLimitSeconds.value
          : this.dailyLimitSeconds,
      warningThresholds: data.warningThresholds.present
          ? data.warningThresholds.value
          : this.warningThresholds,
      enforcementMode: data.enforcementMode.present
          ? data.enforcementMode.value
          : this.enforcementMode,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppLimit(')
          ..write('id: $id, ')
          ..write('monitoredAppId: $monitoredAppId, ')
          ..write('dailyLimitSeconds: $dailyLimitSeconds, ')
          ..write('warningThresholds: $warningThresholds, ')
          ..write('enforcementMode: $enforcementMode, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    monitoredAppId,
    dailyLimitSeconds,
    warningThresholds,
    enforcementMode,
    isEnabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLimit &&
          other.id == this.id &&
          other.monitoredAppId == this.monitoredAppId &&
          other.dailyLimitSeconds == this.dailyLimitSeconds &&
          other.warningThresholds == this.warningThresholds &&
          other.enforcementMode == this.enforcementMode &&
          other.isEnabled == this.isEnabled);
}

class AppLimitsCompanion extends UpdateCompanion<AppLimit> {
  final Value<int> id;
  final Value<int> monitoredAppId;
  final Value<int> dailyLimitSeconds;
  final Value<String> warningThresholds;
  final Value<String> enforcementMode;
  final Value<bool> isEnabled;
  const AppLimitsCompanion({
    this.id = const Value.absent(),
    this.monitoredAppId = const Value.absent(),
    this.dailyLimitSeconds = const Value.absent(),
    this.warningThresholds = const Value.absent(),
    this.enforcementMode = const Value.absent(),
    this.isEnabled = const Value.absent(),
  });
  AppLimitsCompanion.insert({
    this.id = const Value.absent(),
    required int monitoredAppId,
    required int dailyLimitSeconds,
    this.warningThresholds = const Value.absent(),
    this.enforcementMode = const Value.absent(),
    this.isEnabled = const Value.absent(),
  }) : monitoredAppId = Value(monitoredAppId),
       dailyLimitSeconds = Value(dailyLimitSeconds);
  static Insertable<AppLimit> custom({
    Expression<int>? id,
    Expression<int>? monitoredAppId,
    Expression<int>? dailyLimitSeconds,
    Expression<String>? warningThresholds,
    Expression<String>? enforcementMode,
    Expression<bool>? isEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monitoredAppId != null) 'monitored_app_id': monitoredAppId,
      if (dailyLimitSeconds != null) 'daily_limit_seconds': dailyLimitSeconds,
      if (warningThresholds != null) 'warning_thresholds': warningThresholds,
      if (enforcementMode != null) 'enforcement_mode': enforcementMode,
      if (isEnabled != null) 'is_enabled': isEnabled,
    });
  }

  AppLimitsCompanion copyWith({
    Value<int>? id,
    Value<int>? monitoredAppId,
    Value<int>? dailyLimitSeconds,
    Value<String>? warningThresholds,
    Value<String>? enforcementMode,
    Value<bool>? isEnabled,
  }) {
    return AppLimitsCompanion(
      id: id ?? this.id,
      monitoredAppId: monitoredAppId ?? this.monitoredAppId,
      dailyLimitSeconds: dailyLimitSeconds ?? this.dailyLimitSeconds,
      warningThresholds: warningThresholds ?? this.warningThresholds,
      enforcementMode: enforcementMode ?? this.enforcementMode,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (monitoredAppId.present) {
      map['monitored_app_id'] = Variable<int>(monitoredAppId.value);
    }
    if (dailyLimitSeconds.present) {
      map['daily_limit_seconds'] = Variable<int>(dailyLimitSeconds.value);
    }
    if (warningThresholds.present) {
      map['warning_thresholds'] = Variable<String>(warningThresholds.value);
    }
    if (enforcementMode.present) {
      map['enforcement_mode'] = Variable<String>(enforcementMode.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppLimitsCompanion(')
          ..write('id: $id, ')
          ..write('monitoredAppId: $monitoredAppId, ')
          ..write('dailyLimitSeconds: $dailyLimitSeconds, ')
          ..write('warningThresholds: $warningThresholds, ')
          ..write('enforcementMode: $enforcementMode, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }
}

class $UsageSessionsTable extends UsageSessions
    with TableInfo<$UsageSessionsTable, UsageSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsageSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _monitoredAppIdMeta = const VerificationMeta(
    'monitoredAppId',
  );
  @override
  late final GeneratedColumn<int> monitoredAppId = GeneratedColumn<int>(
    'monitored_app_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES monitored_apps (id)',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('usage_stats'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    monitoredAppId,
    startedAt,
    endedAt,
    durationSeconds,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usage_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsageSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('monitored_app_id')) {
      context.handle(
        _monitoredAppIdMeta,
        monitoredAppId.isAcceptableOrUnknown(
          data['monitored_app_id']!,
          _monitoredAppIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_monitoredAppIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endedAtMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsageSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsageSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      monitoredAppId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monitored_app_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
    );
  }

  @override
  $UsageSessionsTable createAlias(String alias) {
    return $UsageSessionsTable(attachedDatabase, alias);
  }
}

class UsageSession extends DataClass implements Insertable<UsageSession> {
  final int id;
  final int monitoredAppId;
  final DateTime startedAt;
  final DateTime endedAt;
  final int durationSeconds;
  final String source;
  const UsageSession({
    required this.id,
    required this.monitoredAppId,
    required this.startedAt,
    required this.endedAt,
    required this.durationSeconds,
    required this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['monitored_app_id'] = Variable<int>(monitoredAppId);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['ended_at'] = Variable<DateTime>(endedAt);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['source'] = Variable<String>(source);
    return map;
  }

  UsageSessionsCompanion toCompanion(bool nullToAbsent) {
    return UsageSessionsCompanion(
      id: Value(id),
      monitoredAppId: Value(monitoredAppId),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
      durationSeconds: Value(durationSeconds),
      source: Value(source),
    );
  }

  factory UsageSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsageSession(
      id: serializer.fromJson<int>(json['id']),
      monitoredAppId: serializer.fromJson<int>(json['monitoredAppId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime>(json['endedAt']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      source: serializer.fromJson<String>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'monitoredAppId': serializer.toJson<int>(monitoredAppId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime>(endedAt),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'source': serializer.toJson<String>(source),
    };
  }

  UsageSession copyWith({
    int? id,
    int? monitoredAppId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationSeconds,
    String? source,
  }) => UsageSession(
    id: id ?? this.id,
    monitoredAppId: monitoredAppId ?? this.monitoredAppId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt ?? this.endedAt,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    source: source ?? this.source,
  );
  UsageSession copyWithCompanion(UsageSessionsCompanion data) {
    return UsageSession(
      id: data.id.present ? data.id.value : this.id,
      monitoredAppId: data.monitoredAppId.present
          ? data.monitoredAppId.value
          : this.monitoredAppId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsageSession(')
          ..write('id: $id, ')
          ..write('monitoredAppId: $monitoredAppId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    monitoredAppId,
    startedAt,
    endedAt,
    durationSeconds,
    source,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsageSession &&
          other.id == this.id &&
          other.monitoredAppId == this.monitoredAppId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.durationSeconds == this.durationSeconds &&
          other.source == this.source);
}

class UsageSessionsCompanion extends UpdateCompanion<UsageSession> {
  final Value<int> id;
  final Value<int> monitoredAppId;
  final Value<DateTime> startedAt;
  final Value<DateTime> endedAt;
  final Value<int> durationSeconds;
  final Value<String> source;
  const UsageSessionsCompanion({
    this.id = const Value.absent(),
    this.monitoredAppId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.source = const Value.absent(),
  });
  UsageSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int monitoredAppId,
    required DateTime startedAt,
    required DateTime endedAt,
    required int durationSeconds,
    this.source = const Value.absent(),
  }) : monitoredAppId = Value(monitoredAppId),
       startedAt = Value(startedAt),
       endedAt = Value(endedAt),
       durationSeconds = Value(durationSeconds);
  static Insertable<UsageSession> custom({
    Expression<int>? id,
    Expression<int>? monitoredAppId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? durationSeconds,
    Expression<String>? source,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monitoredAppId != null) 'monitored_app_id': monitoredAppId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (source != null) 'source': source,
    });
  }

  UsageSessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? monitoredAppId,
    Value<DateTime>? startedAt,
    Value<DateTime>? endedAt,
    Value<int>? durationSeconds,
    Value<String>? source,
  }) {
    return UsageSessionsCompanion(
      id: id ?? this.id,
      monitoredAppId: monitoredAppId ?? this.monitoredAppId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      source: source ?? this.source,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (monitoredAppId.present) {
      map['monitored_app_id'] = Variable<int>(monitoredAppId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsageSessionsCompanion(')
          ..write('id: $id, ')
          ..write('monitoredAppId: $monitoredAppId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }
}

class $DailyUsageSummariesTable extends DailyUsageSummaries
    with TableInfo<$DailyUsageSummariesTable, DailyUsageSummary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyUsageSummariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _monitoredAppIdMeta = const VerificationMeta(
    'monitoredAppId',
  );
  @override
  late final GeneratedColumn<int> monitoredAppId = GeneratedColumn<int>(
    'monitored_app_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES monitored_apps (id)',
    ),
  );
  static const VerificationMeta _usageDateMeta = const VerificationMeta(
    'usageDate',
  );
  @override
  late final GeneratedColumn<DateTime> usageDate = GeneratedColumn<DateTime>(
    'usage_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalDurationSecondsMeta =
      const VerificationMeta('totalDurationSeconds');
  @override
  late final GeneratedColumn<int> totalDurationSeconds = GeneratedColumn<int>(
    'total_duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    monitoredAppId,
    usageDate,
    totalDurationSeconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_usage_summaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyUsageSummary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('monitored_app_id')) {
      context.handle(
        _monitoredAppIdMeta,
        monitoredAppId.isAcceptableOrUnknown(
          data['monitored_app_id']!,
          _monitoredAppIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_monitoredAppIdMeta);
    }
    if (data.containsKey('usage_date')) {
      context.handle(
        _usageDateMeta,
        usageDate.isAcceptableOrUnknown(data['usage_date']!, _usageDateMeta),
      );
    } else if (isInserting) {
      context.missing(_usageDateMeta);
    }
    if (data.containsKey('total_duration_seconds')) {
      context.handle(
        _totalDurationSecondsMeta,
        totalDurationSeconds.isAcceptableOrUnknown(
          data['total_duration_seconds']!,
          _totalDurationSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyUsageSummary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyUsageSummary(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      monitoredAppId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monitored_app_id'],
      )!,
      usageDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}usage_date'],
      )!,
      totalDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_duration_seconds'],
      )!,
    );
  }

  @override
  $DailyUsageSummariesTable createAlias(String alias) {
    return $DailyUsageSummariesTable(attachedDatabase, alias);
  }
}

class DailyUsageSummary extends DataClass
    implements Insertable<DailyUsageSummary> {
  final int id;
  final int monitoredAppId;
  final DateTime usageDate;
  final int totalDurationSeconds;
  const DailyUsageSummary({
    required this.id,
    required this.monitoredAppId,
    required this.usageDate,
    required this.totalDurationSeconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['monitored_app_id'] = Variable<int>(monitoredAppId);
    map['usage_date'] = Variable<DateTime>(usageDate);
    map['total_duration_seconds'] = Variable<int>(totalDurationSeconds);
    return map;
  }

  DailyUsageSummariesCompanion toCompanion(bool nullToAbsent) {
    return DailyUsageSummariesCompanion(
      id: Value(id),
      monitoredAppId: Value(monitoredAppId),
      usageDate: Value(usageDate),
      totalDurationSeconds: Value(totalDurationSeconds),
    );
  }

  factory DailyUsageSummary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyUsageSummary(
      id: serializer.fromJson<int>(json['id']),
      monitoredAppId: serializer.fromJson<int>(json['monitoredAppId']),
      usageDate: serializer.fromJson<DateTime>(json['usageDate']),
      totalDurationSeconds: serializer.fromJson<int>(
        json['totalDurationSeconds'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'monitoredAppId': serializer.toJson<int>(monitoredAppId),
      'usageDate': serializer.toJson<DateTime>(usageDate),
      'totalDurationSeconds': serializer.toJson<int>(totalDurationSeconds),
    };
  }

  DailyUsageSummary copyWith({
    int? id,
    int? monitoredAppId,
    DateTime? usageDate,
    int? totalDurationSeconds,
  }) => DailyUsageSummary(
    id: id ?? this.id,
    monitoredAppId: monitoredAppId ?? this.monitoredAppId,
    usageDate: usageDate ?? this.usageDate,
    totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,
  );
  DailyUsageSummary copyWithCompanion(DailyUsageSummariesCompanion data) {
    return DailyUsageSummary(
      id: data.id.present ? data.id.value : this.id,
      monitoredAppId: data.monitoredAppId.present
          ? data.monitoredAppId.value
          : this.monitoredAppId,
      usageDate: data.usageDate.present ? data.usageDate.value : this.usageDate,
      totalDurationSeconds: data.totalDurationSeconds.present
          ? data.totalDurationSeconds.value
          : this.totalDurationSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyUsageSummary(')
          ..write('id: $id, ')
          ..write('monitoredAppId: $monitoredAppId, ')
          ..write('usageDate: $usageDate, ')
          ..write('totalDurationSeconds: $totalDurationSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, monitoredAppId, usageDate, totalDurationSeconds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyUsageSummary &&
          other.id == this.id &&
          other.monitoredAppId == this.monitoredAppId &&
          other.usageDate == this.usageDate &&
          other.totalDurationSeconds == this.totalDurationSeconds);
}

class DailyUsageSummariesCompanion extends UpdateCompanion<DailyUsageSummary> {
  final Value<int> id;
  final Value<int> monitoredAppId;
  final Value<DateTime> usageDate;
  final Value<int> totalDurationSeconds;
  const DailyUsageSummariesCompanion({
    this.id = const Value.absent(),
    this.monitoredAppId = const Value.absent(),
    this.usageDate = const Value.absent(),
    this.totalDurationSeconds = const Value.absent(),
  });
  DailyUsageSummariesCompanion.insert({
    this.id = const Value.absent(),
    required int monitoredAppId,
    required DateTime usageDate,
    this.totalDurationSeconds = const Value.absent(),
  }) : monitoredAppId = Value(monitoredAppId),
       usageDate = Value(usageDate);
  static Insertable<DailyUsageSummary> custom({
    Expression<int>? id,
    Expression<int>? monitoredAppId,
    Expression<DateTime>? usageDate,
    Expression<int>? totalDurationSeconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monitoredAppId != null) 'monitored_app_id': monitoredAppId,
      if (usageDate != null) 'usage_date': usageDate,
      if (totalDurationSeconds != null)
        'total_duration_seconds': totalDurationSeconds,
    });
  }

  DailyUsageSummariesCompanion copyWith({
    Value<int>? id,
    Value<int>? monitoredAppId,
    Value<DateTime>? usageDate,
    Value<int>? totalDurationSeconds,
  }) {
    return DailyUsageSummariesCompanion(
      id: id ?? this.id,
      monitoredAppId: monitoredAppId ?? this.monitoredAppId,
      usageDate: usageDate ?? this.usageDate,
      totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (monitoredAppId.present) {
      map['monitored_app_id'] = Variable<int>(monitoredAppId.value);
    }
    if (usageDate.present) {
      map['usage_date'] = Variable<DateTime>(usageDate.value);
    }
    if (totalDurationSeconds.present) {
      map['total_duration_seconds'] = Variable<int>(totalDurationSeconds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyUsageSummariesCompanion(')
          ..write('id: $id, ')
          ..write('monitoredAppId: $monitoredAppId, ')
          ..write('usageDate: $usageDate, ')
          ..write('totalDurationSeconds: $totalDurationSeconds')
          ..write(')'))
        .toString();
  }
}

class $FocusSessionsTable extends FocusSessions
    with TableInfo<$FocusSessionsTable, FocusSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FocusSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    durationMinutes,
    startedAt,
    completedAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'focus_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FocusSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FocusSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FocusSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $FocusSessionsTable createAlias(String alias) {
    return $FocusSessionsTable(attachedDatabase, alias);
  }
}

class FocusSession extends DataClass implements Insertable<FocusSession> {
  final int id;
  final String title;
  final int durationMinutes;
  final DateTime startedAt;
  final DateTime? completedAt;
  final String status;
  const FocusSession({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.startedAt,
    this.completedAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  FocusSessionsCompanion toCompanion(bool nullToAbsent) {
    return FocusSessionsCompanion(
      id: Value(id),
      title: Value(title),
      durationMinutes: Value(durationMinutes),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      status: Value(status),
    );
  }

  factory FocusSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FocusSession(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'status': serializer.toJson<String>(status),
    };
  }

  FocusSession copyWith({
    int? id,
    String? title,
    int? durationMinutes,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    String? status,
  }) => FocusSession(
    id: id ?? this.id,
    title: title ?? this.title,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    status: status ?? this.status,
  );
  FocusSession copyWithCompanion(FocusSessionsCompanion data) {
    return FocusSession(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FocusSession(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, durationMinutes, startedAt, completedAt, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FocusSession &&
          other.id == this.id &&
          other.title == this.title &&
          other.durationMinutes == this.durationMinutes &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.status == this.status);
}

class FocusSessionsCompanion extends UpdateCompanion<FocusSession> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> durationMinutes;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<String> status;
  const FocusSessionsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.status = const Value.absent(),
  });
  FocusSessionsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int durationMinutes,
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    this.status = const Value.absent(),
  }) : title = Value(title),
       durationMinutes = Value(durationMinutes),
       startedAt = Value(startedAt);
  static Insertable<FocusSession> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? durationMinutes,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (status != null) 'status': status,
    });
  }

  FocusSessionsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int>? durationMinutes,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<String>? status,
  }) {
    return FocusSessionsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FocusSessionsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $DailyGoalsTable extends DailyGoals
    with TableInfo<$DailyGoalsTable, DailyGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetMinutesMeta = const VerificationMeta(
    'targetMinutes',
  );
  @override
  late final GeneratedColumn<int> targetMinutes = GeneratedColumn<int>(
    'target_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMinutesMeta = const VerificationMeta(
    'completedMinutes',
  );
  @override
  late final GeneratedColumn<int> completedMinutes = GeneratedColumn<int>(
    'completed_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _goalDateMeta = const VerificationMeta(
    'goalDate',
  );
  @override
  late final GeneratedColumn<DateTime> goalDate = GeneratedColumn<DateTime>(
    'goal_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    targetMinutes,
    completedMinutes,
    goalDate,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyGoal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('target_minutes')) {
      context.handle(
        _targetMinutesMeta,
        targetMinutes.isAcceptableOrUnknown(
          data['target_minutes']!,
          _targetMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetMinutesMeta);
    }
    if (data.containsKey('completed_minutes')) {
      context.handle(
        _completedMinutesMeta,
        completedMinutes.isAcceptableOrUnknown(
          data['completed_minutes']!,
          _completedMinutesMeta,
        ),
      );
    }
    if (data.containsKey('goal_date')) {
      context.handle(
        _goalDateMeta,
        goalDate.isAcceptableOrUnknown(data['goal_date']!, _goalDateMeta),
      );
    } else if (isInserting) {
      context.missing(_goalDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyGoal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      targetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_minutes'],
      )!,
      completedMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_minutes'],
      )!,
      goalDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}goal_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $DailyGoalsTable createAlias(String alias) {
    return $DailyGoalsTable(attachedDatabase, alias);
  }
}

class DailyGoal extends DataClass implements Insertable<DailyGoal> {
  final int id;
  final String title;
  final int targetMinutes;
  final int completedMinutes;
  final DateTime goalDate;
  final String status;
  const DailyGoal({
    required this.id,
    required this.title,
    required this.targetMinutes,
    required this.completedMinutes,
    required this.goalDate,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['target_minutes'] = Variable<int>(targetMinutes);
    map['completed_minutes'] = Variable<int>(completedMinutes);
    map['goal_date'] = Variable<DateTime>(goalDate);
    map['status'] = Variable<String>(status);
    return map;
  }

  DailyGoalsCompanion toCompanion(bool nullToAbsent) {
    return DailyGoalsCompanion(
      id: Value(id),
      title: Value(title),
      targetMinutes: Value(targetMinutes),
      completedMinutes: Value(completedMinutes),
      goalDate: Value(goalDate),
      status: Value(status),
    );
  }

  factory DailyGoal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyGoal(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      targetMinutes: serializer.fromJson<int>(json['targetMinutes']),
      completedMinutes: serializer.fromJson<int>(json['completedMinutes']),
      goalDate: serializer.fromJson<DateTime>(json['goalDate']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'targetMinutes': serializer.toJson<int>(targetMinutes),
      'completedMinutes': serializer.toJson<int>(completedMinutes),
      'goalDate': serializer.toJson<DateTime>(goalDate),
      'status': serializer.toJson<String>(status),
    };
  }

  DailyGoal copyWith({
    int? id,
    String? title,
    int? targetMinutes,
    int? completedMinutes,
    DateTime? goalDate,
    String? status,
  }) => DailyGoal(
    id: id ?? this.id,
    title: title ?? this.title,
    targetMinutes: targetMinutes ?? this.targetMinutes,
    completedMinutes: completedMinutes ?? this.completedMinutes,
    goalDate: goalDate ?? this.goalDate,
    status: status ?? this.status,
  );
  DailyGoal copyWithCompanion(DailyGoalsCompanion data) {
    return DailyGoal(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      targetMinutes: data.targetMinutes.present
          ? data.targetMinutes.value
          : this.targetMinutes,
      completedMinutes: data.completedMinutes.present
          ? data.completedMinutes.value
          : this.completedMinutes,
      goalDate: data.goalDate.present ? data.goalDate.value : this.goalDate,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyGoal(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('targetMinutes: $targetMinutes, ')
          ..write('completedMinutes: $completedMinutes, ')
          ..write('goalDate: $goalDate, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, targetMinutes, completedMinutes, goalDate, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyGoal &&
          other.id == this.id &&
          other.title == this.title &&
          other.targetMinutes == this.targetMinutes &&
          other.completedMinutes == this.completedMinutes &&
          other.goalDate == this.goalDate &&
          other.status == this.status);
}

class DailyGoalsCompanion extends UpdateCompanion<DailyGoal> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> targetMinutes;
  final Value<int> completedMinutes;
  final Value<DateTime> goalDate;
  final Value<String> status;
  const DailyGoalsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.targetMinutes = const Value.absent(),
    this.completedMinutes = const Value.absent(),
    this.goalDate = const Value.absent(),
    this.status = const Value.absent(),
  });
  DailyGoalsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int targetMinutes,
    this.completedMinutes = const Value.absent(),
    required DateTime goalDate,
    this.status = const Value.absent(),
  }) : title = Value(title),
       targetMinutes = Value(targetMinutes),
       goalDate = Value(goalDate);
  static Insertable<DailyGoal> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? targetMinutes,
    Expression<int>? completedMinutes,
    Expression<DateTime>? goalDate,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (targetMinutes != null) 'target_minutes': targetMinutes,
      if (completedMinutes != null) 'completed_minutes': completedMinutes,
      if (goalDate != null) 'goal_date': goalDate,
      if (status != null) 'status': status,
    });
  }

  DailyGoalsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<int>? targetMinutes,
    Value<int>? completedMinutes,
    Value<DateTime>? goalDate,
    Value<String>? status,
  }) {
    return DailyGoalsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      targetMinutes: targetMinutes ?? this.targetMinutes,
      completedMinutes: completedMinutes ?? this.completedMinutes,
      goalDate: goalDate ?? this.goalDate,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (targetMinutes.present) {
      map['target_minutes'] = Variable<int>(targetMinutes.value);
    }
    if (completedMinutes.present) {
      map['completed_minutes'] = Variable<int>(completedMinutes.value);
    }
    if (goalDate.present) {
      map['goal_date'] = Variable<DateTime>(goalDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyGoalsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('targetMinutes: $targetMinutes, ')
          ..write('completedMinutes: $completedMinutes, ')
          ..write('goalDate: $goalDate, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $RestrictionEventsTable extends RestrictionEvents
    with TableInfo<$RestrictionEventsTable, RestrictionEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RestrictionEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _monitoredAppIdMeta = const VerificationMeta(
    'monitoredAppId',
  );
  @override
  late final GeneratedColumn<int> monitoredAppId = GeneratedColumn<int>(
    'monitored_app_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES monitored_apps (id)',
    ),
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    monitoredAppId,
    eventType,
    occurredAt,
    details,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'restriction_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<RestrictionEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('monitored_app_id')) {
      context.handle(
        _monitoredAppIdMeta,
        monitoredAppId.isAcceptableOrUnknown(
          data['monitored_app_id']!,
          _monitoredAppIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_monitoredAppIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RestrictionEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RestrictionEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      monitoredAppId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monitored_app_id'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      ),
    );
  }

  @override
  $RestrictionEventsTable createAlias(String alias) {
    return $RestrictionEventsTable(attachedDatabase, alias);
  }
}

class RestrictionEvent extends DataClass
    implements Insertable<RestrictionEvent> {
  final int id;
  final int monitoredAppId;
  final String eventType;
  final DateTime occurredAt;
  final String? details;
  const RestrictionEvent({
    required this.id,
    required this.monitoredAppId,
    required this.eventType,
    required this.occurredAt,
    this.details,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['monitored_app_id'] = Variable<int>(monitoredAppId);
    map['event_type'] = Variable<String>(eventType);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    return map;
  }

  RestrictionEventsCompanion toCompanion(bool nullToAbsent) {
    return RestrictionEventsCompanion(
      id: Value(id),
      monitoredAppId: Value(monitoredAppId),
      eventType: Value(eventType),
      occurredAt: Value(occurredAt),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
    );
  }

  factory RestrictionEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RestrictionEvent(
      id: serializer.fromJson<int>(json['id']),
      monitoredAppId: serializer.fromJson<int>(json['monitoredAppId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      details: serializer.fromJson<String?>(json['details']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'monitoredAppId': serializer.toJson<int>(monitoredAppId),
      'eventType': serializer.toJson<String>(eventType),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'details': serializer.toJson<String?>(details),
    };
  }

  RestrictionEvent copyWith({
    int? id,
    int? monitoredAppId,
    String? eventType,
    DateTime? occurredAt,
    Value<String?> details = const Value.absent(),
  }) => RestrictionEvent(
    id: id ?? this.id,
    monitoredAppId: monitoredAppId ?? this.monitoredAppId,
    eventType: eventType ?? this.eventType,
    occurredAt: occurredAt ?? this.occurredAt,
    details: details.present ? details.value : this.details,
  );
  RestrictionEvent copyWithCompanion(RestrictionEventsCompanion data) {
    return RestrictionEvent(
      id: data.id.present ? data.id.value : this.id,
      monitoredAppId: data.monitoredAppId.present
          ? data.monitoredAppId.value
          : this.monitoredAppId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      details: data.details.present ? data.details.value : this.details,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RestrictionEvent(')
          ..write('id: $id, ')
          ..write('monitoredAppId: $monitoredAppId, ')
          ..write('eventType: $eventType, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, monitoredAppId, eventType, occurredAt, details);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RestrictionEvent &&
          other.id == this.id &&
          other.monitoredAppId == this.monitoredAppId &&
          other.eventType == this.eventType &&
          other.occurredAt == this.occurredAt &&
          other.details == this.details);
}

class RestrictionEventsCompanion extends UpdateCompanion<RestrictionEvent> {
  final Value<int> id;
  final Value<int> monitoredAppId;
  final Value<String> eventType;
  final Value<DateTime> occurredAt;
  final Value<String?> details;
  const RestrictionEventsCompanion({
    this.id = const Value.absent(),
    this.monitoredAppId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.details = const Value.absent(),
  });
  RestrictionEventsCompanion.insert({
    this.id = const Value.absent(),
    required int monitoredAppId,
    required String eventType,
    this.occurredAt = const Value.absent(),
    this.details = const Value.absent(),
  }) : monitoredAppId = Value(monitoredAppId),
       eventType = Value(eventType);
  static Insertable<RestrictionEvent> custom({
    Expression<int>? id,
    Expression<int>? monitoredAppId,
    Expression<String>? eventType,
    Expression<DateTime>? occurredAt,
    Expression<String>? details,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monitoredAppId != null) 'monitored_app_id': monitoredAppId,
      if (eventType != null) 'event_type': eventType,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (details != null) 'details': details,
    });
  }

  RestrictionEventsCompanion copyWith({
    Value<int>? id,
    Value<int>? monitoredAppId,
    Value<String>? eventType,
    Value<DateTime>? occurredAt,
    Value<String?>? details,
  }) {
    return RestrictionEventsCompanion(
      id: id ?? this.id,
      monitoredAppId: monitoredAppId ?? this.monitoredAppId,
      eventType: eventType ?? this.eventType,
      occurredAt: occurredAt ?? this.occurredAt,
      details: details ?? this.details,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (monitoredAppId.present) {
      map['monitored_app_id'] = Variable<int>(monitoredAppId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestrictionEventsCompanion(')
          ..write('id: $id, ')
          ..write('monitoredAppId: $monitoredAppId, ')
          ..write('eventType: $eventType, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }
}

class $EmergencyUnlocksTable extends EmergencyUnlocks
    with TableInfo<$EmergencyUnlocksTable, EmergencyUnlock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmergencyUnlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _monitoredAppIdMeta = const VerificationMeta(
    'monitoredAppId',
  );
  @override
  late final GeneratedColumn<int> monitoredAppId = GeneratedColumn<int>(
    'monitored_app_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES monitored_apps (id)',
    ),
  );
  static const VerificationMeta _requestedAtMeta = const VerificationMeta(
    'requestedAt',
  );
  @override
  late final GeneratedColumn<DateTime> requestedAt = GeneratedColumn<DateTime>(
    'requested_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    monitoredAppId,
    requestedAt,
    expiresAt,
    reason,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emergency_unlocks';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmergencyUnlock> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('monitored_app_id')) {
      context.handle(
        _monitoredAppIdMeta,
        monitoredAppId.isAcceptableOrUnknown(
          data['monitored_app_id']!,
          _monitoredAppIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_monitoredAppIdMeta);
    }
    if (data.containsKey('requested_at')) {
      context.handle(
        _requestedAtMeta,
        requestedAt.isAcceptableOrUnknown(
          data['requested_at']!,
          _requestedAtMeta,
        ),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmergencyUnlock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmergencyUnlock(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      monitoredAppId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monitored_app_id'],
      )!,
      requestedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}requested_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $EmergencyUnlocksTable createAlias(String alias) {
    return $EmergencyUnlocksTable(attachedDatabase, alias);
  }
}

class EmergencyUnlock extends DataClass implements Insertable<EmergencyUnlock> {
  final int id;
  final int monitoredAppId;
  final DateTime requestedAt;
  final DateTime expiresAt;
  final String reason;
  final String status;
  const EmergencyUnlock({
    required this.id,
    required this.monitoredAppId,
    required this.requestedAt,
    required this.expiresAt,
    required this.reason,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['monitored_app_id'] = Variable<int>(monitoredAppId);
    map['requested_at'] = Variable<DateTime>(requestedAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    map['reason'] = Variable<String>(reason);
    map['status'] = Variable<String>(status);
    return map;
  }

  EmergencyUnlocksCompanion toCompanion(bool nullToAbsent) {
    return EmergencyUnlocksCompanion(
      id: Value(id),
      monitoredAppId: Value(monitoredAppId),
      requestedAt: Value(requestedAt),
      expiresAt: Value(expiresAt),
      reason: Value(reason),
      status: Value(status),
    );
  }

  factory EmergencyUnlock.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmergencyUnlock(
      id: serializer.fromJson<int>(json['id']),
      monitoredAppId: serializer.fromJson<int>(json['monitoredAppId']),
      requestedAt: serializer.fromJson<DateTime>(json['requestedAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      reason: serializer.fromJson<String>(json['reason']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'monitoredAppId': serializer.toJson<int>(monitoredAppId),
      'requestedAt': serializer.toJson<DateTime>(requestedAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'reason': serializer.toJson<String>(reason),
      'status': serializer.toJson<String>(status),
    };
  }

  EmergencyUnlock copyWith({
    int? id,
    int? monitoredAppId,
    DateTime? requestedAt,
    DateTime? expiresAt,
    String? reason,
    String? status,
  }) => EmergencyUnlock(
    id: id ?? this.id,
    monitoredAppId: monitoredAppId ?? this.monitoredAppId,
    requestedAt: requestedAt ?? this.requestedAt,
    expiresAt: expiresAt ?? this.expiresAt,
    reason: reason ?? this.reason,
    status: status ?? this.status,
  );
  EmergencyUnlock copyWithCompanion(EmergencyUnlocksCompanion data) {
    return EmergencyUnlock(
      id: data.id.present ? data.id.value : this.id,
      monitoredAppId: data.monitoredAppId.present
          ? data.monitoredAppId.value
          : this.monitoredAppId,
      requestedAt: data.requestedAt.present
          ? data.requestedAt.value
          : this.requestedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      reason: data.reason.present ? data.reason.value : this.reason,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyUnlock(')
          ..write('id: $id, ')
          ..write('monitoredAppId: $monitoredAppId, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('reason: $reason, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, monitoredAppId, requestedAt, expiresAt, reason, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmergencyUnlock &&
          other.id == this.id &&
          other.monitoredAppId == this.monitoredAppId &&
          other.requestedAt == this.requestedAt &&
          other.expiresAt == this.expiresAt &&
          other.reason == this.reason &&
          other.status == this.status);
}

class EmergencyUnlocksCompanion extends UpdateCompanion<EmergencyUnlock> {
  final Value<int> id;
  final Value<int> monitoredAppId;
  final Value<DateTime> requestedAt;
  final Value<DateTime> expiresAt;
  final Value<String> reason;
  final Value<String> status;
  const EmergencyUnlocksCompanion({
    this.id = const Value.absent(),
    this.monitoredAppId = const Value.absent(),
    this.requestedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.reason = const Value.absent(),
    this.status = const Value.absent(),
  });
  EmergencyUnlocksCompanion.insert({
    this.id = const Value.absent(),
    required int monitoredAppId,
    this.requestedAt = const Value.absent(),
    required DateTime expiresAt,
    required String reason,
    this.status = const Value.absent(),
  }) : monitoredAppId = Value(monitoredAppId),
       expiresAt = Value(expiresAt),
       reason = Value(reason);
  static Insertable<EmergencyUnlock> custom({
    Expression<int>? id,
    Expression<int>? monitoredAppId,
    Expression<DateTime>? requestedAt,
    Expression<DateTime>? expiresAt,
    Expression<String>? reason,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monitoredAppId != null) 'monitored_app_id': monitoredAppId,
      if (requestedAt != null) 'requested_at': requestedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (reason != null) 'reason': reason,
      if (status != null) 'status': status,
    });
  }

  EmergencyUnlocksCompanion copyWith({
    Value<int>? id,
    Value<int>? monitoredAppId,
    Value<DateTime>? requestedAt,
    Value<DateTime>? expiresAt,
    Value<String>? reason,
    Value<String>? status,
  }) {
    return EmergencyUnlocksCompanion(
      id: id ?? this.id,
      monitoredAppId: monitoredAppId ?? this.monitoredAppId,
      requestedAt: requestedAt ?? this.requestedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      reason: reason ?? this.reason,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (monitoredAppId.present) {
      map['monitored_app_id'] = Variable<int>(monitoredAppId.value);
    }
    if (requestedAt.present) {
      map['requested_at'] = Variable<DateTime>(requestedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyUnlocksCompanion(')
          ..write('id: $id, ')
          ..write('monitoredAppId: $monitoredAppId, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('reason: $reason, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $DailyRoutinesTable extends DailyRoutines
    with TableInfo<$DailyRoutinesTable, DailyRoutine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyRoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectedDaysMeta = const VerificationMeta(
    'selectedDays',
  );
  @override
  late final GeneratedColumn<String> selectedDays = GeneratedColumn<String>(
    'selected_days',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    startTime,
    endTime,
    selectedDays,
    isEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_routines';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyRoutine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('selected_days')) {
      context.handle(
        _selectedDaysMeta,
        selectedDays.isAcceptableOrUnknown(
          data['selected_days']!,
          _selectedDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_selectedDaysMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyRoutine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyRoutine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_time'],
      )!,
      selectedDays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_days'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
    );
  }

  @override
  $DailyRoutinesTable createAlias(String alias) {
    return $DailyRoutinesTable(attachedDatabase, alias);
  }
}

class DailyRoutine extends DataClass implements Insertable<DailyRoutine> {
  final int id;
  final String title;
  final String startTime;
  final String endTime;
  final String selectedDays;
  final bool isEnabled;
  const DailyRoutine({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.selectedDays,
    required this.isEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['start_time'] = Variable<String>(startTime);
    map['end_time'] = Variable<String>(endTime);
    map['selected_days'] = Variable<String>(selectedDays);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  DailyRoutinesCompanion toCompanion(bool nullToAbsent) {
    return DailyRoutinesCompanion(
      id: Value(id),
      title: Value(title),
      startTime: Value(startTime),
      endTime: Value(endTime),
      selectedDays: Value(selectedDays),
      isEnabled: Value(isEnabled),
    );
  }

  factory DailyRoutine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyRoutine(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      startTime: serializer.fromJson<String>(json['startTime']),
      endTime: serializer.fromJson<String>(json['endTime']),
      selectedDays: serializer.fromJson<String>(json['selectedDays']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'startTime': serializer.toJson<String>(startTime),
      'endTime': serializer.toJson<String>(endTime),
      'selectedDays': serializer.toJson<String>(selectedDays),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  DailyRoutine copyWith({
    int? id,
    String? title,
    String? startTime,
    String? endTime,
    String? selectedDays,
    bool? isEnabled,
  }) => DailyRoutine(
    id: id ?? this.id,
    title: title ?? this.title,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    selectedDays: selectedDays ?? this.selectedDays,
    isEnabled: isEnabled ?? this.isEnabled,
  );
  DailyRoutine copyWithCompanion(DailyRoutinesCompanion data) {
    return DailyRoutine(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      selectedDays: data.selectedDays.present
          ? data.selectedDays.value
          : this.selectedDays,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyRoutine(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('selectedDays: $selectedDays, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, startTime, endTime, selectedDays, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyRoutine &&
          other.id == this.id &&
          other.title == this.title &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.selectedDays == this.selectedDays &&
          other.isEnabled == this.isEnabled);
}

class DailyRoutinesCompanion extends UpdateCompanion<DailyRoutine> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> startTime;
  final Value<String> endTime;
  final Value<String> selectedDays;
  final Value<bool> isEnabled;
  const DailyRoutinesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.selectedDays = const Value.absent(),
    this.isEnabled = const Value.absent(),
  });
  DailyRoutinesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String startTime,
    required String endTime,
    required String selectedDays,
    this.isEnabled = const Value.absent(),
  }) : title = Value(title),
       startTime = Value(startTime),
       endTime = Value(endTime),
       selectedDays = Value(selectedDays);
  static Insertable<DailyRoutine> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<String>? selectedDays,
    Expression<bool>? isEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (selectedDays != null) 'selected_days': selectedDays,
      if (isEnabled != null) 'is_enabled': isEnabled,
    });
  }

  DailyRoutinesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? startTime,
    Value<String>? endTime,
    Value<String>? selectedDays,
    Value<bool>? isEnabled,
  }) {
    return DailyRoutinesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      selectedDays: selectedDays ?? this.selectedDays,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    if (selectedDays.present) {
      map['selected_days'] = Variable<String>(selectedDays.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyRoutinesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('selectedDays: $selectedDays, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MonitoredAppsTable monitoredApps = $MonitoredAppsTable(this);
  late final $AppLimitsTable appLimits = $AppLimitsTable(this);
  late final $UsageSessionsTable usageSessions = $UsageSessionsTable(this);
  late final $DailyUsageSummariesTable dailyUsageSummaries =
      $DailyUsageSummariesTable(this);
  late final $FocusSessionsTable focusSessions = $FocusSessionsTable(this);
  late final $DailyGoalsTable dailyGoals = $DailyGoalsTable(this);
  late final $RestrictionEventsTable restrictionEvents =
      $RestrictionEventsTable(this);
  late final $EmergencyUnlocksTable emergencyUnlocks = $EmergencyUnlocksTable(
    this,
  );
  late final $DailyRoutinesTable dailyRoutines = $DailyRoutinesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    monitoredApps,
    appLimits,
    usageSessions,
    dailyUsageSummaries,
    focusSessions,
    dailyGoals,
    restrictionEvents,
    emergencyUnlocks,
    dailyRoutines,
  ];
}

typedef $$MonitoredAppsTableCreateCompanionBuilder =
    MonitoredAppsCompanion Function({
      Value<int> id,
      required String platformAppId,
      required String appName,
      Value<String?> iconReference,
      Value<bool> isMonitored,
      Value<DateTime> createdAt,
    });
typedef $$MonitoredAppsTableUpdateCompanionBuilder =
    MonitoredAppsCompanion Function({
      Value<int> id,
      Value<String> platformAppId,
      Value<String> appName,
      Value<String?> iconReference,
      Value<bool> isMonitored,
      Value<DateTime> createdAt,
    });

final class $$MonitoredAppsTableReferences
    extends BaseReferences<_$AppDatabase, $MonitoredAppsTable, MonitoredApp> {
  $$MonitoredAppsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$AppLimitsTable, List<AppLimit>>
  _appLimitsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.appLimits,
    aliasName: 'monitored_apps__id__app_limits__monitored_app_id',
  );

  $$AppLimitsTableProcessedTableManager get appLimitsRefs {
    final manager = $$AppLimitsTableTableManager(
      $_db,
      $_db.appLimits,
    ).filter((f) => f.monitoredAppId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_appLimitsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UsageSessionsTable, List<UsageSession>>
  _usageSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.usageSessions,
    aliasName: 'monitored_apps__id__usage_sessions__monitored_app_id',
  );

  $$UsageSessionsTableProcessedTableManager get usageSessionsRefs {
    final manager = $$UsageSessionsTableTableManager(
      $_db,
      $_db.usageSessions,
    ).filter((f) => f.monitoredAppId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_usageSessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DailyUsageSummariesTable, List<DailyUsageSummary>>
  _dailyUsageSummariesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.dailyUsageSummaries,
        aliasName:
            'monitored_apps__id__daily_usage_summaries__monitored_app_id',
      );

  $$DailyUsageSummariesTableProcessedTableManager get dailyUsageSummariesRefs {
    final manager = $$DailyUsageSummariesTableTableManager(
      $_db,
      $_db.dailyUsageSummaries,
    ).filter((f) => f.monitoredAppId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _dailyUsageSummariesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RestrictionEventsTable, List<RestrictionEvent>>
  _restrictionEventsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.restrictionEvents,
        aliasName: 'monitored_apps__id__restriction_events__monitored_app_id',
      );

  $$RestrictionEventsTableProcessedTableManager get restrictionEventsRefs {
    final manager = $$RestrictionEventsTableTableManager(
      $_db,
      $_db.restrictionEvents,
    ).filter((f) => f.monitoredAppId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _restrictionEventsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EmergencyUnlocksTable, List<EmergencyUnlock>>
  _emergencyUnlocksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.emergencyUnlocks,
    aliasName: 'monitored_apps__id__emergency_unlocks__monitored_app_id',
  );

  $$EmergencyUnlocksTableProcessedTableManager get emergencyUnlocksRefs {
    final manager = $$EmergencyUnlocksTableTableManager(
      $_db,
      $_db.emergencyUnlocks,
    ).filter((f) => f.monitoredAppId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _emergencyUnlocksRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MonitoredAppsTableFilterComposer
    extends Composer<_$AppDatabase, $MonitoredAppsTable> {
  $$MonitoredAppsTableFilterComposer({
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

  ColumnFilters<String> get platformAppId => $composableBuilder(
    column: $table.platformAppId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appName => $composableBuilder(
    column: $table.appName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconReference => $composableBuilder(
    column: $table.iconReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMonitored => $composableBuilder(
    column: $table.isMonitored,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> appLimitsRefs(
    Expression<bool> Function($$AppLimitsTableFilterComposer f) f,
  ) {
    final $$AppLimitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appLimits,
      getReferencedColumn: (t) => t.monitoredAppId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppLimitsTableFilterComposer(
            $db: $db,
            $table: $db.appLimits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> usageSessionsRefs(
    Expression<bool> Function($$UsageSessionsTableFilterComposer f) f,
  ) {
    final $$UsageSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usageSessions,
      getReferencedColumn: (t) => t.monitoredAppId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsageSessionsTableFilterComposer(
            $db: $db,
            $table: $db.usageSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> dailyUsageSummariesRefs(
    Expression<bool> Function($$DailyUsageSummariesTableFilterComposer f) f,
  ) {
    final $$DailyUsageSummariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyUsageSummaries,
      getReferencedColumn: (t) => t.monitoredAppId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyUsageSummariesTableFilterComposer(
            $db: $db,
            $table: $db.dailyUsageSummaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> restrictionEventsRefs(
    Expression<bool> Function($$RestrictionEventsTableFilterComposer f) f,
  ) {
    final $$RestrictionEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.restrictionEvents,
      getReferencedColumn: (t) => t.monitoredAppId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RestrictionEventsTableFilterComposer(
            $db: $db,
            $table: $db.restrictionEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> emergencyUnlocksRefs(
    Expression<bool> Function($$EmergencyUnlocksTableFilterComposer f) f,
  ) {
    final $$EmergencyUnlocksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.emergencyUnlocks,
      getReferencedColumn: (t) => t.monitoredAppId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmergencyUnlocksTableFilterComposer(
            $db: $db,
            $table: $db.emergencyUnlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MonitoredAppsTableOrderingComposer
    extends Composer<_$AppDatabase, $MonitoredAppsTable> {
  $$MonitoredAppsTableOrderingComposer({
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

  ColumnOrderings<String> get platformAppId => $composableBuilder(
    column: $table.platformAppId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appName => $composableBuilder(
    column: $table.appName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconReference => $composableBuilder(
    column: $table.iconReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMonitored => $composableBuilder(
    column: $table.isMonitored,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MonitoredAppsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonitoredAppsTable> {
  $$MonitoredAppsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get platformAppId => $composableBuilder(
    column: $table.platformAppId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get appName =>
      $composableBuilder(column: $table.appName, builder: (column) => column);

  GeneratedColumn<String> get iconReference => $composableBuilder(
    column: $table.iconReference,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isMonitored => $composableBuilder(
    column: $table.isMonitored,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> appLimitsRefs<T extends Object>(
    Expression<T> Function($$AppLimitsTableAnnotationComposer a) f,
  ) {
    final $$AppLimitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.appLimits,
      getReferencedColumn: (t) => t.monitoredAppId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AppLimitsTableAnnotationComposer(
            $db: $db,
            $table: $db.appLimits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> usageSessionsRefs<T extends Object>(
    Expression<T> Function($$UsageSessionsTableAnnotationComposer a) f,
  ) {
    final $$UsageSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.usageSessions,
      getReferencedColumn: (t) => t.monitoredAppId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsageSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.usageSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> dailyUsageSummariesRefs<T extends Object>(
    Expression<T> Function($$DailyUsageSummariesTableAnnotationComposer a) f,
  ) {
    final $$DailyUsageSummariesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.dailyUsageSummaries,
          getReferencedColumn: (t) => t.monitoredAppId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DailyUsageSummariesTableAnnotationComposer(
                $db: $db,
                $table: $db.dailyUsageSummaries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> restrictionEventsRefs<T extends Object>(
    Expression<T> Function($$RestrictionEventsTableAnnotationComposer a) f,
  ) {
    final $$RestrictionEventsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.restrictionEvents,
          getReferencedColumn: (t) => t.monitoredAppId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RestrictionEventsTableAnnotationComposer(
                $db: $db,
                $table: $db.restrictionEvents,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> emergencyUnlocksRefs<T extends Object>(
    Expression<T> Function($$EmergencyUnlocksTableAnnotationComposer a) f,
  ) {
    final $$EmergencyUnlocksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.emergencyUnlocks,
      getReferencedColumn: (t) => t.monitoredAppId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmergencyUnlocksTableAnnotationComposer(
            $db: $db,
            $table: $db.emergencyUnlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MonitoredAppsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonitoredAppsTable,
          MonitoredApp,
          $$MonitoredAppsTableFilterComposer,
          $$MonitoredAppsTableOrderingComposer,
          $$MonitoredAppsTableAnnotationComposer,
          $$MonitoredAppsTableCreateCompanionBuilder,
          $$MonitoredAppsTableUpdateCompanionBuilder,
          (MonitoredApp, $$MonitoredAppsTableReferences),
          MonitoredApp,
          PrefetchHooks Function({
            bool appLimitsRefs,
            bool usageSessionsRefs,
            bool dailyUsageSummariesRefs,
            bool restrictionEventsRefs,
            bool emergencyUnlocksRefs,
          })
        > {
  $$MonitoredAppsTableTableManager(_$AppDatabase db, $MonitoredAppsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonitoredAppsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonitoredAppsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonitoredAppsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> platformAppId = const Value.absent(),
                Value<String> appName = const Value.absent(),
                Value<String?> iconReference = const Value.absent(),
                Value<bool> isMonitored = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MonitoredAppsCompanion(
                id: id,
                platformAppId: platformAppId,
                appName: appName,
                iconReference: iconReference,
                isMonitored: isMonitored,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String platformAppId,
                required String appName,
                Value<String?> iconReference = const Value.absent(),
                Value<bool> isMonitored = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MonitoredAppsCompanion.insert(
                id: id,
                platformAppId: platformAppId,
                appName: appName,
                iconReference: iconReference,
                isMonitored: isMonitored,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MonitoredAppsTable, MonitoredApp>(table),
                  $$MonitoredAppsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                appLimitsRefs = false,
                usageSessionsRefs = false,
                dailyUsageSummariesRefs = false,
                restrictionEventsRefs = false,
                emergencyUnlocksRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (appLimitsRefs) db.appLimits,
                    if (usageSessionsRefs) db.usageSessions,
                    if (dailyUsageSummariesRefs) db.dailyUsageSummaries,
                    if (restrictionEventsRefs) db.restrictionEvents,
                    if (emergencyUnlocksRefs) db.emergencyUnlocks,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (appLimitsRefs)
                        await $_getPrefetchedDataByColumns<
                          MonitoredApp,
                          $MonitoredAppsTable,
                          AppLimit,
                          $AppLimitsTable
                        >(
                          currentTable: table,
                          referencedTable: $$MonitoredAppsTableReferences
                              ._appLimitsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonitoredAppsTableReferences(
                                db,
                                table,
                                p0,
                              ).appLimitsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'monitored_app_id',
                          typedResults: items,
                        ),
                      if (usageSessionsRefs)
                        await $_getPrefetchedDataByColumns<
                          MonitoredApp,
                          $MonitoredAppsTable,
                          UsageSession,
                          $UsageSessionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$MonitoredAppsTableReferences
                              ._usageSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonitoredAppsTableReferences(
                                db,
                                table,
                                p0,
                              ).usageSessionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'monitored_app_id',
                          typedResults: items,
                        ),
                      if (dailyUsageSummariesRefs)
                        await $_getPrefetchedDataByColumns<
                          MonitoredApp,
                          $MonitoredAppsTable,
                          DailyUsageSummary,
                          $DailyUsageSummariesTable
                        >(
                          currentTable: table,
                          referencedTable: $$MonitoredAppsTableReferences
                              ._dailyUsageSummariesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonitoredAppsTableReferences(
                                db,
                                table,
                                p0,
                              ).dailyUsageSummariesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'monitored_app_id',
                          typedResults: items,
                        ),
                      if (restrictionEventsRefs)
                        await $_getPrefetchedDataByColumns<
                          MonitoredApp,
                          $MonitoredAppsTable,
                          RestrictionEvent,
                          $RestrictionEventsTable
                        >(
                          currentTable: table,
                          referencedTable: $$MonitoredAppsTableReferences
                              ._restrictionEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonitoredAppsTableReferences(
                                db,
                                table,
                                p0,
                              ).restrictionEventsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'monitored_app_id',
                          typedResults: items,
                        ),
                      if (emergencyUnlocksRefs)
                        await $_getPrefetchedDataByColumns<
                          MonitoredApp,
                          $MonitoredAppsTable,
                          EmergencyUnlock,
                          $EmergencyUnlocksTable
                        >(
                          currentTable: table,
                          referencedTable: $$MonitoredAppsTableReferences
                              ._emergencyUnlocksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonitoredAppsTableReferences(
                                db,
                                table,
                                p0,
                              ).emergencyUnlocksRefs,
                          currentColumn: 'id',
                          referencedColumn: 'monitored_app_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MonitoredAppsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonitoredAppsTable,
      MonitoredApp,
      $$MonitoredAppsTableFilterComposer,
      $$MonitoredAppsTableOrderingComposer,
      $$MonitoredAppsTableAnnotationComposer,
      $$MonitoredAppsTableCreateCompanionBuilder,
      $$MonitoredAppsTableUpdateCompanionBuilder,
      (MonitoredApp, $$MonitoredAppsTableReferences),
      MonitoredApp,
      PrefetchHooks Function({
        bool appLimitsRefs,
        bool usageSessionsRefs,
        bool dailyUsageSummariesRefs,
        bool restrictionEventsRefs,
        bool emergencyUnlocksRefs,
      })
    >;
typedef $$AppLimitsTableCreateCompanionBuilder = AppLimitsCompanion Function({
  Value<int> id,
  required int monitoredAppId,
  required int dailyLimitSeconds,
  Value<String> warningThresholds,
  Value<String> enforcementMode,
  Value<bool> isEnabled,
});
typedef $$AppLimitsTableUpdateCompanionBuilder = AppLimitsCompanion Function({
  Value<int> id,
  Value<int> monitoredAppId,
  Value<int> dailyLimitSeconds,
  Value<String> warningThresholds,
  Value<String> enforcementMode,
  Value<bool> isEnabled,
});

final class $$AppLimitsTableReferences
    extends BaseReferences<_$AppDatabase, $AppLimitsTable, AppLimit> {
  $$AppLimitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MonitoredAppsTable _monitoredAppIdTable(_$AppDatabase db) => db
      .monitoredApps
      .createAlias('app_limits__monitored_app_id__monitored_apps__id');

  $$MonitoredAppsTableProcessedTableManager get monitoredAppId {
    final $_column = $_itemColumn<int>('monitored_app_id')!;

    final manager = $$MonitoredAppsTableTableManager(
      $_db,
      $_db.monitoredApps,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_monitoredAppIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AppLimitsTableFilterComposer
    extends Composer<_$AppDatabase, $AppLimitsTable> {
  $$AppLimitsTableFilterComposer({
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

  ColumnFilters<int> get dailyLimitSeconds => $composableBuilder(
    column: $table.dailyLimitSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warningThresholds => $composableBuilder(
    column: $table.warningThresholds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enforcementMode => $composableBuilder(
    column: $table.enforcementMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  $$MonitoredAppsTableFilterComposer get monitoredAppId {
    final $$MonitoredAppsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableFilterComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppLimitsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppLimitsTable> {
  $$AppLimitsTableOrderingComposer({
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

  ColumnOrderings<int> get dailyLimitSeconds => $composableBuilder(
    column: $table.dailyLimitSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warningThresholds => $composableBuilder(
    column: $table.warningThresholds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enforcementMode => $composableBuilder(
    column: $table.enforcementMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonitoredAppsTableOrderingComposer get monitoredAppId {
    final $$MonitoredAppsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableOrderingComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppLimitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppLimitsTable> {
  $$AppLimitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dailyLimitSeconds => $composableBuilder(
    column: $table.dailyLimitSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get warningThresholds => $composableBuilder(
    column: $table.warningThresholds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get enforcementMode => $composableBuilder(
    column: $table.enforcementMode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  $$MonitoredAppsTableAnnotationComposer get monitoredAppId {
    final $$MonitoredAppsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableAnnotationComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AppLimitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppLimitsTable,
          AppLimit,
          $$AppLimitsTableFilterComposer,
          $$AppLimitsTableOrderingComposer,
          $$AppLimitsTableAnnotationComposer,
          $$AppLimitsTableCreateCompanionBuilder,
          $$AppLimitsTableUpdateCompanionBuilder,
          (AppLimit, $$AppLimitsTableReferences),
          AppLimit,
          PrefetchHooks Function({bool monitoredAppId})
        > {
  $$AppLimitsTableTableManager(_$AppDatabase db, $AppLimitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppLimitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppLimitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppLimitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> monitoredAppId = const Value.absent(),
                Value<int> dailyLimitSeconds = const Value.absent(),
                Value<String> warningThresholds = const Value.absent(),
                Value<String> enforcementMode = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
              }) => AppLimitsCompanion(
                id: id,
                monitoredAppId: monitoredAppId,
                dailyLimitSeconds: dailyLimitSeconds,
                warningThresholds: warningThresholds,
                enforcementMode: enforcementMode,
                isEnabled: isEnabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int monitoredAppId,
                required int dailyLimitSeconds,
                Value<String> warningThresholds = const Value.absent(),
                Value<String> enforcementMode = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
              }) => AppLimitsCompanion.insert(
                id: id,
                monitoredAppId: monitoredAppId,
                dailyLimitSeconds: dailyLimitSeconds,
                warningThresholds: warningThresholds,
                enforcementMode: enforcementMode,
                isEnabled: isEnabled,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppLimitsTable, AppLimit>(table),
                  $$AppLimitsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({monitoredAppId = false}) {
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
                    if (monitoredAppId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.monitoredAppId,
                        referencedTable: $$AppLimitsTableReferences
                            ._monitoredAppIdTable(db),
                        referencedColumn: $$AppLimitsTableReferences
                            ._monitoredAppIdTable(db)
                            .id,
                      ) as T;
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

typedef $$AppLimitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppLimitsTable,
      AppLimit,
      $$AppLimitsTableFilterComposer,
      $$AppLimitsTableOrderingComposer,
      $$AppLimitsTableAnnotationComposer,
      $$AppLimitsTableCreateCompanionBuilder,
      $$AppLimitsTableUpdateCompanionBuilder,
      (AppLimit, $$AppLimitsTableReferences),
      AppLimit,
      PrefetchHooks Function({bool monitoredAppId})
    >;
typedef $$UsageSessionsTableCreateCompanionBuilder =
    UsageSessionsCompanion Function({
      Value<int> id,
      required int monitoredAppId,
      required DateTime startedAt,
      required DateTime endedAt,
      required int durationSeconds,
      Value<String> source,
    });
typedef $$UsageSessionsTableUpdateCompanionBuilder =
    UsageSessionsCompanion Function({
      Value<int> id,
      Value<int> monitoredAppId,
      Value<DateTime> startedAt,
      Value<DateTime> endedAt,
      Value<int> durationSeconds,
      Value<String> source,
    });

final class $$UsageSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $UsageSessionsTable, UsageSession> {
  $$UsageSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MonitoredAppsTable _monitoredAppIdTable(_$AppDatabase db) => db
      .monitoredApps
      .createAlias('usage_sessions__monitored_app_id__monitored_apps__id');

  $$MonitoredAppsTableProcessedTableManager get monitoredAppId {
    final $_column = $_itemColumn<int>('monitored_app_id')!;

    final manager = $$MonitoredAppsTableTableManager(
      $_db,
      $_db.monitoredApps,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_monitoredAppIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UsageSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $UsageSessionsTable> {
  $$UsageSessionsTableFilterComposer({
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

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  $$MonitoredAppsTableFilterComposer get monitoredAppId {
    final $$MonitoredAppsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableFilterComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsageSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $UsageSessionsTable> {
  $$UsageSessionsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonitoredAppsTableOrderingComposer get monitoredAppId {
    final $$MonitoredAppsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableOrderingComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsageSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsageSessionsTable> {
  $$UsageSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$MonitoredAppsTableAnnotationComposer get monitoredAppId {
    final $$MonitoredAppsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableAnnotationComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsageSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsageSessionsTable,
          UsageSession,
          $$UsageSessionsTableFilterComposer,
          $$UsageSessionsTableOrderingComposer,
          $$UsageSessionsTableAnnotationComposer,
          $$UsageSessionsTableCreateCompanionBuilder,
          $$UsageSessionsTableUpdateCompanionBuilder,
          (UsageSession, $$UsageSessionsTableReferences),
          UsageSession,
          PrefetchHooks Function({bool monitoredAppId})
        > {
  $$UsageSessionsTableTableManager(_$AppDatabase db, $UsageSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsageSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsageSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsageSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> monitoredAppId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> endedAt = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<String> source = const Value.absent(),
              }) => UsageSessionsCompanion(
                id: id,
                monitoredAppId: monitoredAppId,
                startedAt: startedAt,
                endedAt: endedAt,
                durationSeconds: durationSeconds,
                source: source,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int monitoredAppId,
                required DateTime startedAt,
                required DateTime endedAt,
                required int durationSeconds,
                Value<String> source = const Value.absent(),
              }) => UsageSessionsCompanion.insert(
                id: id,
                monitoredAppId: monitoredAppId,
                startedAt: startedAt,
                endedAt: endedAt,
                durationSeconds: durationSeconds,
                source: source,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsageSessionsTable, UsageSession>(table),
                  $$UsageSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({monitoredAppId = false}) {
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
                    if (monitoredAppId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.monitoredAppId,
                        referencedTable: $$UsageSessionsTableReferences
                            ._monitoredAppIdTable(db),
                        referencedColumn: $$UsageSessionsTableReferences
                            ._monitoredAppIdTable(db)
                            .id,
                      ) as T;
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

typedef $$UsageSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsageSessionsTable,
      UsageSession,
      $$UsageSessionsTableFilterComposer,
      $$UsageSessionsTableOrderingComposer,
      $$UsageSessionsTableAnnotationComposer,
      $$UsageSessionsTableCreateCompanionBuilder,
      $$UsageSessionsTableUpdateCompanionBuilder,
      (UsageSession, $$UsageSessionsTableReferences),
      UsageSession,
      PrefetchHooks Function({bool monitoredAppId})
    >;
typedef $$DailyUsageSummariesTableCreateCompanionBuilder =
    DailyUsageSummariesCompanion Function({
      Value<int> id,
      required int monitoredAppId,
      required DateTime usageDate,
      Value<int> totalDurationSeconds,
    });
typedef $$DailyUsageSummariesTableUpdateCompanionBuilder =
    DailyUsageSummariesCompanion Function({
      Value<int> id,
      Value<int> monitoredAppId,
      Value<DateTime> usageDate,
      Value<int> totalDurationSeconds,
    });

final class $$DailyUsageSummariesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DailyUsageSummariesTable,
          DailyUsageSummary
        > {
  $$DailyUsageSummariesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MonitoredAppsTable _monitoredAppIdTable(_$AppDatabase db) =>
      db.monitoredApps.createAlias(
        'daily_usage_summaries__monitored_app_id__monitored_apps__id',
      );

  $$MonitoredAppsTableProcessedTableManager get monitoredAppId {
    final $_column = $_itemColumn<int>('monitored_app_id')!;

    final manager = $$MonitoredAppsTableTableManager(
      $_db,
      $_db.monitoredApps,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_monitoredAppIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DailyUsageSummariesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyUsageSummariesTable> {
  $$DailyUsageSummariesTableFilterComposer({
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

  ColumnFilters<DateTime> get usageDate => $composableBuilder(
    column: $table.usageDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalDurationSeconds => $composableBuilder(
    column: $table.totalDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  $$MonitoredAppsTableFilterComposer get monitoredAppId {
    final $$MonitoredAppsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableFilterComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyUsageSummariesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyUsageSummariesTable> {
  $$DailyUsageSummariesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get usageDate => $composableBuilder(
    column: $table.usageDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalDurationSeconds => $composableBuilder(
    column: $table.totalDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonitoredAppsTableOrderingComposer get monitoredAppId {
    final $$MonitoredAppsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableOrderingComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyUsageSummariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyUsageSummariesTable> {
  $$DailyUsageSummariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get usageDate =>
      $composableBuilder(column: $table.usageDate, builder: (column) => column);

  GeneratedColumn<int> get totalDurationSeconds => $composableBuilder(
    column: $table.totalDurationSeconds,
    builder: (column) => column,
  );

  $$MonitoredAppsTableAnnotationComposer get monitoredAppId {
    final $$MonitoredAppsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableAnnotationComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyUsageSummariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyUsageSummariesTable,
          DailyUsageSummary,
          $$DailyUsageSummariesTableFilterComposer,
          $$DailyUsageSummariesTableOrderingComposer,
          $$DailyUsageSummariesTableAnnotationComposer,
          $$DailyUsageSummariesTableCreateCompanionBuilder,
          $$DailyUsageSummariesTableUpdateCompanionBuilder,
          (DailyUsageSummary, $$DailyUsageSummariesTableReferences),
          DailyUsageSummary,
          PrefetchHooks Function({bool monitoredAppId})
        > {
  $$DailyUsageSummariesTableTableManager(
    _$AppDatabase db,
    $DailyUsageSummariesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyUsageSummariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyUsageSummariesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DailyUsageSummariesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> monitoredAppId = const Value.absent(),
                Value<DateTime> usageDate = const Value.absent(),
                Value<int> totalDurationSeconds = const Value.absent(),
              }) => DailyUsageSummariesCompanion(
                id: id,
                monitoredAppId: monitoredAppId,
                usageDate: usageDate,
                totalDurationSeconds: totalDurationSeconds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int monitoredAppId,
                required DateTime usageDate,
                Value<int> totalDurationSeconds = const Value.absent(),
              }) => DailyUsageSummariesCompanion.insert(
                id: id,
                monitoredAppId: monitoredAppId,
                usageDate: usageDate,
                totalDurationSeconds: totalDurationSeconds,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyUsageSummariesTable, DailyUsageSummary>(
                    table,
                  ),
                  $$DailyUsageSummariesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({monitoredAppId = false}) {
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
                    if (monitoredAppId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.monitoredAppId,
                        referencedTable: $$DailyUsageSummariesTableReferences
                            ._monitoredAppIdTable(db),
                        referencedColumn: $$DailyUsageSummariesTableReferences
                            ._monitoredAppIdTable(db)
                            .id,
                      ) as T;
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

typedef $$DailyUsageSummariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyUsageSummariesTable,
      DailyUsageSummary,
      $$DailyUsageSummariesTableFilterComposer,
      $$DailyUsageSummariesTableOrderingComposer,
      $$DailyUsageSummariesTableAnnotationComposer,
      $$DailyUsageSummariesTableCreateCompanionBuilder,
      $$DailyUsageSummariesTableUpdateCompanionBuilder,
      (DailyUsageSummary, $$DailyUsageSummariesTableReferences),
      DailyUsageSummary,
      PrefetchHooks Function({bool monitoredAppId})
    >;
typedef $$FocusSessionsTableCreateCompanionBuilder =
    FocusSessionsCompanion Function({
      Value<int> id,
      required String title,
      required int durationMinutes,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      Value<String> status,
    });
typedef $$FocusSessionsTableUpdateCompanionBuilder =
    FocusSessionsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<int> durationMinutes,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<String> status,
    });

class $$FocusSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $FocusSessionsTable> {
  $$FocusSessionsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FocusSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FocusSessionsTable> {
  $$FocusSessionsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FocusSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FocusSessionsTable> {
  $$FocusSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$FocusSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FocusSessionsTable,
          FocusSession,
          $$FocusSessionsTableFilterComposer,
          $$FocusSessionsTableOrderingComposer,
          $$FocusSessionsTableAnnotationComposer,
          $$FocusSessionsTableCreateCompanionBuilder,
          $$FocusSessionsTableUpdateCompanionBuilder,
          (
            FocusSession,
            BaseReferences<_$AppDatabase, $FocusSessionsTable, FocusSession>,
          ),
          FocusSession,
          PrefetchHooks Function()
        > {
  $$FocusSessionsTableTableManager(_$AppDatabase db, $FocusSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FocusSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FocusSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FocusSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => FocusSessionsCompanion(
                id: id,
                title: title,
                durationMinutes: durationMinutes,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required int durationMinutes,
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => FocusSessionsCompanion.insert(
                id: id,
                title: title,
                durationMinutes: durationMinutes,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FocusSessionsTable, FocusSession>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $FocusSessionsTable,
                    FocusSession
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FocusSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FocusSessionsTable,
      FocusSession,
      $$FocusSessionsTableFilterComposer,
      $$FocusSessionsTableOrderingComposer,
      $$FocusSessionsTableAnnotationComposer,
      $$FocusSessionsTableCreateCompanionBuilder,
      $$FocusSessionsTableUpdateCompanionBuilder,
      (
        FocusSession,
        BaseReferences<_$AppDatabase, $FocusSessionsTable, FocusSession>,
      ),
      FocusSession,
      PrefetchHooks Function()
    >;
typedef $$DailyGoalsTableCreateCompanionBuilder = DailyGoalsCompanion Function({
  Value<int> id,
  required String title,
  required int targetMinutes,
  Value<int> completedMinutes,
  required DateTime goalDate,
  Value<String> status,
});
typedef $$DailyGoalsTableUpdateCompanionBuilder = DailyGoalsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<int> targetMinutes,
  Value<int> completedMinutes,
  Value<DateTime> goalDate,
  Value<String> status,
});

class $$DailyGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyGoalsTable> {
  $$DailyGoalsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetMinutes => $composableBuilder(
    column: $table.targetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedMinutes => $composableBuilder(
    column: $table.completedMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get goalDate => $composableBuilder(
    column: $table.goalDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyGoalsTable> {
  $$DailyGoalsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetMinutes => $composableBuilder(
    column: $table.targetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedMinutes => $composableBuilder(
    column: $table.completedMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get goalDate => $composableBuilder(
    column: $table.goalDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyGoalsTable> {
  $$DailyGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get targetMinutes => $composableBuilder(
    column: $table.targetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedMinutes => $composableBuilder(
    column: $table.completedMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get goalDate =>
      $composableBuilder(column: $table.goalDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$DailyGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyGoalsTable,
          DailyGoal,
          $$DailyGoalsTableFilterComposer,
          $$DailyGoalsTableOrderingComposer,
          $$DailyGoalsTableAnnotationComposer,
          $$DailyGoalsTableCreateCompanionBuilder,
          $$DailyGoalsTableUpdateCompanionBuilder,
          (
            DailyGoal,
            BaseReferences<_$AppDatabase, $DailyGoalsTable, DailyGoal>,
          ),
          DailyGoal,
          PrefetchHooks Function()
        > {
  $$DailyGoalsTableTableManager(_$AppDatabase db, $DailyGoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> targetMinutes = const Value.absent(),
                Value<int> completedMinutes = const Value.absent(),
                Value<DateTime> goalDate = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => DailyGoalsCompanion(
                id: id,
                title: title,
                targetMinutes: targetMinutes,
                completedMinutes: completedMinutes,
                goalDate: goalDate,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required int targetMinutes,
                Value<int> completedMinutes = const Value.absent(),
                required DateTime goalDate,
                Value<String> status = const Value.absent(),
              }) => DailyGoalsCompanion.insert(
                id: id,
                title: title,
                targetMinutes: targetMinutes,
                completedMinutes: completedMinutes,
                goalDate: goalDate,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyGoalsTable, DailyGoal>(table),
                  BaseReferences<_$AppDatabase, $DailyGoalsTable, DailyGoal>(
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

typedef $$DailyGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyGoalsTable,
      DailyGoal,
      $$DailyGoalsTableFilterComposer,
      $$DailyGoalsTableOrderingComposer,
      $$DailyGoalsTableAnnotationComposer,
      $$DailyGoalsTableCreateCompanionBuilder,
      $$DailyGoalsTableUpdateCompanionBuilder,
      (DailyGoal, BaseReferences<_$AppDatabase, $DailyGoalsTable, DailyGoal>),
      DailyGoal,
      PrefetchHooks Function()
    >;
typedef $$RestrictionEventsTableCreateCompanionBuilder =
    RestrictionEventsCompanion Function({
      Value<int> id,
      required int monitoredAppId,
      required String eventType,
      Value<DateTime> occurredAt,
      Value<String?> details,
    });
typedef $$RestrictionEventsTableUpdateCompanionBuilder =
    RestrictionEventsCompanion Function({
      Value<int> id,
      Value<int> monitoredAppId,
      Value<String> eventType,
      Value<DateTime> occurredAt,
      Value<String?> details,
    });

final class $$RestrictionEventsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RestrictionEventsTable,
          RestrictionEvent
        > {
  $$RestrictionEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MonitoredAppsTable _monitoredAppIdTable(_$AppDatabase db) => db
      .monitoredApps
      .createAlias('restriction_events__monitored_app_id__monitored_apps__id');

  $$MonitoredAppsTableProcessedTableManager get monitoredAppId {
    final $_column = $_itemColumn<int>('monitored_app_id')!;

    final manager = $$MonitoredAppsTableTableManager(
      $_db,
      $_db.monitoredApps,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_monitoredAppIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RestrictionEventsTableFilterComposer
    extends Composer<_$AppDatabase, $RestrictionEventsTable> {
  $$RestrictionEventsTableFilterComposer({
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

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  $$MonitoredAppsTableFilterComposer get monitoredAppId {
    final $$MonitoredAppsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableFilterComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RestrictionEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $RestrictionEventsTable> {
  $$RestrictionEventsTableOrderingComposer({
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

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonitoredAppsTableOrderingComposer get monitoredAppId {
    final $$MonitoredAppsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableOrderingComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RestrictionEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RestrictionEventsTable> {
  $$RestrictionEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  $$MonitoredAppsTableAnnotationComposer get monitoredAppId {
    final $$MonitoredAppsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableAnnotationComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RestrictionEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RestrictionEventsTable,
          RestrictionEvent,
          $$RestrictionEventsTableFilterComposer,
          $$RestrictionEventsTableOrderingComposer,
          $$RestrictionEventsTableAnnotationComposer,
          $$RestrictionEventsTableCreateCompanionBuilder,
          $$RestrictionEventsTableUpdateCompanionBuilder,
          (RestrictionEvent, $$RestrictionEventsTableReferences),
          RestrictionEvent,
          PrefetchHooks Function({bool monitoredAppId})
        > {
  $$RestrictionEventsTableTableManager(
    _$AppDatabase db,
    $RestrictionEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RestrictionEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RestrictionEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RestrictionEventsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> monitoredAppId = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String?> details = const Value.absent(),
              }) => RestrictionEventsCompanion(
                id: id,
                monitoredAppId: monitoredAppId,
                eventType: eventType,
                occurredAt: occurredAt,
                details: details,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int monitoredAppId,
                required String eventType,
                Value<DateTime> occurredAt = const Value.absent(),
                Value<String?> details = const Value.absent(),
              }) => RestrictionEventsCompanion.insert(
                id: id,
                monitoredAppId: monitoredAppId,
                eventType: eventType,
                occurredAt: occurredAt,
                details: details,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RestrictionEventsTable, RestrictionEvent>(table),
                  $$RestrictionEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({monitoredAppId = false}) {
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
                    if (monitoredAppId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.monitoredAppId,
                        referencedTable: $$RestrictionEventsTableReferences
                            ._monitoredAppIdTable(db),
                        referencedColumn: $$RestrictionEventsTableReferences
                            ._monitoredAppIdTable(db)
                            .id,
                      ) as T;
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

typedef $$RestrictionEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RestrictionEventsTable,
      RestrictionEvent,
      $$RestrictionEventsTableFilterComposer,
      $$RestrictionEventsTableOrderingComposer,
      $$RestrictionEventsTableAnnotationComposer,
      $$RestrictionEventsTableCreateCompanionBuilder,
      $$RestrictionEventsTableUpdateCompanionBuilder,
      (RestrictionEvent, $$RestrictionEventsTableReferences),
      RestrictionEvent,
      PrefetchHooks Function({bool monitoredAppId})
    >;
typedef $$EmergencyUnlocksTableCreateCompanionBuilder =
    EmergencyUnlocksCompanion Function({
      Value<int> id,
      required int monitoredAppId,
      Value<DateTime> requestedAt,
      required DateTime expiresAt,
      required String reason,
      Value<String> status,
    });
typedef $$EmergencyUnlocksTableUpdateCompanionBuilder =
    EmergencyUnlocksCompanion Function({
      Value<int> id,
      Value<int> monitoredAppId,
      Value<DateTime> requestedAt,
      Value<DateTime> expiresAt,
      Value<String> reason,
      Value<String> status,
    });

final class $$EmergencyUnlocksTableReferences
    extends
        BaseReferences<_$AppDatabase, $EmergencyUnlocksTable, EmergencyUnlock> {
  $$EmergencyUnlocksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MonitoredAppsTable _monitoredAppIdTable(_$AppDatabase db) => db
      .monitoredApps
      .createAlias('emergency_unlocks__monitored_app_id__monitored_apps__id');

  $$MonitoredAppsTableProcessedTableManager get monitoredAppId {
    final $_column = $_itemColumn<int>('monitored_app_id')!;

    final manager = $$MonitoredAppsTableTableManager(
      $_db,
      $_db.monitoredApps,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_monitoredAppIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EmergencyUnlocksTableFilterComposer
    extends Composer<_$AppDatabase, $EmergencyUnlocksTable> {
  $$EmergencyUnlocksTableFilterComposer({
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

  ColumnFilters<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$MonitoredAppsTableFilterComposer get monitoredAppId {
    final $$MonitoredAppsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableFilterComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmergencyUnlocksTableOrderingComposer
    extends Composer<_$AppDatabase, $EmergencyUnlocksTable> {
  $$EmergencyUnlocksTableOrderingComposer({
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

  ColumnOrderings<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonitoredAppsTableOrderingComposer get monitoredAppId {
    final $$MonitoredAppsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableOrderingComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmergencyUnlocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmergencyUnlocksTable> {
  $$EmergencyUnlocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$MonitoredAppsTableAnnotationComposer get monitoredAppId {
    final $$MonitoredAppsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monitoredAppId,
      referencedTable: $db.monitoredApps,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonitoredAppsTableAnnotationComposer(
            $db: $db,
            $table: $db.monitoredApps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmergencyUnlocksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmergencyUnlocksTable,
          EmergencyUnlock,
          $$EmergencyUnlocksTableFilterComposer,
          $$EmergencyUnlocksTableOrderingComposer,
          $$EmergencyUnlocksTableAnnotationComposer,
          $$EmergencyUnlocksTableCreateCompanionBuilder,
          $$EmergencyUnlocksTableUpdateCompanionBuilder,
          (EmergencyUnlock, $$EmergencyUnlocksTableReferences),
          EmergencyUnlock,
          PrefetchHooks Function({bool monitoredAppId})
        > {
  $$EmergencyUnlocksTableTableManager(
    _$AppDatabase db,
    $EmergencyUnlocksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmergencyUnlocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmergencyUnlocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmergencyUnlocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> monitoredAppId = const Value.absent(),
                Value<DateTime> requestedAt = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => EmergencyUnlocksCompanion(
                id: id,
                monitoredAppId: monitoredAppId,
                requestedAt: requestedAt,
                expiresAt: expiresAt,
                reason: reason,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int monitoredAppId,
                Value<DateTime> requestedAt = const Value.absent(),
                required DateTime expiresAt,
                required String reason,
                Value<String> status = const Value.absent(),
              }) => EmergencyUnlocksCompanion.insert(
                id: id,
                monitoredAppId: monitoredAppId,
                requestedAt: requestedAt,
                expiresAt: expiresAt,
                reason: reason,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EmergencyUnlocksTable, EmergencyUnlock>(table),
                  $$EmergencyUnlocksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({monitoredAppId = false}) {
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
                    if (monitoredAppId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.monitoredAppId,
                        referencedTable: $$EmergencyUnlocksTableReferences
                            ._monitoredAppIdTable(db),
                        referencedColumn: $$EmergencyUnlocksTableReferences
                            ._monitoredAppIdTable(db)
                            .id,
                      ) as T;
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

typedef $$EmergencyUnlocksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmergencyUnlocksTable,
      EmergencyUnlock,
      $$EmergencyUnlocksTableFilterComposer,
      $$EmergencyUnlocksTableOrderingComposer,
      $$EmergencyUnlocksTableAnnotationComposer,
      $$EmergencyUnlocksTableCreateCompanionBuilder,
      $$EmergencyUnlocksTableUpdateCompanionBuilder,
      (EmergencyUnlock, $$EmergencyUnlocksTableReferences),
      EmergencyUnlock,
      PrefetchHooks Function({bool monitoredAppId})
    >;
typedef $$DailyRoutinesTableCreateCompanionBuilder =
    DailyRoutinesCompanion Function({
      Value<int> id,
      required String title,
      required String startTime,
      required String endTime,
      required String selectedDays,
      Value<bool> isEnabled,
    });
typedef $$DailyRoutinesTableUpdateCompanionBuilder =
    DailyRoutinesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> startTime,
      Value<String> endTime,
      Value<String> selectedDays,
      Value<bool> isEnabled,
    });

class $$DailyRoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyRoutinesTable> {
  $$DailyRoutinesTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedDays => $composableBuilder(
    column: $table.selectedDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyRoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyRoutinesTable> {
  $$DailyRoutinesTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedDays => $composableBuilder(
    column: $table.selectedDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyRoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyRoutinesTable> {
  $$DailyRoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<String> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get selectedDays => $composableBuilder(
    column: $table.selectedDays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);
}

class $$DailyRoutinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyRoutinesTable,
          DailyRoutine,
          $$DailyRoutinesTableFilterComposer,
          $$DailyRoutinesTableOrderingComposer,
          $$DailyRoutinesTableAnnotationComposer,
          $$DailyRoutinesTableCreateCompanionBuilder,
          $$DailyRoutinesTableUpdateCompanionBuilder,
          (
            DailyRoutine,
            BaseReferences<_$AppDatabase, $DailyRoutinesTable, DailyRoutine>,
          ),
          DailyRoutine,
          PrefetchHooks Function()
        > {
  $$DailyRoutinesTableTableManager(_$AppDatabase db, $DailyRoutinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyRoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyRoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyRoutinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> startTime = const Value.absent(),
                Value<String> endTime = const Value.absent(),
                Value<String> selectedDays = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
              }) => DailyRoutinesCompanion(
                id: id,
                title: title,
                startTime: startTime,
                endTime: endTime,
                selectedDays: selectedDays,
                isEnabled: isEnabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String startTime,
                required String endTime,
                required String selectedDays,
                Value<bool> isEnabled = const Value.absent(),
              }) => DailyRoutinesCompanion.insert(
                id: id,
                title: title,
                startTime: startTime,
                endTime: endTime,
                selectedDays: selectedDays,
                isEnabled: isEnabled,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyRoutinesTable, DailyRoutine>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DailyRoutinesTable,
                    DailyRoutine
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyRoutinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyRoutinesTable,
      DailyRoutine,
      $$DailyRoutinesTableFilterComposer,
      $$DailyRoutinesTableOrderingComposer,
      $$DailyRoutinesTableAnnotationComposer,
      $$DailyRoutinesTableCreateCompanionBuilder,
      $$DailyRoutinesTableUpdateCompanionBuilder,
      (
        DailyRoutine,
        BaseReferences<_$AppDatabase, $DailyRoutinesTable, DailyRoutine>,
      ),
      DailyRoutine,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MonitoredAppsTableTableManager get monitoredApps =>
      $$MonitoredAppsTableTableManager(_db, _db.monitoredApps);
  $$AppLimitsTableTableManager get appLimits =>
      $$AppLimitsTableTableManager(_db, _db.appLimits);
  $$UsageSessionsTableTableManager get usageSessions =>
      $$UsageSessionsTableTableManager(_db, _db.usageSessions);
  $$DailyUsageSummariesTableTableManager get dailyUsageSummaries =>
      $$DailyUsageSummariesTableTableManager(_db, _db.dailyUsageSummaries);
  $$FocusSessionsTableTableManager get focusSessions =>
      $$FocusSessionsTableTableManager(_db, _db.focusSessions);
  $$DailyGoalsTableTableManager get dailyGoals =>
      $$DailyGoalsTableTableManager(_db, _db.dailyGoals);
  $$RestrictionEventsTableTableManager get restrictionEvents =>
      $$RestrictionEventsTableTableManager(_db, _db.restrictionEvents);
  $$EmergencyUnlocksTableTableManager get emergencyUnlocks =>
      $$EmergencyUnlocksTableTableManager(_db, _db.emergencyUnlocks);
  $$DailyRoutinesTableTableManager get dailyRoutines =>
      $$DailyRoutinesTableTableManager(_db, _db.dailyRoutines);
}
