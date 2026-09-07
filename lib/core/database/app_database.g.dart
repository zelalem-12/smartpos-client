// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StoreConfigsTable extends StoreConfigs
    with TableInfo<$StoreConfigsTable, StoreConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoreConfigsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _licenseKeyMeta = const VerificationMeta(
    'licenseKey',
  );
  @override
  late final GeneratedColumn<String> licenseKey = GeneratedColumn<String>(
    'license_key',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessNameMeta = const VerificationMeta(
    'businessName',
  );
  @override
  late final GeneratedColumn<String> businessName = GeneratedColumn<String>(
    'business_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tradeNameMeta = const VerificationMeta(
    'tradeName',
  );
  @override
  late final GeneratedColumn<String> tradeName = GeneratedColumn<String>(
    'trade_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tinMeta = const VerificationMeta('tin');
  @override
  late final GeneratedColumn<String> tin = GeneratedColumn<String>(
    'tin',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 10,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vatRegNoMeta = const VerificationMeta(
    'vatRegNo',
  );
  @override
  late final GeneratedColumn<String> vatRegNo = GeneratedColumn<String>(
    'vat_reg_no',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sectorMeta = const VerificationMeta('sector');
  @override
  late final GeneratedColumn<String> sector = GeneratedColumn<String>(
    'sector',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceSerialMeta = const VerificationMeta(
    'deviceSerial',
  );
  @override
  late final GeneratedColumn<String> deviceSerial = GeneratedColumn<String>(
    'device_serial',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    licenseKey,
    businessName,
    tradeName,
    tin,
    vatRegNo,
    sector,
    address,
    deviceSerial,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'store_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoreConfig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('license_key')) {
      context.handle(
        _licenseKeyMeta,
        licenseKey.isAcceptableOrUnknown(data['license_key']!, _licenseKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_licenseKeyMeta);
    }
    if (data.containsKey('business_name')) {
      context.handle(
        _businessNameMeta,
        businessName.isAcceptableOrUnknown(
          data['business_name']!,
          _businessNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_businessNameMeta);
    }
    if (data.containsKey('trade_name')) {
      context.handle(
        _tradeNameMeta,
        tradeName.isAcceptableOrUnknown(data['trade_name']!, _tradeNameMeta),
      );
    } else if (isInserting) {
      context.missing(_tradeNameMeta);
    }
    if (data.containsKey('tin')) {
      context.handle(
        _tinMeta,
        tin.isAcceptableOrUnknown(data['tin']!, _tinMeta),
      );
    } else if (isInserting) {
      context.missing(_tinMeta);
    }
    if (data.containsKey('vat_reg_no')) {
      context.handle(
        _vatRegNoMeta,
        vatRegNo.isAcceptableOrUnknown(data['vat_reg_no']!, _vatRegNoMeta),
      );
    } else if (isInserting) {
      context.missing(_vatRegNoMeta);
    }
    if (data.containsKey('sector')) {
      context.handle(
        _sectorMeta,
        sector.isAcceptableOrUnknown(data['sector']!, _sectorMeta),
      );
    } else if (isInserting) {
      context.missing(_sectorMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('device_serial')) {
      context.handle(
        _deviceSerialMeta,
        deviceSerial.isAcceptableOrUnknown(
          data['device_serial']!,
          _deviceSerialMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deviceSerialMeta);
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
  StoreConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoreConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      licenseKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_key'],
      )!,
      businessName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_name'],
      )!,
      tradeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trade_name'],
      )!,
      tin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tin'],
      )!,
      vatRegNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vat_reg_no'],
      )!,
      sector: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sector'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      deviceSerial: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_serial'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StoreConfigsTable createAlias(String alias) {
    return $StoreConfigsTable(attachedDatabase, alias);
  }
}

class StoreConfig extends DataClass implements Insertable<StoreConfig> {
  /// Primary key — only one row expected per device.
  final int id;

  /// License/activation key used to provision this device.
  final String licenseKey;

  /// Legal business name registered with Ministry.
  final String businessName;

  /// Trade name printed on receipts.
  final String tradeName;

  /// Taxpayer Identification Number (10 digits).
  final String tin;

  /// VAT Registration Number.
  final String vatRegNo;

  /// Designated business sector from Annex 2.
  final String sector;

  /// Physical store address.
  final String address;

  /// Bound device serial number (hardware fingerprint).
  final String deviceSerial;

  /// When this configuration was created.
  final DateTime createdAt;
  const StoreConfig({
    required this.id,
    required this.licenseKey,
    required this.businessName,
    required this.tradeName,
    required this.tin,
    required this.vatRegNo,
    required this.sector,
    required this.address,
    required this.deviceSerial,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['license_key'] = Variable<String>(licenseKey);
    map['business_name'] = Variable<String>(businessName);
    map['trade_name'] = Variable<String>(tradeName);
    map['tin'] = Variable<String>(tin);
    map['vat_reg_no'] = Variable<String>(vatRegNo);
    map['sector'] = Variable<String>(sector);
    map['address'] = Variable<String>(address);
    map['device_serial'] = Variable<String>(deviceSerial);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StoreConfigsCompanion toCompanion(bool nullToAbsent) {
    return StoreConfigsCompanion(
      id: Value(id),
      licenseKey: Value(licenseKey),
      businessName: Value(businessName),
      tradeName: Value(tradeName),
      tin: Value(tin),
      vatRegNo: Value(vatRegNo),
      sector: Value(sector),
      address: Value(address),
      deviceSerial: Value(deviceSerial),
      createdAt: Value(createdAt),
    );
  }

  factory StoreConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoreConfig(
      id: serializer.fromJson<int>(json['id']),
      licenseKey: serializer.fromJson<String>(json['licenseKey']),
      businessName: serializer.fromJson<String>(json['businessName']),
      tradeName: serializer.fromJson<String>(json['tradeName']),
      tin: serializer.fromJson<String>(json['tin']),
      vatRegNo: serializer.fromJson<String>(json['vatRegNo']),
      sector: serializer.fromJson<String>(json['sector']),
      address: serializer.fromJson<String>(json['address']),
      deviceSerial: serializer.fromJson<String>(json['deviceSerial']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'licenseKey': serializer.toJson<String>(licenseKey),
      'businessName': serializer.toJson<String>(businessName),
      'tradeName': serializer.toJson<String>(tradeName),
      'tin': serializer.toJson<String>(tin),
      'vatRegNo': serializer.toJson<String>(vatRegNo),
      'sector': serializer.toJson<String>(sector),
      'address': serializer.toJson<String>(address),
      'deviceSerial': serializer.toJson<String>(deviceSerial),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StoreConfig copyWith({
    int? id,
    String? licenseKey,
    String? businessName,
    String? tradeName,
    String? tin,
    String? vatRegNo,
    String? sector,
    String? address,
    String? deviceSerial,
    DateTime? createdAt,
  }) => StoreConfig(
    id: id ?? this.id,
    licenseKey: licenseKey ?? this.licenseKey,
    businessName: businessName ?? this.businessName,
    tradeName: tradeName ?? this.tradeName,
    tin: tin ?? this.tin,
    vatRegNo: vatRegNo ?? this.vatRegNo,
    sector: sector ?? this.sector,
    address: address ?? this.address,
    deviceSerial: deviceSerial ?? this.deviceSerial,
    createdAt: createdAt ?? this.createdAt,
  );
  StoreConfig copyWithCompanion(StoreConfigsCompanion data) {
    return StoreConfig(
      id: data.id.present ? data.id.value : this.id,
      licenseKey: data.licenseKey.present
          ? data.licenseKey.value
          : this.licenseKey,
      businessName: data.businessName.present
          ? data.businessName.value
          : this.businessName,
      tradeName: data.tradeName.present ? data.tradeName.value : this.tradeName,
      tin: data.tin.present ? data.tin.value : this.tin,
      vatRegNo: data.vatRegNo.present ? data.vatRegNo.value : this.vatRegNo,
      sector: data.sector.present ? data.sector.value : this.sector,
      address: data.address.present ? data.address.value : this.address,
      deviceSerial: data.deviceSerial.present
          ? data.deviceSerial.value
          : this.deviceSerial,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoreConfig(')
          ..write('id: $id, ')
          ..write('licenseKey: $licenseKey, ')
          ..write('businessName: $businessName, ')
          ..write('tradeName: $tradeName, ')
          ..write('tin: $tin, ')
          ..write('vatRegNo: $vatRegNo, ')
          ..write('sector: $sector, ')
          ..write('address: $address, ')
          ..write('deviceSerial: $deviceSerial, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    licenseKey,
    businessName,
    tradeName,
    tin,
    vatRegNo,
    sector,
    address,
    deviceSerial,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoreConfig &&
          other.id == this.id &&
          other.licenseKey == this.licenseKey &&
          other.businessName == this.businessName &&
          other.tradeName == this.tradeName &&
          other.tin == this.tin &&
          other.vatRegNo == this.vatRegNo &&
          other.sector == this.sector &&
          other.address == this.address &&
          other.deviceSerial == this.deviceSerial &&
          other.createdAt == this.createdAt);
}

class StoreConfigsCompanion extends UpdateCompanion<StoreConfig> {
  final Value<int> id;
  final Value<String> licenseKey;
  final Value<String> businessName;
  final Value<String> tradeName;
  final Value<String> tin;
  final Value<String> vatRegNo;
  final Value<String> sector;
  final Value<String> address;
  final Value<String> deviceSerial;
  final Value<DateTime> createdAt;
  const StoreConfigsCompanion({
    this.id = const Value.absent(),
    this.licenseKey = const Value.absent(),
    this.businessName = const Value.absent(),
    this.tradeName = const Value.absent(),
    this.tin = const Value.absent(),
    this.vatRegNo = const Value.absent(),
    this.sector = const Value.absent(),
    this.address = const Value.absent(),
    this.deviceSerial = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StoreConfigsCompanion.insert({
    this.id = const Value.absent(),
    required String licenseKey,
    required String businessName,
    required String tradeName,
    required String tin,
    required String vatRegNo,
    required String sector,
    required String address,
    required String deviceSerial,
    this.createdAt = const Value.absent(),
  }) : licenseKey = Value(licenseKey),
       businessName = Value(businessName),
       tradeName = Value(tradeName),
       tin = Value(tin),
       vatRegNo = Value(vatRegNo),
       sector = Value(sector),
       address = Value(address),
       deviceSerial = Value(deviceSerial);
  static Insertable<StoreConfig> custom({
    Expression<int>? id,
    Expression<String>? licenseKey,
    Expression<String>? businessName,
    Expression<String>? tradeName,
    Expression<String>? tin,
    Expression<String>? vatRegNo,
    Expression<String>? sector,
    Expression<String>? address,
    Expression<String>? deviceSerial,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (licenseKey != null) 'license_key': licenseKey,
      if (businessName != null) 'business_name': businessName,
      if (tradeName != null) 'trade_name': tradeName,
      if (tin != null) 'tin': tin,
      if (vatRegNo != null) 'vat_reg_no': vatRegNo,
      if (sector != null) 'sector': sector,
      if (address != null) 'address': address,
      if (deviceSerial != null) 'device_serial': deviceSerial,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StoreConfigsCompanion copyWith({
    Value<int>? id,
    Value<String>? licenseKey,
    Value<String>? businessName,
    Value<String>? tradeName,
    Value<String>? tin,
    Value<String>? vatRegNo,
    Value<String>? sector,
    Value<String>? address,
    Value<String>? deviceSerial,
    Value<DateTime>? createdAt,
  }) {
    return StoreConfigsCompanion(
      id: id ?? this.id,
      licenseKey: licenseKey ?? this.licenseKey,
      businessName: businessName ?? this.businessName,
      tradeName: tradeName ?? this.tradeName,
      tin: tin ?? this.tin,
      vatRegNo: vatRegNo ?? this.vatRegNo,
      sector: sector ?? this.sector,
      address: address ?? this.address,
      deviceSerial: deviceSerial ?? this.deviceSerial,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (licenseKey.present) {
      map['license_key'] = Variable<String>(licenseKey.value);
    }
    if (businessName.present) {
      map['business_name'] = Variable<String>(businessName.value);
    }
    if (tradeName.present) {
      map['trade_name'] = Variable<String>(tradeName.value);
    }
    if (tin.present) {
      map['tin'] = Variable<String>(tin.value);
    }
    if (vatRegNo.present) {
      map['vat_reg_no'] = Variable<String>(vatRegNo.value);
    }
    if (sector.present) {
      map['sector'] = Variable<String>(sector.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (deviceSerial.present) {
      map['device_serial'] = Variable<String>(deviceSerial.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoreConfigsCompanion(')
          ..write('id: $id, ')
          ..write('licenseKey: $licenseKey, ')
          ..write('businessName: $businessName, ')
          ..write('tradeName: $tradeName, ')
          ..write('tin: $tin, ')
          ..write('vatRegNo: $vatRegNo, ')
          ..write('sector: $sector, ')
          ..write('address: $address, ')
          ..write('deviceSerial: $deviceSerial, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinHashMeta = const VerificationMeta(
    'pinHash',
  );
  @override
  late final GeneratedColumn<String> pinHash = GeneratedColumn<String>(
    'pin_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    role,
    pinHash,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('pin_hash')) {
      context.handle(
        _pinHashMeta,
        pinHash.isAcceptableOrUnknown(data['pin_hash']!, _pinHashMeta),
      );
    } else if (isInserting) {
      context.missing(_pinHashMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      pinHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_hash'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  /// UUID primary key.
  final String id;

  /// Display name (e.g. "Abebe Bikila").
  final String name;

  /// Role: 'MANAGER' or 'CASHIER'.
  final String role;

  /// Hashed 4-digit PIN (SHA-256).
  final String pinHash;

  /// Whether this user account is active.
  final bool isActive;

  /// When this user was created.
  final DateTime createdAt;

  /// When this user was last updated (e.g. PIN change, deactivation).
  final DateTime? updatedAt;
  const User({
    required this.id,
    required this.name,
    required this.role,
    required this.pinHash,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['role'] = Variable<String>(role);
    map['pin_hash'] = Variable<String>(pinHash);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      role: Value(role),
      pinHash: Value(pinHash),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      role: serializer.fromJson<String>(json['role']),
      pinHash: serializer.fromJson<String>(json['pinHash']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'role': serializer.toJson<String>(role),
      'pinHash': serializer.toJson<String>(pinHash),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? role,
    String? pinHash,
    bool? isActive,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    role: role ?? this.role,
    pinHash: pinHash ?? this.pinHash,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      role: data.role.present ? data.role.value : this.role,
      pinHash: data.pinHash.present ? data.pinHash.value : this.pinHash,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('pinHash: $pinHash, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, role, pinHash, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.role == this.role &&
          other.pinHash == this.pinHash &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> role;
  final Value<String> pinHash;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.role = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String name,
    required String role,
    required String pinHash,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       role = Value(role),
       pinHash = Value(pinHash);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? role,
    Expression<String>? pinHash,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (role != null) 'role': role,
      if (pinHash != null) 'pin_hash': pinHash,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? role,
    Value<String>? pinHash,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      pinHash: pinHash ?? this.pinHash,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (pinHash.present) {
      map['pin_hash'] = Variable<String>(pinHash.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('role: $role, ')
          ..write('pinHash: $pinHash, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StoreConfigsTable storeConfigs = $StoreConfigsTable(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [storeConfigs, users];
}

typedef $$StoreConfigsTableCreateCompanionBuilder =
    StoreConfigsCompanion Function({
      Value<int> id,
      required String licenseKey,
      required String businessName,
      required String tradeName,
      required String tin,
      required String vatRegNo,
      required String sector,
      required String address,
      required String deviceSerial,
      Value<DateTime> createdAt,
    });
typedef $$StoreConfigsTableUpdateCompanionBuilder =
    StoreConfigsCompanion Function({
      Value<int> id,
      Value<String> licenseKey,
      Value<String> businessName,
      Value<String> tradeName,
      Value<String> tin,
      Value<String> vatRegNo,
      Value<String> sector,
      Value<String> address,
      Value<String> deviceSerial,
      Value<DateTime> createdAt,
    });

class $$StoreConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $StoreConfigsTable> {
  $$StoreConfigsTableFilterComposer({
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

  ColumnFilters<String> get licenseKey => $composableBuilder(
    column: $table.licenseKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tradeName => $composableBuilder(
    column: $table.tradeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tin => $composableBuilder(
    column: $table.tin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vatRegNo => $composableBuilder(
    column: $table.vatRegNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sector => $composableBuilder(
    column: $table.sector,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceSerial => $composableBuilder(
    column: $table.deviceSerial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoreConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $StoreConfigsTable> {
  $$StoreConfigsTableOrderingComposer({
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

  ColumnOrderings<String> get licenseKey => $composableBuilder(
    column: $table.licenseKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tradeName => $composableBuilder(
    column: $table.tradeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tin => $composableBuilder(
    column: $table.tin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vatRegNo => $composableBuilder(
    column: $table.vatRegNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sector => $composableBuilder(
    column: $table.sector,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceSerial => $composableBuilder(
    column: $table.deviceSerial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoreConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoreConfigsTable> {
  $$StoreConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get licenseKey => $composableBuilder(
    column: $table.licenseKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get businessName => $composableBuilder(
    column: $table.businessName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tradeName =>
      $composableBuilder(column: $table.tradeName, builder: (column) => column);

  GeneratedColumn<String> get tin =>
      $composableBuilder(column: $table.tin, builder: (column) => column);

  GeneratedColumn<String> get vatRegNo =>
      $composableBuilder(column: $table.vatRegNo, builder: (column) => column);

  GeneratedColumn<String> get sector =>
      $composableBuilder(column: $table.sector, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get deviceSerial => $composableBuilder(
    column: $table.deviceSerial,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$StoreConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoreConfigsTable,
          StoreConfig,
          $$StoreConfigsTableFilterComposer,
          $$StoreConfigsTableOrderingComposer,
          $$StoreConfigsTableAnnotationComposer,
          $$StoreConfigsTableCreateCompanionBuilder,
          $$StoreConfigsTableUpdateCompanionBuilder,
          (
            StoreConfig,
            BaseReferences<_$AppDatabase, $StoreConfigsTable, StoreConfig>,
          ),
          StoreConfig,
          PrefetchHooks Function()
        > {
  $$StoreConfigsTableTableManager(_$AppDatabase db, $StoreConfigsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoreConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoreConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoreConfigsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> licenseKey = const Value.absent(),
                Value<String> businessName = const Value.absent(),
                Value<String> tradeName = const Value.absent(),
                Value<String> tin = const Value.absent(),
                Value<String> vatRegNo = const Value.absent(),
                Value<String> sector = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> deviceSerial = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StoreConfigsCompanion(
                id: id,
                licenseKey: licenseKey,
                businessName: businessName,
                tradeName: tradeName,
                tin: tin,
                vatRegNo: vatRegNo,
                sector: sector,
                address: address,
                deviceSerial: deviceSerial,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String licenseKey,
                required String businessName,
                required String tradeName,
                required String tin,
                required String vatRegNo,
                required String sector,
                required String address,
                required String deviceSerial,
                Value<DateTime> createdAt = const Value.absent(),
              }) => StoreConfigsCompanion.insert(
                id: id,
                licenseKey: licenseKey,
                businessName: businessName,
                tradeName: tradeName,
                tin: tin,
                vatRegNo: vatRegNo,
                sector: sector,
                address: address,
                deviceSerial: deviceSerial,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StoreConfigsTable, StoreConfig>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $StoreConfigsTable,
                    StoreConfig
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoreConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoreConfigsTable,
      StoreConfig,
      $$StoreConfigsTableFilterComposer,
      $$StoreConfigsTableOrderingComposer,
      $$StoreConfigsTableAnnotationComposer,
      $$StoreConfigsTableCreateCompanionBuilder,
      $$StoreConfigsTableUpdateCompanionBuilder,
      (
        StoreConfig,
        BaseReferences<_$AppDatabase, $StoreConfigsTable, StoreConfig>,
      ),
      StoreConfig,
      PrefetchHooks Function()
    >;
typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  required String name,
  required String role,
  required String pinHash,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> role,
  Value<String> pinHash,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get pinHash =>
      $composableBuilder(column: $table.pinHash, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> pinHash = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                role: role,
                pinHash: pinHash,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String role,
                required String pinHash,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                role: role,
                pinHash: pinHash,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, User>(table),
                  BaseReferences<_$AppDatabase, $UsersTable, User>(
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

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StoreConfigsTableTableManager get storeConfigs =>
      $$StoreConfigsTableTableManager(_db, _db.storeConfigs);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}
