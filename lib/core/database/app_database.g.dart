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
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
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
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordSaltMeta = const VerificationMeta(
    'passwordSalt',
  );
  @override
  late final GeneratedColumn<String> passwordSalt = GeneratedColumn<String>(
    'password_salt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passwordIterationsMeta =
      const VerificationMeta('passwordIterations');
  @override
  late final GeneratedColumn<int> passwordIterations = GeneratedColumn<int>(
    'password_iterations',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    username,
    fullName,
    role,
    passwordHash,
    passwordSalt,
    passwordIterations,
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
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('password_salt')) {
      context.handle(
        _passwordSaltMeta,
        passwordSalt.isAcceptableOrUnknown(
          data['password_salt']!,
          _passwordSaltMeta,
        ),
      );
    }
    if (data.containsKey('password_iterations')) {
      context.handle(
        _passwordIterationsMeta,
        passwordIterations.isAcceptableOrUnknown(
          data['password_iterations']!,
          _passwordIterationsMeta,
        ),
      );
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
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      passwordSalt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_salt'],
      ),
      passwordIterations: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}password_iterations'],
      ),
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

  /// Unique login username.
  final String username;

  /// Display name for receipts and e-invoices (e.g. "Abebe Bikila").
  final String fullName;

  /// Role: 'MANAGER' or 'CASHIER'.
  final String role;

  /// Derived password hash. For v6+ rows this is a PBKDF2-HMAC-SHA256 key
  /// (hex). For legacy rows created before v6 this is an unsalted SHA-256
  /// digest and [passwordSalt]/[passwordIterations] are null; those rows
  /// are transparently re-hashed on the next successful login.
  final String passwordHash;

  /// Hex-encoded per-user salt used by PBKDF2. Null for legacy rows.
  final String? passwordSalt;

  /// PBKDF2 iteration count used to derive [passwordHash]. Null for legacy
  /// rows; persisted so the cost can be raised in future migrations without
  /// invalidating existing credentials.
  final int? passwordIterations;

  /// Whether this user account is active.
  final bool isActive;

  /// When this user was created.
  final DateTime createdAt;

  /// When this user was last updated (e.g. password change, deactivation).
  final DateTime? updatedAt;
  const User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.role,
    required this.passwordHash,
    this.passwordSalt,
    this.passwordIterations,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['username'] = Variable<String>(username);
    map['full_name'] = Variable<String>(fullName);
    map['role'] = Variable<String>(role);
    map['password_hash'] = Variable<String>(passwordHash);
    if (!nullToAbsent || passwordSalt != null) {
      map['password_salt'] = Variable<String>(passwordSalt);
    }
    if (!nullToAbsent || passwordIterations != null) {
      map['password_iterations'] = Variable<int>(passwordIterations);
    }
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
      username: Value(username),
      fullName: Value(fullName),
      role: Value(role),
      passwordHash: Value(passwordHash),
      passwordSalt: passwordSalt == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordSalt),
      passwordIterations: passwordIterations == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordIterations),
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
      username: serializer.fromJson<String>(json['username']),
      fullName: serializer.fromJson<String>(json['fullName']),
      role: serializer.fromJson<String>(json['role']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      passwordSalt: serializer.fromJson<String?>(json['passwordSalt']),
      passwordIterations: serializer.fromJson<int?>(json['passwordIterations']),
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
      'username': serializer.toJson<String>(username),
      'fullName': serializer.toJson<String>(fullName),
      'role': serializer.toJson<String>(role),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'passwordSalt': serializer.toJson<String?>(passwordSalt),
      'passwordIterations': serializer.toJson<int?>(passwordIterations),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  User copyWith({
    String? id,
    String? username,
    String? fullName,
    String? role,
    String? passwordHash,
    Value<String?> passwordSalt = const Value.absent(),
    Value<int?> passwordIterations = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    fullName: fullName ?? this.fullName,
    role: role ?? this.role,
    passwordHash: passwordHash ?? this.passwordHash,
    passwordSalt: passwordSalt.present ? passwordSalt.value : this.passwordSalt,
    passwordIterations: passwordIterations.present
        ? passwordIterations.value
        : this.passwordIterations,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      role: data.role.present ? data.role.value : this.role,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      passwordSalt: data.passwordSalt.present
          ? data.passwordSalt.value
          : this.passwordSalt,
      passwordIterations: data.passwordIterations.present
          ? data.passwordIterations.value
          : this.passwordIterations,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('fullName: $fullName, ')
          ..write('role: $role, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('passwordIterations: $passwordIterations, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    username,
    fullName,
    role,
    passwordHash,
    passwordSalt,
    passwordIterations,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.fullName == this.fullName &&
          other.role == this.role &&
          other.passwordHash == this.passwordHash &&
          other.passwordSalt == this.passwordSalt &&
          other.passwordIterations == this.passwordIterations &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> username;
  final Value<String> fullName;
  final Value<String> role;
  final Value<String> passwordHash;
  final Value<String?> passwordSalt;
  final Value<int?> passwordIterations;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.fullName = const Value.absent(),
    this.role = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.passwordSalt = const Value.absent(),
    this.passwordIterations = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String username,
    required String fullName,
    required String role,
    required String passwordHash,
    this.passwordSalt = const Value.absent(),
    this.passwordIterations = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       username = Value(username),
       fullName = Value(fullName),
       role = Value(role),
       passwordHash = Value(passwordHash);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? username,
    Expression<String>? fullName,
    Expression<String>? role,
    Expression<String>? passwordHash,
    Expression<String>? passwordSalt,
    Expression<int>? passwordIterations,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (fullName != null) 'full_name': fullName,
      if (role != null) 'role': role,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (passwordSalt != null) 'password_salt': passwordSalt,
      if (passwordIterations != null) 'password_iterations': passwordIterations,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? username,
    Value<String>? fullName,
    Value<String>? role,
    Value<String>? passwordHash,
    Value<String?>? passwordSalt,
    Value<int?>? passwordIterations,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordSalt: passwordSalt ?? this.passwordSalt,
      passwordIterations: passwordIterations ?? this.passwordIterations,
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
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (passwordSalt.present) {
      map['password_salt'] = Variable<String>(passwordSalt.value);
    }
    if (passwordIterations.present) {
      map['password_iterations'] = Variable<int>(passwordIterations.value);
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
          ..write('username: $username, ')
          ..write('fullName: $fullName, ')
          ..write('role: $role, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('passwordIterations: $passwordIterations, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    description,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
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
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
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
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
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
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  /// UUID primary key.
  final String id;

  /// Display name (e.g. "Beverages").
  final String name;

  /// Optional longer description for the category.
  final String? description;

  /// Whether the category is currently offered.
  final bool isActive;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime? updatedAt;
  const Category({
    required this.id,
    required this.name,
    this.description,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
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
      'description': serializer.toJson<String?>(description),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Category copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
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
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
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
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stockQuantityMeta = const VerificationMeta(
    'stockQuantity',
  );
  @override
  late final GeneratedColumn<double> stockQuantity = GeneratedColumn<double>(
    'stock_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vatRateMeta = const VerificationMeta(
    'vatRate',
  );
  @override
  late final GeneratedColumn<double> vatRate = GeneratedColumn<double>(
    'vat_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.15),
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
    categoryId,
    name,
    description,
    barcode,
    price,
    cost,
    stockQuantity,
    unit,
    vatRate,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    } else if (isInserting) {
      context.missing(_barcodeMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('stock_quantity')) {
      context.handle(
        _stockQuantityMeta,
        stockQuantity.isAcceptableOrUnknown(
          data['stock_quantity']!,
          _stockQuantityMeta,
        ),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('vat_rate')) {
      context.handle(
        _vatRateMeta,
        vatRate.isAcceptableOrUnknown(data['vat_rate']!, _vatRateMeta),
      );
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
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      ),
      stockQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_quantity'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      vatRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vat_rate'],
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
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  /// UUID primary key.
  final String id;

  /// Foreign key to [Categories].
  final String categoryId;

  /// Display name (e.g. "Ethiopian Coffee").
  final String name;

  /// Optional description.
  final String? description;

  /// Unique barcode / SKU used at checkout.
  final String barcode;

  /// Selling price per unit.
  final double price;

  /// Optional cost price for margin reporting.
  final double? cost;

  /// Current stock quantity (supports fractional units such as kg).
  final double stockQuantity;

  /// Unit of measure (e.g. "pc", "kg", "bottle").
  final String unit;

  /// VAT rate applied to this product (0.0 if exempt).
  final double vatRate;

  /// Whether the product is currently available for sale.
  final bool isActive;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last update timestamp.
  final DateTime? updatedAt;
  const Product({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    required this.barcode,
    required this.price,
    this.cost,
    required this.stockQuantity,
    required this.unit,
    required this.vatRate,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['barcode'] = Variable<String>(barcode);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<double>(cost);
    }
    map['stock_quantity'] = Variable<double>(stockQuantity);
    map['unit'] = Variable<String>(unit);
    map['vat_rate'] = Variable<double>(vatRate);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      barcode: Value(barcode),
      price: Value(price),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      stockQuantity: Value(stockQuantity),
      unit: Value(unit),
      vatRate: Value(vatRate),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      barcode: serializer.fromJson<String>(json['barcode']),
      price: serializer.fromJson<double>(json['price']),
      cost: serializer.fromJson<double?>(json['cost']),
      stockQuantity: serializer.fromJson<double>(json['stockQuantity']),
      unit: serializer.fromJson<String>(json['unit']),
      vatRate: serializer.fromJson<double>(json['vatRate']),
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
      'categoryId': serializer.toJson<String>(categoryId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'barcode': serializer.toJson<String>(barcode),
      'price': serializer.toJson<double>(price),
      'cost': serializer.toJson<double?>(cost),
      'stockQuantity': serializer.toJson<double>(stockQuantity),
      'unit': serializer.toJson<String>(unit),
      'vatRate': serializer.toJson<double>(vatRate),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Product copyWith({
    String? id,
    String? categoryId,
    String? name,
    Value<String?> description = const Value.absent(),
    String? barcode,
    double? price,
    Value<double?> cost = const Value.absent(),
    double? stockQuantity,
    String? unit,
    double? vatRate,
    bool? isActive,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Product(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    barcode: barcode ?? this.barcode,
    price: price ?? this.price,
    cost: cost.present ? cost.value : this.cost,
    stockQuantity: stockQuantity ?? this.stockQuantity,
    unit: unit ?? this.unit,
    vatRate: vatRate ?? this.vatRate,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      price: data.price.present ? data.price.value : this.price,
      cost: data.cost.present ? data.cost.value : this.cost,
      stockQuantity: data.stockQuantity.present
          ? data.stockQuantity.value
          : this.stockQuantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      vatRate: data.vatRate.present ? data.vatRate.value : this.vatRate,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('barcode: $barcode, ')
          ..write('price: $price, ')
          ..write('cost: $cost, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('unit: $unit, ')
          ..write('vatRate: $vatRate, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    name,
    description,
    barcode,
    price,
    cost,
    stockQuantity,
    unit,
    vatRate,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.description == this.description &&
          other.barcode == this.barcode &&
          other.price == this.price &&
          other.cost == this.cost &&
          other.stockQuantity == this.stockQuantity &&
          other.unit == this.unit &&
          other.vatRate == this.vatRate &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String> categoryId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> barcode;
  final Value<double> price;
  final Value<double?> cost;
  final Value<double> stockQuantity;
  final Value<String> unit;
  final Value<double> vatRate;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.barcode = const Value.absent(),
    this.price = const Value.absent(),
    this.cost = const Value.absent(),
    this.stockQuantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.vatRate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    required String categoryId,
    required String name,
    this.description = const Value.absent(),
    required String barcode,
    required double price,
    this.cost = const Value.absent(),
    this.stockQuantity = const Value.absent(),
    required String unit,
    this.vatRate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       categoryId = Value(categoryId),
       name = Value(name),
       barcode = Value(barcode),
       price = Value(price),
       unit = Value(unit);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? barcode,
    Expression<double>? price,
    Expression<double>? cost,
    Expression<double>? stockQuantity,
    Expression<String>? unit,
    Expression<double>? vatRate,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (barcode != null) 'barcode': barcode,
      if (price != null) 'price': price,
      if (cost != null) 'cost': cost,
      if (stockQuantity != null) 'stock_quantity': stockQuantity,
      if (unit != null) 'unit': unit,
      if (vatRate != null) 'vat_rate': vatRate,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<String>? categoryId,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? barcode,
    Value<double>? price,
    Value<double?>? cost,
    Value<double>? stockQuantity,
    Value<String>? unit,
    Value<double>? vatRate,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      barcode: barcode ?? this.barcode,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      unit: unit ?? this.unit,
      vatRate: vatRate ?? this.vatRate,
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
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (stockQuantity.present) {
      map['stock_quantity'] = Variable<double>(stockQuantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (vatRate.present) {
      map['vat_rate'] = Variable<double>(vatRate.value);
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
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('barcode: $barcode, ')
          ..write('price: $price, ')
          ..write('cost: $cost, ')
          ..write('stockQuantity: $stockQuantity, ')
          ..write('unit: $unit, ')
          ..write('vatRate: $vatRate, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _invoiceNumberMeta = const VerificationMeta(
    'invoiceNumber',
  );
  @override
  late final GeneratedColumn<int> invoiceNumber = GeneratedColumn<int>(
    'invoice_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _cashierIdMeta = const VerificationMeta(
    'cashierId',
  );
  @override
  late final GeneratedColumn<String> cashierId = GeneratedColumn<String>(
    'cashier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _buyerTinMeta = const VerificationMeta(
    'buyerTin',
  );
  @override
  late final GeneratedColumn<String> buyerTin = GeneratedColumn<String>(
    'buyer_tin',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 10,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _netTotalMeta = const VerificationMeta(
    'netTotal',
  );
  @override
  late final GeneratedColumn<double> netTotal = GeneratedColumn<double>(
    'net_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vatTotalMeta = const VerificationMeta(
    'vatTotal',
  );
  @override
  late final GeneratedColumn<double> vatTotal = GeneratedColumn<double>(
    'vat_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grossTotalMeta = const VerificationMeta(
    'grossTotal',
  );
  @override
  late final GeneratedColumn<double> grossTotal = GeneratedColumn<double>(
    'gross_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PENDING_SYNC'),
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousHashMeta = const VerificationMeta(
    'previousHash',
  );
  @override
  late final GeneratedColumn<String> previousHash = GeneratedColumn<String>(
    'previous_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentHashMeta = const VerificationMeta(
    'currentHash',
  );
  @override
  late final GeneratedColumn<String> currentHash = GeneratedColumn<String>(
    'current_hash',
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
    invoiceNumber,
    cashierId,
    buyerTin,
    netTotal,
    vatTotal,
    grossTotal,
    status,
    payload,
    previousHash,
    currentHash,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(
          data['invoice_number']!,
          _invoiceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('cashier_id')) {
      context.handle(
        _cashierIdMeta,
        cashierId.isAcceptableOrUnknown(data['cashier_id']!, _cashierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cashierIdMeta);
    }
    if (data.containsKey('buyer_tin')) {
      context.handle(
        _buyerTinMeta,
        buyerTin.isAcceptableOrUnknown(data['buyer_tin']!, _buyerTinMeta),
      );
    }
    if (data.containsKey('net_total')) {
      context.handle(
        _netTotalMeta,
        netTotal.isAcceptableOrUnknown(data['net_total']!, _netTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_netTotalMeta);
    }
    if (data.containsKey('vat_total')) {
      context.handle(
        _vatTotalMeta,
        vatTotal.isAcceptableOrUnknown(data['vat_total']!, _vatTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_vatTotalMeta);
    }
    if (data.containsKey('gross_total')) {
      context.handle(
        _grossTotalMeta,
        grossTotal.isAcceptableOrUnknown(data['gross_total']!, _grossTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_grossTotalMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('previous_hash')) {
      context.handle(
        _previousHashMeta,
        previousHash.isAcceptableOrUnknown(
          data['previous_hash']!,
          _previousHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previousHashMeta);
    }
    if (data.containsKey('current_hash')) {
      context.handle(
        _currentHashMeta,
        currentHash.isAcceptableOrUnknown(
          data['current_hash']!,
          _currentHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentHashMeta);
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
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_number'],
      )!,
      cashierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cashier_id'],
      )!,
      buyerTin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}buyer_tin'],
      ),
      netTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}net_total'],
      )!,
      vatTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vat_total'],
      )!,
      grossTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gross_total'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      previousHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}previous_hash'],
      )!,
      currentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_hash'],
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
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  /// Auto-generated primary key used for local references.
  final int id;

  /// Device-local sequential invoice number (1, 2, 3…).
  final int invoiceNumber;

  /// Cashier / operator who performed the sale.
  final String cashierId;

  /// Optional buyer TIN (10 digits).
  final String? buyerTin;

  /// Tax-exclusive total.
  final double netTotal;

  /// Total VAT amount.
  final double vatTotal;

  /// Tax-inclusive grand total.
  final double grossTotal;

  /// Lifecycle status: PENDING_SYNC, SYNCED, CANCELLED.
  final String status;

  /// Deterministic JSON payload used for hash chain verification.
  final String payload;

  /// Hash of the previous audit entry (empty for the first invoice).
  final String previousHash;

  /// Hash of this invoice’s payload chained to the previous hash.
  final String currentHash;

  /// When the invoice was created.
  final DateTime createdAt;

  /// When the invoice was last updated.
  final DateTime? updatedAt;
  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.cashierId,
    this.buyerTin,
    required this.netTotal,
    required this.vatTotal,
    required this.grossTotal,
    required this.status,
    required this.payload,
    required this.previousHash,
    required this.currentHash,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_number'] = Variable<int>(invoiceNumber);
    map['cashier_id'] = Variable<String>(cashierId);
    if (!nullToAbsent || buyerTin != null) {
      map['buyer_tin'] = Variable<String>(buyerTin);
    }
    map['net_total'] = Variable<double>(netTotal);
    map['vat_total'] = Variable<double>(vatTotal);
    map['gross_total'] = Variable<double>(grossTotal);
    map['status'] = Variable<String>(status);
    map['payload'] = Variable<String>(payload);
    map['previous_hash'] = Variable<String>(previousHash);
    map['current_hash'] = Variable<String>(currentHash);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      invoiceNumber: Value(invoiceNumber),
      cashierId: Value(cashierId),
      buyerTin: buyerTin == null && nullToAbsent
          ? const Value.absent()
          : Value(buyerTin),
      netTotal: Value(netTotal),
      vatTotal: Value(vatTotal),
      grossTotal: Value(grossTotal),
      status: Value(status),
      payload: Value(payload),
      previousHash: Value(previousHash),
      currentHash: Value(currentHash),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      invoiceNumber: serializer.fromJson<int>(json['invoiceNumber']),
      cashierId: serializer.fromJson<String>(json['cashierId']),
      buyerTin: serializer.fromJson<String?>(json['buyerTin']),
      netTotal: serializer.fromJson<double>(json['netTotal']),
      vatTotal: serializer.fromJson<double>(json['vatTotal']),
      grossTotal: serializer.fromJson<double>(json['grossTotal']),
      status: serializer.fromJson<String>(json['status']),
      payload: serializer.fromJson<String>(json['payload']),
      previousHash: serializer.fromJson<String>(json['previousHash']),
      currentHash: serializer.fromJson<String>(json['currentHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceNumber': serializer.toJson<int>(invoiceNumber),
      'cashierId': serializer.toJson<String>(cashierId),
      'buyerTin': serializer.toJson<String?>(buyerTin),
      'netTotal': serializer.toJson<double>(netTotal),
      'vatTotal': serializer.toJson<double>(vatTotal),
      'grossTotal': serializer.toJson<double>(grossTotal),
      'status': serializer.toJson<String>(status),
      'payload': serializer.toJson<String>(payload),
      'previousHash': serializer.toJson<String>(previousHash),
      'currentHash': serializer.toJson<String>(currentHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Invoice copyWith({
    int? id,
    int? invoiceNumber,
    String? cashierId,
    Value<String?> buyerTin = const Value.absent(),
    double? netTotal,
    double? vatTotal,
    double? grossTotal,
    String? status,
    String? payload,
    String? previousHash,
    String? currentHash,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Invoice(
    id: id ?? this.id,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    cashierId: cashierId ?? this.cashierId,
    buyerTin: buyerTin.present ? buyerTin.value : this.buyerTin,
    netTotal: netTotal ?? this.netTotal,
    vatTotal: vatTotal ?? this.vatTotal,
    grossTotal: grossTotal ?? this.grossTotal,
    status: status ?? this.status,
    payload: payload ?? this.payload,
    previousHash: previousHash ?? this.previousHash,
    currentHash: currentHash ?? this.currentHash,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      cashierId: data.cashierId.present ? data.cashierId.value : this.cashierId,
      buyerTin: data.buyerTin.present ? data.buyerTin.value : this.buyerTin,
      netTotal: data.netTotal.present ? data.netTotal.value : this.netTotal,
      vatTotal: data.vatTotal.present ? data.vatTotal.value : this.vatTotal,
      grossTotal: data.grossTotal.present
          ? data.grossTotal.value
          : this.grossTotal,
      status: data.status.present ? data.status.value : this.status,
      payload: data.payload.present ? data.payload.value : this.payload,
      previousHash: data.previousHash.present
          ? data.previousHash.value
          : this.previousHash,
      currentHash: data.currentHash.present
          ? data.currentHash.value
          : this.currentHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('cashierId: $cashierId, ')
          ..write('buyerTin: $buyerTin, ')
          ..write('netTotal: $netTotal, ')
          ..write('vatTotal: $vatTotal, ')
          ..write('grossTotal: $grossTotal, ')
          ..write('status: $status, ')
          ..write('payload: $payload, ')
          ..write('previousHash: $previousHash, ')
          ..write('currentHash: $currentHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceNumber,
    cashierId,
    buyerTin,
    netTotal,
    vatTotal,
    grossTotal,
    status,
    payload,
    previousHash,
    currentHash,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.invoiceNumber == this.invoiceNumber &&
          other.cashierId == this.cashierId &&
          other.buyerTin == this.buyerTin &&
          other.netTotal == this.netTotal &&
          other.vatTotal == this.vatTotal &&
          other.grossTotal == this.grossTotal &&
          other.status == this.status &&
          other.payload == this.payload &&
          other.previousHash == this.previousHash &&
          other.currentHash == this.currentHash &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<int> invoiceNumber;
  final Value<String> cashierId;
  final Value<String?> buyerTin;
  final Value<double> netTotal;
  final Value<double> vatTotal;
  final Value<double> grossTotal;
  final Value<String> status;
  final Value<String> payload;
  final Value<String> previousHash;
  final Value<String> currentHash;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.cashierId = const Value.absent(),
    this.buyerTin = const Value.absent(),
    this.netTotal = const Value.absent(),
    this.vatTotal = const Value.absent(),
    this.grossTotal = const Value.absent(),
    this.status = const Value.absent(),
    this.payload = const Value.absent(),
    this.previousHash = const Value.absent(),
    this.currentHash = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceNumber,
    required String cashierId,
    this.buyerTin = const Value.absent(),
    required double netTotal,
    required double vatTotal,
    required double grossTotal,
    this.status = const Value.absent(),
    required String payload,
    required String previousHash,
    required String currentHash,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : invoiceNumber = Value(invoiceNumber),
       cashierId = Value(cashierId),
       netTotal = Value(netTotal),
       vatTotal = Value(vatTotal),
       grossTotal = Value(grossTotal),
       payload = Value(payload),
       previousHash = Value(previousHash),
       currentHash = Value(currentHash);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<int>? invoiceNumber,
    Expression<String>? cashierId,
    Expression<String>? buyerTin,
    Expression<double>? netTotal,
    Expression<double>? vatTotal,
    Expression<double>? grossTotal,
    Expression<String>? status,
    Expression<String>? payload,
    Expression<String>? previousHash,
    Expression<String>? currentHash,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (cashierId != null) 'cashier_id': cashierId,
      if (buyerTin != null) 'buyer_tin': buyerTin,
      if (netTotal != null) 'net_total': netTotal,
      if (vatTotal != null) 'vat_total': vatTotal,
      if (grossTotal != null) 'gross_total': grossTotal,
      if (status != null) 'status': status,
      if (payload != null) 'payload': payload,
      if (previousHash != null) 'previous_hash': previousHash,
      if (currentHash != null) 'current_hash': currentHash,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  InvoicesCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceNumber,
    Value<String>? cashierId,
    Value<String?>? buyerTin,
    Value<double>? netTotal,
    Value<double>? vatTotal,
    Value<double>? grossTotal,
    Value<String>? status,
    Value<String>? payload,
    Value<String>? previousHash,
    Value<String>? currentHash,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      cashierId: cashierId ?? this.cashierId,
      buyerTin: buyerTin ?? this.buyerTin,
      netTotal: netTotal ?? this.netTotal,
      vatTotal: vatTotal ?? this.vatTotal,
      grossTotal: grossTotal ?? this.grossTotal,
      status: status ?? this.status,
      payload: payload ?? this.payload,
      previousHash: previousHash ?? this.previousHash,
      currentHash: currentHash ?? this.currentHash,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<int>(invoiceNumber.value);
    }
    if (cashierId.present) {
      map['cashier_id'] = Variable<String>(cashierId.value);
    }
    if (buyerTin.present) {
      map['buyer_tin'] = Variable<String>(buyerTin.value);
    }
    if (netTotal.present) {
      map['net_total'] = Variable<double>(netTotal.value);
    }
    if (vatTotal.present) {
      map['vat_total'] = Variable<double>(vatTotal.value);
    }
    if (grossTotal.present) {
      map['gross_total'] = Variable<double>(grossTotal.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (previousHash.present) {
      map['previous_hash'] = Variable<String>(previousHash.value);
    }
    if (currentHash.present) {
      map['current_hash'] = Variable<String>(currentHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('cashierId: $cashierId, ')
          ..write('buyerTin: $buyerTin, ')
          ..write('netTotal: $netTotal, ')
          ..write('vatTotal: $vatTotal, ')
          ..write('grossTotal: $grossTotal, ')
          ..write('status: $status, ')
          ..write('payload: $payload, ')
          ..write('previousHash: $previousHash, ')
          ..write('currentHash: $currentHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $InvoiceItemsTable extends InvoiceItems
    with TableInfo<$InvoiceItemsTable, InvoiceItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _vatRateMeta = const VerificationMeta(
    'vatRate',
  );
  @override
  late final GeneratedColumn<double> vatRate = GeneratedColumn<double>(
    'vat_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.15),
  );
  static const VerificationMeta _netAmountMeta = const VerificationMeta(
    'netAmount',
  );
  @override
  late final GeneratedColumn<double> netAmount = GeneratedColumn<double>(
    'net_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vatAmountMeta = const VerificationMeta(
    'vatAmount',
  );
  @override
  late final GeneratedColumn<double> vatAmount = GeneratedColumn<double>(
    'vat_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grossAmountMeta = const VerificationMeta(
    'grossAmount',
  );
  @override
  late final GeneratedColumn<double> grossAmount = GeneratedColumn<double>(
    'gross_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    productId,
    productName,
    unitPrice,
    quantity,
    vatRate,
    netAmount,
    vatAmount,
    grossAmount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('vat_rate')) {
      context.handle(
        _vatRateMeta,
        vatRate.isAcceptableOrUnknown(data['vat_rate']!, _vatRateMeta),
      );
    }
    if (data.containsKey('net_amount')) {
      context.handle(
        _netAmountMeta,
        netAmount.isAcceptableOrUnknown(data['net_amount']!, _netAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_netAmountMeta);
    }
    if (data.containsKey('vat_amount')) {
      context.handle(
        _vatAmountMeta,
        vatAmount.isAcceptableOrUnknown(data['vat_amount']!, _vatAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_vatAmountMeta);
    }
    if (data.containsKey('gross_amount')) {
      context.handle(
        _grossAmountMeta,
        grossAmount.isAcceptableOrUnknown(
          data['gross_amount']!,
          _grossAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_grossAmountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      vatRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vat_rate'],
      )!,
      netAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}net_amount'],
      )!,
      vatAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vat_amount'],
      )!,
      grossAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gross_amount'],
      )!,
    );
  }

  @override
  $InvoiceItemsTable createAlias(String alias) {
    return $InvoiceItemsTable(attachedDatabase, alias);
  }
}

class InvoiceItem extends DataClass implements Insertable<InvoiceItem> {
  /// Auto-generated local primary key.
  final int id;

  /// Parent invoice.
  final int invoiceId;

  /// Product identifier (catalog reference is informational here; catalog
  /// rows can be deactivated or removed without breaking historical data).
  final String productId;

  /// Display name of the product at the time of sale.
  final String productName;

  /// Tax-inclusive unit price.
  final double unitPrice;

  /// Quantity sold (integer units for this app).
  final int quantity;

  /// VAT rate applied to this line (e.g. 0.15).
  final double vatRate;

  /// Tax-exclusive line total.
  final double netAmount;

  /// VAT amount for this line.
  final double vatAmount;

  /// Tax-inclusive line total.
  final double grossAmount;
  const InvoiceItem({
    required this.id,
    required this.invoiceId,
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.vatRate,
    required this.netAmount,
    required this.vatAmount,
    required this.grossAmount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['product_id'] = Variable<String>(productId);
    map['product_name'] = Variable<String>(productName);
    map['unit_price'] = Variable<double>(unitPrice);
    map['quantity'] = Variable<int>(quantity);
    map['vat_rate'] = Variable<double>(vatRate);
    map['net_amount'] = Variable<double>(netAmount);
    map['vat_amount'] = Variable<double>(vatAmount);
    map['gross_amount'] = Variable<double>(grossAmount);
    return map;
  }

  InvoiceItemsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceItemsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      productId: Value(productId),
      productName: Value(productName),
      unitPrice: Value(unitPrice),
      quantity: Value(quantity),
      vatRate: Value(vatRate),
      netAmount: Value(netAmount),
      vatAmount: Value(vatAmount),
      grossAmount: Value(grossAmount),
    );
  }

  factory InvoiceItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceItem(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      productId: serializer.fromJson<String>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      quantity: serializer.fromJson<int>(json['quantity']),
      vatRate: serializer.fromJson<double>(json['vatRate']),
      netAmount: serializer.fromJson<double>(json['netAmount']),
      vatAmount: serializer.fromJson<double>(json['vatAmount']),
      grossAmount: serializer.fromJson<double>(json['grossAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'productId': serializer.toJson<String>(productId),
      'productName': serializer.toJson<String>(productName),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'quantity': serializer.toJson<int>(quantity),
      'vatRate': serializer.toJson<double>(vatRate),
      'netAmount': serializer.toJson<double>(netAmount),
      'vatAmount': serializer.toJson<double>(vatAmount),
      'grossAmount': serializer.toJson<double>(grossAmount),
    };
  }

  InvoiceItem copyWith({
    int? id,
    int? invoiceId,
    String? productId,
    String? productName,
    double? unitPrice,
    int? quantity,
    double? vatRate,
    double? netAmount,
    double? vatAmount,
    double? grossAmount,
  }) => InvoiceItem(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    unitPrice: unitPrice ?? this.unitPrice,
    quantity: quantity ?? this.quantity,
    vatRate: vatRate ?? this.vatRate,
    netAmount: netAmount ?? this.netAmount,
    vatAmount: vatAmount ?? this.vatAmount,
    grossAmount: grossAmount ?? this.grossAmount,
  );
  InvoiceItem copyWithCompanion(InvoiceItemsCompanion data) {
    return InvoiceItem(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      vatRate: data.vatRate.present ? data.vatRate.value : this.vatRate,
      netAmount: data.netAmount.present ? data.netAmount.value : this.netAmount,
      vatAmount: data.vatAmount.present ? data.vatAmount.value : this.vatAmount,
      grossAmount: data.grossAmount.present
          ? data.grossAmount.value
          : this.grossAmount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItem(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('quantity: $quantity, ')
          ..write('vatRate: $vatRate, ')
          ..write('netAmount: $netAmount, ')
          ..write('vatAmount: $vatAmount, ')
          ..write('grossAmount: $grossAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    productId,
    productName,
    unitPrice,
    quantity,
    vatRate,
    netAmount,
    vatAmount,
    grossAmount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceItem &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.unitPrice == this.unitPrice &&
          other.quantity == this.quantity &&
          other.vatRate == this.vatRate &&
          other.netAmount == this.netAmount &&
          other.vatAmount == this.vatAmount &&
          other.grossAmount == this.grossAmount);
}

class InvoiceItemsCompanion extends UpdateCompanion<InvoiceItem> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<String> productId;
  final Value<String> productName;
  final Value<double> unitPrice;
  final Value<int> quantity;
  final Value<double> vatRate;
  final Value<double> netAmount;
  final Value<double> vatAmount;
  final Value<double> grossAmount;
  const InvoiceItemsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.vatRate = const Value.absent(),
    this.netAmount = const Value.absent(),
    this.vatAmount = const Value.absent(),
    this.grossAmount = const Value.absent(),
  });
  InvoiceItemsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required String productId,
    required String productName,
    required double unitPrice,
    this.quantity = const Value.absent(),
    this.vatRate = const Value.absent(),
    required double netAmount,
    required double vatAmount,
    required double grossAmount,
  }) : invoiceId = Value(invoiceId),
       productId = Value(productId),
       productName = Value(productName),
       unitPrice = Value(unitPrice),
       netAmount = Value(netAmount),
       vatAmount = Value(vatAmount),
       grossAmount = Value(grossAmount);
  static Insertable<InvoiceItem> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<String>? productId,
    Expression<String>? productName,
    Expression<double>? unitPrice,
    Expression<int>? quantity,
    Expression<double>? vatRate,
    Expression<double>? netAmount,
    Expression<double>? vatAmount,
    Expression<double>? grossAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (quantity != null) 'quantity': quantity,
      if (vatRate != null) 'vat_rate': vatRate,
      if (netAmount != null) 'net_amount': netAmount,
      if (vatAmount != null) 'vat_amount': vatAmount,
      if (grossAmount != null) 'gross_amount': grossAmount,
    });
  }

  InvoiceItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<String>? productId,
    Value<String>? productName,
    Value<double>? unitPrice,
    Value<int>? quantity,
    Value<double>? vatRate,
    Value<double>? netAmount,
    Value<double>? vatAmount,
    Value<double>? grossAmount,
  }) {
    return InvoiceItemsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      vatRate: vatRate ?? this.vatRate,
      netAmount: netAmount ?? this.netAmount,
      vatAmount: vatAmount ?? this.vatAmount,
      grossAmount: grossAmount ?? this.grossAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (vatRate.present) {
      map['vat_rate'] = Variable<double>(vatRate.value);
    }
    if (netAmount.present) {
      map['net_amount'] = Variable<double>(netAmount.value);
    }
    if (vatAmount.present) {
      map['vat_amount'] = Variable<double>(vatAmount.value);
    }
    if (grossAmount.present) {
      map['gross_amount'] = Variable<double>(grossAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('quantity: $quantity, ')
          ..write('vatRate: $vatRate, ')
          ..write('netAmount: $netAmount, ')
          ..write('vatAmount: $vatAmount, ')
          ..write('grossAmount: $grossAmount')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cashTenderedMeta = const VerificationMeta(
    'cashTendered',
  );
  @override
  late final GeneratedColumn<double> cashTendered = GeneratedColumn<double>(
    'cash_tendered',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceCodeMeta = const VerificationMeta(
    'referenceCode',
  );
  @override
  late final GeneratedColumn<String> referenceCode = GeneratedColumn<String>(
    'reference_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    invoiceId,
    method,
    amount,
    cashTendered,
    referenceCode,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Payment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('cash_tendered')) {
      context.handle(
        _cashTenderedMeta,
        cashTendered.isAcceptableOrUnknown(
          data['cash_tendered']!,
          _cashTenderedMeta,
        ),
      );
    }
    if (data.containsKey('reference_code')) {
      context.handle(
        _referenceCodeMeta,
        referenceCode.isAcceptableOrUnknown(
          data['reference_code']!,
          _referenceCodeMeta,
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
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      cashTendered: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cash_tendered'],
      ),
      referenceCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_code'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  /// Auto-generated local primary key.
  final int id;

  /// Parent invoice.
  final int invoiceId;

  /// Payment method: cash, telebirr, cbeBirr.
  final String method;

  /// Paid amount (must equal invoice gross total at creation).
  final double amount;

  /// Cash tendered by the buyer. Null for electronic methods.
  final double? cashTendered;

  /// Optional provider reference / transaction code for electronic payments.
  final String? referenceCode;

  /// When the payment was recorded.
  final DateTime createdAt;
  const Payment({
    required this.id,
    required this.invoiceId,
    required this.method,
    required this.amount,
    this.cashTendered,
    this.referenceCode,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['method'] = Variable<String>(method);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || cashTendered != null) {
      map['cash_tendered'] = Variable<double>(cashTendered);
    }
    if (!nullToAbsent || referenceCode != null) {
      map['reference_code'] = Variable<String>(referenceCode);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      method: Value(method),
      amount: Value(amount),
      cashTendered: cashTendered == null && nullToAbsent
          ? const Value.absent()
          : Value(cashTendered),
      referenceCode: referenceCode == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceCode),
      createdAt: Value(createdAt),
    );
  }

  factory Payment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      method: serializer.fromJson<String>(json['method']),
      amount: serializer.fromJson<double>(json['amount']),
      cashTendered: serializer.fromJson<double?>(json['cashTendered']),
      referenceCode: serializer.fromJson<String?>(json['referenceCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'method': serializer.toJson<String>(method),
      'amount': serializer.toJson<double>(amount),
      'cashTendered': serializer.toJson<double?>(cashTendered),
      'referenceCode': serializer.toJson<String?>(referenceCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Payment copyWith({
    int? id,
    int? invoiceId,
    String? method,
    double? amount,
    Value<double?> cashTendered = const Value.absent(),
    Value<String?> referenceCode = const Value.absent(),
    DateTime? createdAt,
  }) => Payment(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    method: method ?? this.method,
    amount: amount ?? this.amount,
    cashTendered: cashTendered.present ? cashTendered.value : this.cashTendered,
    referenceCode: referenceCode.present
        ? referenceCode.value
        : this.referenceCode,
    createdAt: createdAt ?? this.createdAt,
  );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      method: data.method.present ? data.method.value : this.method,
      amount: data.amount.present ? data.amount.value : this.amount,
      cashTendered: data.cashTendered.present
          ? data.cashTendered.value
          : this.cashTendered,
      referenceCode: data.referenceCode.present
          ? data.referenceCode.value
          : this.referenceCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('method: $method, ')
          ..write('amount: $amount, ')
          ..write('cashTendered: $cashTendered, ')
          ..write('referenceCode: $referenceCode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    method,
    amount,
    cashTendered,
    referenceCode,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.method == this.method &&
          other.amount == this.amount &&
          other.cashTendered == this.cashTendered &&
          other.referenceCode == this.referenceCode &&
          other.createdAt == this.createdAt);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<String> method;
  final Value<double> amount;
  final Value<double?> cashTendered;
  final Value<String?> referenceCode;
  final Value<DateTime> createdAt;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.method = const Value.absent(),
    this.amount = const Value.absent(),
    this.cashTendered = const Value.absent(),
    this.referenceCode = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required String method,
    required double amount,
    this.cashTendered = const Value.absent(),
    this.referenceCode = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       method = Value(method),
       amount = Value(amount);
  static Insertable<Payment> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<String>? method,
    Expression<double>? amount,
    Expression<double>? cashTendered,
    Expression<String>? referenceCode,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (method != null) 'method': method,
      if (amount != null) 'amount': amount,
      if (cashTendered != null) 'cash_tendered': cashTendered,
      if (referenceCode != null) 'reference_code': referenceCode,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<String>? method,
    Value<double>? amount,
    Value<double?>? cashTendered,
    Value<String?>? referenceCode,
    Value<DateTime>? createdAt,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      method: method ?? this.method,
      amount: amount ?? this.amount,
      cashTendered: cashTendered ?? this.cashTendered,
      referenceCode: referenceCode ?? this.referenceCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (cashTendered.present) {
      map['cash_tendered'] = Variable<double>(cashTendered.value);
    }
    if (referenceCode.present) {
      map['reference_code'] = Variable<String>(referenceCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('method: $method, ')
          ..write('amount: $amount, ')
          ..write('cashTendered: $cashTendered, ')
          ..write('referenceCode: $referenceCode, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 40,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PENDING'),
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    operation,
    status,
    payload,
    retryCount,
    lastError,
    createdAt,
    updatedAt,
    lastAttemptAt,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
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
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  /// Auto-generated local primary key.
  final int id;

  /// Linked invoice (anchor for invoice-related sync operations).
  final int invoiceId;

  /// Operation type, e.g. CREATE_INVOICE, CREATE_CREDIT_NOTE,
  /// CANCEL_INVOICE, CLOSE_Z_REPORT.
  final String operation;

  /// Job status: PENDING, PROCESSING, FAILED, SYNCED.
  final String status;

  /// JSON payload sent to the backend.
  final String payload;

  /// Retry counter for failed jobs.
  final int retryCount;

  /// Last error message for failed jobs.
  final String? lastError;

  /// When the job was created.
  final DateTime createdAt;

  /// When the job row was last updated.
  final DateTime updatedAt;

  /// When the job last transitioned to PROCESSING.
  final DateTime? lastAttemptAt;

  /// When the job was successfully synced.
  final DateTime? syncedAt;
  const SyncQueueData({
    required this.id,
    required this.invoiceId,
    required this.operation,
    required this.status,
    required this.payload,
    required this.retryCount,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
    this.lastAttemptAt,
    this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['operation'] = Variable<String>(operation);
    map['status'] = Variable<String>(status);
    map['payload'] = Variable<String>(payload);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      operation: Value(operation),
      status: Value(status),
      payload: Value(payload),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      operation: serializer.fromJson<String>(json['operation']),
      status: serializer.fromJson<String>(json['status']),
      payload: serializer.fromJson<String>(json['payload']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'operation': serializer.toJson<String>(operation),
      'status': serializer.toJson<String>(status),
      'payload': serializer.toJson<String>(payload),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  SyncQueueData copyWith({
    int? id,
    int? invoiceId,
    String? operation,
    String? status,
    String? payload,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    Value<DateTime?> syncedAt = const Value.absent(),
  }) => SyncQueueData(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    operation: operation ?? this.operation,
    status: status ?? this.status,
    payload: payload ?? this.payload,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      operation: data.operation.present ? data.operation.value : this.operation,
      status: data.status.present ? data.status.value : this.status,
      payload: data.payload.present ? data.payload.value : this.payload,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('operation: $operation, ')
          ..write('status: $status, ')
          ..write('payload: $payload, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    operation,
    status,
    payload,
    retryCount,
    lastError,
    createdAt,
    updatedAt,
    lastAttemptAt,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.operation == this.operation &&
          other.status == this.status &&
          other.payload == this.payload &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.syncedAt == this.syncedAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<String> operation;
  final Value<String> status;
  final Value<String> payload;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<DateTime?> syncedAt;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.operation = const Value.absent(),
    this.status = const Value.absent(),
    this.payload = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required String operation,
    this.status = const Value.absent(),
    required String payload,
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       operation = Value(operation),
       payload = Value(payload);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<String>? operation,
    Expression<String>? status,
    Expression<String>? payload,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (operation != null) 'operation': operation,
      if (status != null) 'status': status,
      if (payload != null) 'payload': payload,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<String>? operation,
    Value<String>? status,
    Value<String>? payload,
    Value<int>? retryCount,
    Value<String?>? lastError,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? lastAttemptAt,
    Value<DateTime?>? syncedAt,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      operation: operation ?? this.operation,
      status: status ?? this.status,
      payload: payload ?? this.payload,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('operation: $operation, ')
          ..write('status: $status, ')
          ..write('payload: $payload, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _previousHashMeta = const VerificationMeta(
    'previousHash',
  );
  @override
  late final GeneratedColumn<String> previousHash = GeneratedColumn<String>(
    'previous_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentHashMeta = const VerificationMeta(
    'currentHash',
  );
  @override
  late final GeneratedColumn<String> currentHash = GeneratedColumn<String>(
    'current_hash',
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
    action,
    invoiceId,
    userId,
    details,
    payload,
    previousHash,
    currentHash,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    } else if (isInserting) {
      context.missing(_detailsMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('previous_hash')) {
      context.handle(
        _previousHashMeta,
        previousHash.isAcceptableOrUnknown(
          data['previous_hash']!,
          _previousHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previousHashMeta);
    }
    if (data.containsKey('current_hash')) {
      context.handle(
        _currentHashMeta,
        currentHash.isAcceptableOrUnknown(
          data['current_hash']!,
          _currentHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentHashMeta);
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
  AuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      ),
      previousHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}previous_hash'],
      )!,
      currentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_hash'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLog extends DataClass implements Insertable<AuditLog> {
  /// Auto-generated local primary key.
  final int id;

  /// Action type, e.g. INVOICE_CREATED.
  final String action;

  /// Related invoice (nullable for non-invoice actions).
  final int? invoiceId;

  /// User who performed the action.
  final String userId;

  /// Human-readable details.
  final String details;

  /// Deterministic JSON payload that was used to compute [currentHash].
  /// Nullable to allow safe migration of pre-payload records; legacy rows
  /// with a missing payload are treated as unverifiable rather than valid.
  final String? payload;

  /// Hash of the previous audit entry (empty for the first entry).
  final String previousHash;

  /// Hash of this entry (equals the invoice currentHash for invoice creation).
  final String currentHash;

  /// When the action happened.
  final DateTime createdAt;
  const AuditLog({
    required this.id,
    required this.action,
    this.invoiceId,
    required this.userId,
    required this.details,
    this.payload,
    required this.previousHash,
    required this.currentHash,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['action'] = Variable<String>(action);
    if (!nullToAbsent || invoiceId != null) {
      map['invoice_id'] = Variable<int>(invoiceId);
    }
    map['user_id'] = Variable<String>(userId);
    map['details'] = Variable<String>(details);
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(payload);
    }
    map['previous_hash'] = Variable<String>(previousHash);
    map['current_hash'] = Variable<String>(currentHash);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      action: Value(action),
      invoiceId: invoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceId),
      userId: Value(userId),
      details: Value(details),
      payload: payload == null && nullToAbsent
          ? const Value.absent()
          : Value(payload),
      previousHash: Value(previousHash),
      currentHash: Value(currentHash),
      createdAt: Value(createdAt),
    );
  }

  factory AuditLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLog(
      id: serializer.fromJson<int>(json['id']),
      action: serializer.fromJson<String>(json['action']),
      invoiceId: serializer.fromJson<int?>(json['invoiceId']),
      userId: serializer.fromJson<String>(json['userId']),
      details: serializer.fromJson<String>(json['details']),
      payload: serializer.fromJson<String?>(json['payload']),
      previousHash: serializer.fromJson<String>(json['previousHash']),
      currentHash: serializer.fromJson<String>(json['currentHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'action': serializer.toJson<String>(action),
      'invoiceId': serializer.toJson<int?>(invoiceId),
      'userId': serializer.toJson<String>(userId),
      'details': serializer.toJson<String>(details),
      'payload': serializer.toJson<String?>(payload),
      'previousHash': serializer.toJson<String>(previousHash),
      'currentHash': serializer.toJson<String>(currentHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AuditLog copyWith({
    int? id,
    String? action,
    Value<int?> invoiceId = const Value.absent(),
    String? userId,
    String? details,
    Value<String?> payload = const Value.absent(),
    String? previousHash,
    String? currentHash,
    DateTime? createdAt,
  }) => AuditLog(
    id: id ?? this.id,
    action: action ?? this.action,
    invoiceId: invoiceId.present ? invoiceId.value : this.invoiceId,
    userId: userId ?? this.userId,
    details: details ?? this.details,
    payload: payload.present ? payload.value : this.payload,
    previousHash: previousHash ?? this.previousHash,
    currentHash: currentHash ?? this.currentHash,
    createdAt: createdAt ?? this.createdAt,
  );
  AuditLog copyWithCompanion(AuditLogsCompanion data) {
    return AuditLog(
      id: data.id.present ? data.id.value : this.id,
      action: data.action.present ? data.action.value : this.action,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      userId: data.userId.present ? data.userId.value : this.userId,
      details: data.details.present ? data.details.value : this.details,
      payload: data.payload.present ? data.payload.value : this.payload,
      previousHash: data.previousHash.present
          ? data.previousHash.value
          : this.previousHash,
      currentHash: data.currentHash.present
          ? data.currentHash.value
          : this.currentHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLog(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('userId: $userId, ')
          ..write('details: $details, ')
          ..write('payload: $payload, ')
          ..write('previousHash: $previousHash, ')
          ..write('currentHash: $currentHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    action,
    invoiceId,
    userId,
    details,
    payload,
    previousHash,
    currentHash,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLog &&
          other.id == this.id &&
          other.action == this.action &&
          other.invoiceId == this.invoiceId &&
          other.userId == this.userId &&
          other.details == this.details &&
          other.payload == this.payload &&
          other.previousHash == this.previousHash &&
          other.currentHash == this.currentHash &&
          other.createdAt == this.createdAt);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLog> {
  final Value<int> id;
  final Value<String> action;
  final Value<int?> invoiceId;
  final Value<String> userId;
  final Value<String> details;
  final Value<String?> payload;
  final Value<String> previousHash;
  final Value<String> currentHash;
  final Value<DateTime> createdAt;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.userId = const Value.absent(),
    this.details = const Value.absent(),
    this.payload = const Value.absent(),
    this.previousHash = const Value.absent(),
    this.currentHash = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    this.id = const Value.absent(),
    required String action,
    this.invoiceId = const Value.absent(),
    required String userId,
    required String details,
    this.payload = const Value.absent(),
    required String previousHash,
    required String currentHash,
    this.createdAt = const Value.absent(),
  }) : action = Value(action),
       userId = Value(userId),
       details = Value(details),
       previousHash = Value(previousHash),
       currentHash = Value(currentHash);
  static Insertable<AuditLog> custom({
    Expression<int>? id,
    Expression<String>? action,
    Expression<int>? invoiceId,
    Expression<String>? userId,
    Expression<String>? details,
    Expression<String>? payload,
    Expression<String>? previousHash,
    Expression<String>? currentHash,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (userId != null) 'user_id': userId,
      if (details != null) 'details': details,
      if (payload != null) 'payload': payload,
      if (previousHash != null) 'previous_hash': previousHash,
      if (currentHash != null) 'current_hash': currentHash,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AuditLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? action,
    Value<int?>? invoiceId,
    Value<String>? userId,
    Value<String>? details,
    Value<String?>? payload,
    Value<String>? previousHash,
    Value<String>? currentHash,
    Value<DateTime>? createdAt,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      invoiceId: invoiceId ?? this.invoiceId,
      userId: userId ?? this.userId,
      details: details ?? this.details,
      payload: payload ?? this.payload,
      previousHash: previousHash ?? this.previousHash,
      currentHash: currentHash ?? this.currentHash,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (previousHash.present) {
      map['previous_hash'] = Variable<String>(previousHash.value);
    }
    if (currentHash.present) {
      map['current_hash'] = Variable<String>(currentHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('userId: $userId, ')
          ..write('details: $details, ')
          ..write('payload: $payload, ')
          ..write('previousHash: $previousHash, ')
          ..write('currentHash: $currentHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CreditNotesTable extends CreditNotes
    with TableInfo<$CreditNotesTable, CreditNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditNotesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _creditNoteNumberMeta = const VerificationMeta(
    'creditNoteNumber',
  );
  @override
  late final GeneratedColumn<int> creditNoteNumber = GeneratedColumn<int>(
    'credit_note_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _managerIdMeta = const VerificationMeta(
    'managerId',
  );
  @override
  late final GeneratedColumn<String> managerId = GeneratedColumn<String>(
    'manager_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
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
    defaultValue: const Constant('PENDING_SYNC'),
  );
  static const VerificationMeta _netTotalMeta = const VerificationMeta(
    'netTotal',
  );
  @override
  late final GeneratedColumn<double> netTotal = GeneratedColumn<double>(
    'net_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vatTotalMeta = const VerificationMeta(
    'vatTotal',
  );
  @override
  late final GeneratedColumn<double> vatTotal = GeneratedColumn<double>(
    'vat_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grossTotalMeta = const VerificationMeta(
    'grossTotal',
  );
  @override
  late final GeneratedColumn<double> grossTotal = GeneratedColumn<double>(
    'gross_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousHashMeta = const VerificationMeta(
    'previousHash',
  );
  @override
  late final GeneratedColumn<String> previousHash = GeneratedColumn<String>(
    'previous_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentHashMeta = const VerificationMeta(
    'currentHash',
  );
  @override
  late final GeneratedColumn<String> currentHash = GeneratedColumn<String>(
    'current_hash',
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
    creditNoteNumber,
    invoiceId,
    managerId,
    reason,
    status,
    netTotal,
    vatTotal,
    grossTotal,
    payload,
    previousHash,
    currentHash,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('credit_note_number')) {
      context.handle(
        _creditNoteNumberMeta,
        creditNoteNumber.isAcceptableOrUnknown(
          data['credit_note_number']!,
          _creditNoteNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creditNoteNumberMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('manager_id')) {
      context.handle(
        _managerIdMeta,
        managerId.isAcceptableOrUnknown(data['manager_id']!, _managerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_managerIdMeta);
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
    if (data.containsKey('net_total')) {
      context.handle(
        _netTotalMeta,
        netTotal.isAcceptableOrUnknown(data['net_total']!, _netTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_netTotalMeta);
    }
    if (data.containsKey('vat_total')) {
      context.handle(
        _vatTotalMeta,
        vatTotal.isAcceptableOrUnknown(data['vat_total']!, _vatTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_vatTotalMeta);
    }
    if (data.containsKey('gross_total')) {
      context.handle(
        _grossTotalMeta,
        grossTotal.isAcceptableOrUnknown(data['gross_total']!, _grossTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_grossTotalMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('previous_hash')) {
      context.handle(
        _previousHashMeta,
        previousHash.isAcceptableOrUnknown(
          data['previous_hash']!,
          _previousHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previousHashMeta);
    }
    if (data.containsKey('current_hash')) {
      context.handle(
        _currentHashMeta,
        currentHash.isAcceptableOrUnknown(
          data['current_hash']!,
          _currentHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentHashMeta);
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
  CreditNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditNote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      creditNoteNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credit_note_number'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      managerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manager_id'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      netTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}net_total'],
      )!,
      vatTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vat_total'],
      )!,
      grossTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gross_total'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      previousHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}previous_hash'],
      )!,
      currentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_hash'],
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
  $CreditNotesTable createAlias(String alias) {
    return $CreditNotesTable(attachedDatabase, alias);
  }
}

class CreditNote extends DataClass implements Insertable<CreditNote> {
  final int id;
  final int creditNoteNumber;
  final int invoiceId;
  final String managerId;
  final String reason;
  final String status;
  final double netTotal;
  final double vatTotal;
  final double grossTotal;
  final String payload;
  final String previousHash;
  final String currentHash;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const CreditNote({
    required this.id,
    required this.creditNoteNumber,
    required this.invoiceId,
    required this.managerId,
    required this.reason,
    required this.status,
    required this.netTotal,
    required this.vatTotal,
    required this.grossTotal,
    required this.payload,
    required this.previousHash,
    required this.currentHash,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['credit_note_number'] = Variable<int>(creditNoteNumber);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['manager_id'] = Variable<String>(managerId);
    map['reason'] = Variable<String>(reason);
    map['status'] = Variable<String>(status);
    map['net_total'] = Variable<double>(netTotal);
    map['vat_total'] = Variable<double>(vatTotal);
    map['gross_total'] = Variable<double>(grossTotal);
    map['payload'] = Variable<String>(payload);
    map['previous_hash'] = Variable<String>(previousHash);
    map['current_hash'] = Variable<String>(currentHash);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  CreditNotesCompanion toCompanion(bool nullToAbsent) {
    return CreditNotesCompanion(
      id: Value(id),
      creditNoteNumber: Value(creditNoteNumber),
      invoiceId: Value(invoiceId),
      managerId: Value(managerId),
      reason: Value(reason),
      status: Value(status),
      netTotal: Value(netTotal),
      vatTotal: Value(vatTotal),
      grossTotal: Value(grossTotal),
      payload: Value(payload),
      previousHash: Value(previousHash),
      currentHash: Value(currentHash),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory CreditNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditNote(
      id: serializer.fromJson<int>(json['id']),
      creditNoteNumber: serializer.fromJson<int>(json['creditNoteNumber']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      managerId: serializer.fromJson<String>(json['managerId']),
      reason: serializer.fromJson<String>(json['reason']),
      status: serializer.fromJson<String>(json['status']),
      netTotal: serializer.fromJson<double>(json['netTotal']),
      vatTotal: serializer.fromJson<double>(json['vatTotal']),
      grossTotal: serializer.fromJson<double>(json['grossTotal']),
      payload: serializer.fromJson<String>(json['payload']),
      previousHash: serializer.fromJson<String>(json['previousHash']),
      currentHash: serializer.fromJson<String>(json['currentHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'creditNoteNumber': serializer.toJson<int>(creditNoteNumber),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'managerId': serializer.toJson<String>(managerId),
      'reason': serializer.toJson<String>(reason),
      'status': serializer.toJson<String>(status),
      'netTotal': serializer.toJson<double>(netTotal),
      'vatTotal': serializer.toJson<double>(vatTotal),
      'grossTotal': serializer.toJson<double>(grossTotal),
      'payload': serializer.toJson<String>(payload),
      'previousHash': serializer.toJson<String>(previousHash),
      'currentHash': serializer.toJson<String>(currentHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  CreditNote copyWith({
    int? id,
    int? creditNoteNumber,
    int? invoiceId,
    String? managerId,
    String? reason,
    String? status,
    double? netTotal,
    double? vatTotal,
    double? grossTotal,
    String? payload,
    String? previousHash,
    String? currentHash,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => CreditNote(
    id: id ?? this.id,
    creditNoteNumber: creditNoteNumber ?? this.creditNoteNumber,
    invoiceId: invoiceId ?? this.invoiceId,
    managerId: managerId ?? this.managerId,
    reason: reason ?? this.reason,
    status: status ?? this.status,
    netTotal: netTotal ?? this.netTotal,
    vatTotal: vatTotal ?? this.vatTotal,
    grossTotal: grossTotal ?? this.grossTotal,
    payload: payload ?? this.payload,
    previousHash: previousHash ?? this.previousHash,
    currentHash: currentHash ?? this.currentHash,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  CreditNote copyWithCompanion(CreditNotesCompanion data) {
    return CreditNote(
      id: data.id.present ? data.id.value : this.id,
      creditNoteNumber: data.creditNoteNumber.present
          ? data.creditNoteNumber.value
          : this.creditNoteNumber,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      managerId: data.managerId.present ? data.managerId.value : this.managerId,
      reason: data.reason.present ? data.reason.value : this.reason,
      status: data.status.present ? data.status.value : this.status,
      netTotal: data.netTotal.present ? data.netTotal.value : this.netTotal,
      vatTotal: data.vatTotal.present ? data.vatTotal.value : this.vatTotal,
      grossTotal: data.grossTotal.present
          ? data.grossTotal.value
          : this.grossTotal,
      payload: data.payload.present ? data.payload.value : this.payload,
      previousHash: data.previousHash.present
          ? data.previousHash.value
          : this.previousHash,
      currentHash: data.currentHash.present
          ? data.currentHash.value
          : this.currentHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditNote(')
          ..write('id: $id, ')
          ..write('creditNoteNumber: $creditNoteNumber, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('managerId: $managerId, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('netTotal: $netTotal, ')
          ..write('vatTotal: $vatTotal, ')
          ..write('grossTotal: $grossTotal, ')
          ..write('payload: $payload, ')
          ..write('previousHash: $previousHash, ')
          ..write('currentHash: $currentHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    creditNoteNumber,
    invoiceId,
    managerId,
    reason,
    status,
    netTotal,
    vatTotal,
    grossTotal,
    payload,
    previousHash,
    currentHash,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditNote &&
          other.id == this.id &&
          other.creditNoteNumber == this.creditNoteNumber &&
          other.invoiceId == this.invoiceId &&
          other.managerId == this.managerId &&
          other.reason == this.reason &&
          other.status == this.status &&
          other.netTotal == this.netTotal &&
          other.vatTotal == this.vatTotal &&
          other.grossTotal == this.grossTotal &&
          other.payload == this.payload &&
          other.previousHash == this.previousHash &&
          other.currentHash == this.currentHash &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CreditNotesCompanion extends UpdateCompanion<CreditNote> {
  final Value<int> id;
  final Value<int> creditNoteNumber;
  final Value<int> invoiceId;
  final Value<String> managerId;
  final Value<String> reason;
  final Value<String> status;
  final Value<double> netTotal;
  final Value<double> vatTotal;
  final Value<double> grossTotal;
  final Value<String> payload;
  final Value<String> previousHash;
  final Value<String> currentHash;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const CreditNotesCompanion({
    this.id = const Value.absent(),
    this.creditNoteNumber = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.managerId = const Value.absent(),
    this.reason = const Value.absent(),
    this.status = const Value.absent(),
    this.netTotal = const Value.absent(),
    this.vatTotal = const Value.absent(),
    this.grossTotal = const Value.absent(),
    this.payload = const Value.absent(),
    this.previousHash = const Value.absent(),
    this.currentHash = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CreditNotesCompanion.insert({
    this.id = const Value.absent(),
    required int creditNoteNumber,
    required int invoiceId,
    required String managerId,
    required String reason,
    this.status = const Value.absent(),
    required double netTotal,
    required double vatTotal,
    required double grossTotal,
    required String payload,
    required String previousHash,
    required String currentHash,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : creditNoteNumber = Value(creditNoteNumber),
       invoiceId = Value(invoiceId),
       managerId = Value(managerId),
       reason = Value(reason),
       netTotal = Value(netTotal),
       vatTotal = Value(vatTotal),
       grossTotal = Value(grossTotal),
       payload = Value(payload),
       previousHash = Value(previousHash),
       currentHash = Value(currentHash);
  static Insertable<CreditNote> custom({
    Expression<int>? id,
    Expression<int>? creditNoteNumber,
    Expression<int>? invoiceId,
    Expression<String>? managerId,
    Expression<String>? reason,
    Expression<String>? status,
    Expression<double>? netTotal,
    Expression<double>? vatTotal,
    Expression<double>? grossTotal,
    Expression<String>? payload,
    Expression<String>? previousHash,
    Expression<String>? currentHash,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (creditNoteNumber != null) 'credit_note_number': creditNoteNumber,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (managerId != null) 'manager_id': managerId,
      if (reason != null) 'reason': reason,
      if (status != null) 'status': status,
      if (netTotal != null) 'net_total': netTotal,
      if (vatTotal != null) 'vat_total': vatTotal,
      if (grossTotal != null) 'gross_total': grossTotal,
      if (payload != null) 'payload': payload,
      if (previousHash != null) 'previous_hash': previousHash,
      if (currentHash != null) 'current_hash': currentHash,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CreditNotesCompanion copyWith({
    Value<int>? id,
    Value<int>? creditNoteNumber,
    Value<int>? invoiceId,
    Value<String>? managerId,
    Value<String>? reason,
    Value<String>? status,
    Value<double>? netTotal,
    Value<double>? vatTotal,
    Value<double>? grossTotal,
    Value<String>? payload,
    Value<String>? previousHash,
    Value<String>? currentHash,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return CreditNotesCompanion(
      id: id ?? this.id,
      creditNoteNumber: creditNoteNumber ?? this.creditNoteNumber,
      invoiceId: invoiceId ?? this.invoiceId,
      managerId: managerId ?? this.managerId,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      netTotal: netTotal ?? this.netTotal,
      vatTotal: vatTotal ?? this.vatTotal,
      grossTotal: grossTotal ?? this.grossTotal,
      payload: payload ?? this.payload,
      previousHash: previousHash ?? this.previousHash,
      currentHash: currentHash ?? this.currentHash,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (creditNoteNumber.present) {
      map['credit_note_number'] = Variable<int>(creditNoteNumber.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (managerId.present) {
      map['manager_id'] = Variable<String>(managerId.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (netTotal.present) {
      map['net_total'] = Variable<double>(netTotal.value);
    }
    if (vatTotal.present) {
      map['vat_total'] = Variable<double>(vatTotal.value);
    }
    if (grossTotal.present) {
      map['gross_total'] = Variable<double>(grossTotal.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (previousHash.present) {
      map['previous_hash'] = Variable<String>(previousHash.value);
    }
    if (currentHash.present) {
      map['current_hash'] = Variable<String>(currentHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditNotesCompanion(')
          ..write('id: $id, ')
          ..write('creditNoteNumber: $creditNoteNumber, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('managerId: $managerId, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('netTotal: $netTotal, ')
          ..write('vatTotal: $vatTotal, ')
          ..write('grossTotal: $grossTotal, ')
          ..write('payload: $payload, ')
          ..write('previousHash: $previousHash, ')
          ..write('currentHash: $currentHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CreditNoteItemsTable extends CreditNoteItems
    with TableInfo<$CreditNoteItemsTable, CreditNoteItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditNoteItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _creditNoteIdMeta = const VerificationMeta(
    'creditNoteId',
  );
  @override
  late final GeneratedColumn<int> creditNoteId = GeneratedColumn<int>(
    'credit_note_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES credit_notes (id)',
    ),
  );
  static const VerificationMeta _invoiceItemIdMeta = const VerificationMeta(
    'invoiceItemId',
  );
  @override
  late final GeneratedColumn<int> invoiceItemId = GeneratedColumn<int>(
    'invoice_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoice_items (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _netAmountMeta = const VerificationMeta(
    'netAmount',
  );
  @override
  late final GeneratedColumn<double> netAmount = GeneratedColumn<double>(
    'net_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vatAmountMeta = const VerificationMeta(
    'vatAmount',
  );
  @override
  late final GeneratedColumn<double> vatAmount = GeneratedColumn<double>(
    'vat_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grossAmountMeta = const VerificationMeta(
    'grossAmount',
  );
  @override
  late final GeneratedColumn<double> grossAmount = GeneratedColumn<double>(
    'gross_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    creditNoteId,
    invoiceItemId,
    quantity,
    netAmount,
    vatAmount,
    grossAmount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_note_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditNoteItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('credit_note_id')) {
      context.handle(
        _creditNoteIdMeta,
        creditNoteId.isAcceptableOrUnknown(
          data['credit_note_id']!,
          _creditNoteIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creditNoteIdMeta);
    }
    if (data.containsKey('invoice_item_id')) {
      context.handle(
        _invoiceItemIdMeta,
        invoiceItemId.isAcceptableOrUnknown(
          data['invoice_item_id']!,
          _invoiceItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceItemIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('net_amount')) {
      context.handle(
        _netAmountMeta,
        netAmount.isAcceptableOrUnknown(data['net_amount']!, _netAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_netAmountMeta);
    }
    if (data.containsKey('vat_amount')) {
      context.handle(
        _vatAmountMeta,
        vatAmount.isAcceptableOrUnknown(data['vat_amount']!, _vatAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_vatAmountMeta);
    }
    if (data.containsKey('gross_amount')) {
      context.handle(
        _grossAmountMeta,
        grossAmount.isAcceptableOrUnknown(
          data['gross_amount']!,
          _grossAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_grossAmountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditNoteItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditNoteItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      creditNoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credit_note_id'],
      )!,
      invoiceItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_item_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      netAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}net_amount'],
      )!,
      vatAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vat_amount'],
      )!,
      grossAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gross_amount'],
      )!,
    );
  }

  @override
  $CreditNoteItemsTable createAlias(String alias) {
    return $CreditNoteItemsTable(attachedDatabase, alias);
  }
}

class CreditNoteItem extends DataClass implements Insertable<CreditNoteItem> {
  final int id;
  final int creditNoteId;
  final int invoiceItemId;
  final double quantity;
  final double netAmount;
  final double vatAmount;
  final double grossAmount;
  const CreditNoteItem({
    required this.id,
    required this.creditNoteId,
    required this.invoiceItemId,
    required this.quantity,
    required this.netAmount,
    required this.vatAmount,
    required this.grossAmount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['credit_note_id'] = Variable<int>(creditNoteId);
    map['invoice_item_id'] = Variable<int>(invoiceItemId);
    map['quantity'] = Variable<double>(quantity);
    map['net_amount'] = Variable<double>(netAmount);
    map['vat_amount'] = Variable<double>(vatAmount);
    map['gross_amount'] = Variable<double>(grossAmount);
    return map;
  }

  CreditNoteItemsCompanion toCompanion(bool nullToAbsent) {
    return CreditNoteItemsCompanion(
      id: Value(id),
      creditNoteId: Value(creditNoteId),
      invoiceItemId: Value(invoiceItemId),
      quantity: Value(quantity),
      netAmount: Value(netAmount),
      vatAmount: Value(vatAmount),
      grossAmount: Value(grossAmount),
    );
  }

  factory CreditNoteItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditNoteItem(
      id: serializer.fromJson<int>(json['id']),
      creditNoteId: serializer.fromJson<int>(json['creditNoteId']),
      invoiceItemId: serializer.fromJson<int>(json['invoiceItemId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      netAmount: serializer.fromJson<double>(json['netAmount']),
      vatAmount: serializer.fromJson<double>(json['vatAmount']),
      grossAmount: serializer.fromJson<double>(json['grossAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'creditNoteId': serializer.toJson<int>(creditNoteId),
      'invoiceItemId': serializer.toJson<int>(invoiceItemId),
      'quantity': serializer.toJson<double>(quantity),
      'netAmount': serializer.toJson<double>(netAmount),
      'vatAmount': serializer.toJson<double>(vatAmount),
      'grossAmount': serializer.toJson<double>(grossAmount),
    };
  }

  CreditNoteItem copyWith({
    int? id,
    int? creditNoteId,
    int? invoiceItemId,
    double? quantity,
    double? netAmount,
    double? vatAmount,
    double? grossAmount,
  }) => CreditNoteItem(
    id: id ?? this.id,
    creditNoteId: creditNoteId ?? this.creditNoteId,
    invoiceItemId: invoiceItemId ?? this.invoiceItemId,
    quantity: quantity ?? this.quantity,
    netAmount: netAmount ?? this.netAmount,
    vatAmount: vatAmount ?? this.vatAmount,
    grossAmount: grossAmount ?? this.grossAmount,
  );
  CreditNoteItem copyWithCompanion(CreditNoteItemsCompanion data) {
    return CreditNoteItem(
      id: data.id.present ? data.id.value : this.id,
      creditNoteId: data.creditNoteId.present
          ? data.creditNoteId.value
          : this.creditNoteId,
      invoiceItemId: data.invoiceItemId.present
          ? data.invoiceItemId.value
          : this.invoiceItemId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      netAmount: data.netAmount.present ? data.netAmount.value : this.netAmount,
      vatAmount: data.vatAmount.present ? data.vatAmount.value : this.vatAmount,
      grossAmount: data.grossAmount.present
          ? data.grossAmount.value
          : this.grossAmount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditNoteItem(')
          ..write('id: $id, ')
          ..write('creditNoteId: $creditNoteId, ')
          ..write('invoiceItemId: $invoiceItemId, ')
          ..write('quantity: $quantity, ')
          ..write('netAmount: $netAmount, ')
          ..write('vatAmount: $vatAmount, ')
          ..write('grossAmount: $grossAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    creditNoteId,
    invoiceItemId,
    quantity,
    netAmount,
    vatAmount,
    grossAmount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditNoteItem &&
          other.id == this.id &&
          other.creditNoteId == this.creditNoteId &&
          other.invoiceItemId == this.invoiceItemId &&
          other.quantity == this.quantity &&
          other.netAmount == this.netAmount &&
          other.vatAmount == this.vatAmount &&
          other.grossAmount == this.grossAmount);
}

class CreditNoteItemsCompanion extends UpdateCompanion<CreditNoteItem> {
  final Value<int> id;
  final Value<int> creditNoteId;
  final Value<int> invoiceItemId;
  final Value<double> quantity;
  final Value<double> netAmount;
  final Value<double> vatAmount;
  final Value<double> grossAmount;
  const CreditNoteItemsCompanion({
    this.id = const Value.absent(),
    this.creditNoteId = const Value.absent(),
    this.invoiceItemId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.netAmount = const Value.absent(),
    this.vatAmount = const Value.absent(),
    this.grossAmount = const Value.absent(),
  });
  CreditNoteItemsCompanion.insert({
    this.id = const Value.absent(),
    required int creditNoteId,
    required int invoiceItemId,
    required double quantity,
    required double netAmount,
    required double vatAmount,
    required double grossAmount,
  }) : creditNoteId = Value(creditNoteId),
       invoiceItemId = Value(invoiceItemId),
       quantity = Value(quantity),
       netAmount = Value(netAmount),
       vatAmount = Value(vatAmount),
       grossAmount = Value(grossAmount);
  static Insertable<CreditNoteItem> custom({
    Expression<int>? id,
    Expression<int>? creditNoteId,
    Expression<int>? invoiceItemId,
    Expression<double>? quantity,
    Expression<double>? netAmount,
    Expression<double>? vatAmount,
    Expression<double>? grossAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (creditNoteId != null) 'credit_note_id': creditNoteId,
      if (invoiceItemId != null) 'invoice_item_id': invoiceItemId,
      if (quantity != null) 'quantity': quantity,
      if (netAmount != null) 'net_amount': netAmount,
      if (vatAmount != null) 'vat_amount': vatAmount,
      if (grossAmount != null) 'gross_amount': grossAmount,
    });
  }

  CreditNoteItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? creditNoteId,
    Value<int>? invoiceItemId,
    Value<double>? quantity,
    Value<double>? netAmount,
    Value<double>? vatAmount,
    Value<double>? grossAmount,
  }) {
    return CreditNoteItemsCompanion(
      id: id ?? this.id,
      creditNoteId: creditNoteId ?? this.creditNoteId,
      invoiceItemId: invoiceItemId ?? this.invoiceItemId,
      quantity: quantity ?? this.quantity,
      netAmount: netAmount ?? this.netAmount,
      vatAmount: vatAmount ?? this.vatAmount,
      grossAmount: grossAmount ?? this.grossAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (creditNoteId.present) {
      map['credit_note_id'] = Variable<int>(creditNoteId.value);
    }
    if (invoiceItemId.present) {
      map['invoice_item_id'] = Variable<int>(invoiceItemId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (netAmount.present) {
      map['net_amount'] = Variable<double>(netAmount.value);
    }
    if (vatAmount.present) {
      map['vat_amount'] = Variable<double>(vatAmount.value);
    }
    if (grossAmount.present) {
      map['gross_amount'] = Variable<double>(grossAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditNoteItemsCompanion(')
          ..write('id: $id, ')
          ..write('creditNoteId: $creditNoteId, ')
          ..write('invoiceItemId: $invoiceItemId, ')
          ..write('quantity: $quantity, ')
          ..write('netAmount: $netAmount, ')
          ..write('vatAmount: $vatAmount, ')
          ..write('grossAmount: $grossAmount')
          ..write(')'))
        .toString();
  }
}

class $CancellationRequestsTable extends CancellationRequests
    with TableInfo<$CancellationRequestsTable, CancellationRequest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CancellationRequestsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _managerIdMeta = const VerificationMeta(
    'managerId',
  );
  @override
  late final GeneratedColumn<String> managerId = GeneratedColumn<String>(
    'manager_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
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
    defaultValue: const Constant('PENDING'),
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousHashMeta = const VerificationMeta(
    'previousHash',
  );
  @override
  late final GeneratedColumn<String> previousHash = GeneratedColumn<String>(
    'previous_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentHashMeta = const VerificationMeta(
    'currentHash',
  );
  @override
  late final GeneratedColumn<String> currentHash = GeneratedColumn<String>(
    'current_hash',
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
    invoiceId,
    managerId,
    reason,
    status,
    payload,
    previousHash,
    currentHash,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cancellation_requests';
  @override
  VerificationContext validateIntegrity(
    Insertable<CancellationRequest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('manager_id')) {
      context.handle(
        _managerIdMeta,
        managerId.isAcceptableOrUnknown(data['manager_id']!, _managerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_managerIdMeta);
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
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('previous_hash')) {
      context.handle(
        _previousHashMeta,
        previousHash.isAcceptableOrUnknown(
          data['previous_hash']!,
          _previousHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previousHashMeta);
    }
    if (data.containsKey('current_hash')) {
      context.handle(
        _currentHashMeta,
        currentHash.isAcceptableOrUnknown(
          data['current_hash']!,
          _currentHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentHashMeta);
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
  CancellationRequest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CancellationRequest(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      managerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manager_id'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      previousHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}previous_hash'],
      )!,
      currentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_hash'],
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
  $CancellationRequestsTable createAlias(String alias) {
    return $CancellationRequestsTable(attachedDatabase, alias);
  }
}

class CancellationRequest extends DataClass
    implements Insertable<CancellationRequest> {
  final int id;
  final int invoiceId;
  final String managerId;
  final String reason;
  final String status;
  final String payload;
  final String previousHash;
  final String currentHash;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const CancellationRequest({
    required this.id,
    required this.invoiceId,
    required this.managerId,
    required this.reason,
    required this.status,
    required this.payload,
    required this.previousHash,
    required this.currentHash,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['manager_id'] = Variable<String>(managerId);
    map['reason'] = Variable<String>(reason);
    map['status'] = Variable<String>(status);
    map['payload'] = Variable<String>(payload);
    map['previous_hash'] = Variable<String>(previousHash);
    map['current_hash'] = Variable<String>(currentHash);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  CancellationRequestsCompanion toCompanion(bool nullToAbsent) {
    return CancellationRequestsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      managerId: Value(managerId),
      reason: Value(reason),
      status: Value(status),
      payload: Value(payload),
      previousHash: Value(previousHash),
      currentHash: Value(currentHash),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory CancellationRequest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CancellationRequest(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      managerId: serializer.fromJson<String>(json['managerId']),
      reason: serializer.fromJson<String>(json['reason']),
      status: serializer.fromJson<String>(json['status']),
      payload: serializer.fromJson<String>(json['payload']),
      previousHash: serializer.fromJson<String>(json['previousHash']),
      currentHash: serializer.fromJson<String>(json['currentHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'managerId': serializer.toJson<String>(managerId),
      'reason': serializer.toJson<String>(reason),
      'status': serializer.toJson<String>(status),
      'payload': serializer.toJson<String>(payload),
      'previousHash': serializer.toJson<String>(previousHash),
      'currentHash': serializer.toJson<String>(currentHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  CancellationRequest copyWith({
    int? id,
    int? invoiceId,
    String? managerId,
    String? reason,
    String? status,
    String? payload,
    String? previousHash,
    String? currentHash,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => CancellationRequest(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    managerId: managerId ?? this.managerId,
    reason: reason ?? this.reason,
    status: status ?? this.status,
    payload: payload ?? this.payload,
    previousHash: previousHash ?? this.previousHash,
    currentHash: currentHash ?? this.currentHash,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  CancellationRequest copyWithCompanion(CancellationRequestsCompanion data) {
    return CancellationRequest(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      managerId: data.managerId.present ? data.managerId.value : this.managerId,
      reason: data.reason.present ? data.reason.value : this.reason,
      status: data.status.present ? data.status.value : this.status,
      payload: data.payload.present ? data.payload.value : this.payload,
      previousHash: data.previousHash.present
          ? data.previousHash.value
          : this.previousHash,
      currentHash: data.currentHash.present
          ? data.currentHash.value
          : this.currentHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CancellationRequest(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('managerId: $managerId, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('payload: $payload, ')
          ..write('previousHash: $previousHash, ')
          ..write('currentHash: $currentHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    managerId,
    reason,
    status,
    payload,
    previousHash,
    currentHash,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CancellationRequest &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.managerId == this.managerId &&
          other.reason == this.reason &&
          other.status == this.status &&
          other.payload == this.payload &&
          other.previousHash == this.previousHash &&
          other.currentHash == this.currentHash &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CancellationRequestsCompanion
    extends UpdateCompanion<CancellationRequest> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<String> managerId;
  final Value<String> reason;
  final Value<String> status;
  final Value<String> payload;
  final Value<String> previousHash;
  final Value<String> currentHash;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const CancellationRequestsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.managerId = const Value.absent(),
    this.reason = const Value.absent(),
    this.status = const Value.absent(),
    this.payload = const Value.absent(),
    this.previousHash = const Value.absent(),
    this.currentHash = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CancellationRequestsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required String managerId,
    required String reason,
    this.status = const Value.absent(),
    required String payload,
    required String previousHash,
    required String currentHash,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       managerId = Value(managerId),
       reason = Value(reason),
       payload = Value(payload),
       previousHash = Value(previousHash),
       currentHash = Value(currentHash);
  static Insertable<CancellationRequest> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<String>? managerId,
    Expression<String>? reason,
    Expression<String>? status,
    Expression<String>? payload,
    Expression<String>? previousHash,
    Expression<String>? currentHash,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (managerId != null) 'manager_id': managerId,
      if (reason != null) 'reason': reason,
      if (status != null) 'status': status,
      if (payload != null) 'payload': payload,
      if (previousHash != null) 'previous_hash': previousHash,
      if (currentHash != null) 'current_hash': currentHash,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CancellationRequestsCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<String>? managerId,
    Value<String>? reason,
    Value<String>? status,
    Value<String>? payload,
    Value<String>? previousHash,
    Value<String>? currentHash,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return CancellationRequestsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      managerId: managerId ?? this.managerId,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      payload: payload ?? this.payload,
      previousHash: previousHash ?? this.previousHash,
      currentHash: currentHash ?? this.currentHash,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (managerId.present) {
      map['manager_id'] = Variable<String>(managerId.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (previousHash.present) {
      map['previous_hash'] = Variable<String>(previousHash.value);
    }
    if (currentHash.present) {
      map['current_hash'] = Variable<String>(currentHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CancellationRequestsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('managerId: $managerId, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('payload: $payload, ')
          ..write('previousHash: $previousHash, ')
          ..write('currentHash: $currentHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DailyReportsTable extends DailyReports
    with TableInfo<$DailyReportsTable, DailyReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyReportsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _zNumberMeta = const VerificationMeta(
    'zNumber',
  );
  @override
  late final GeneratedColumn<int> zNumber = GeneratedColumn<int>(
    'z_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _reportDateMeta = const VerificationMeta(
    'reportDate',
  );
  @override
  late final GeneratedColumn<String> reportDate = GeneratedColumn<String>(
    'report_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _managerIdMeta = const VerificationMeta(
    'managerId',
  );
  @override
  late final GeneratedColumn<String> managerId = GeneratedColumn<String>(
    'manager_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _invoiceCountMeta = const VerificationMeta(
    'invoiceCount',
  );
  @override
  late final GeneratedColumn<int> invoiceCount = GeneratedColumn<int>(
    'invoice_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _netTotalMeta = const VerificationMeta(
    'netTotal',
  );
  @override
  late final GeneratedColumn<double> netTotal = GeneratedColumn<double>(
    'net_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vatTotalMeta = const VerificationMeta(
    'vatTotal',
  );
  @override
  late final GeneratedColumn<double> vatTotal = GeneratedColumn<double>(
    'vat_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grossTotalMeta = const VerificationMeta(
    'grossTotal',
  );
  @override
  late final GeneratedColumn<double> grossTotal = GeneratedColumn<double>(
    'gross_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditNetTotalMeta = const VerificationMeta(
    'creditNetTotal',
  );
  @override
  late final GeneratedColumn<double> creditNetTotal = GeneratedColumn<double>(
    'credit_net_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditVatTotalMeta = const VerificationMeta(
    'creditVatTotal',
  );
  @override
  late final GeneratedColumn<double> creditVatTotal = GeneratedColumn<double>(
    'credit_vat_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditGrossTotalMeta = const VerificationMeta(
    'creditGrossTotal',
  );
  @override
  late final GeneratedColumn<double> creditGrossTotal = GeneratedColumn<double>(
    'credit_gross_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cashTotalMeta = const VerificationMeta(
    'cashTotal',
  );
  @override
  late final GeneratedColumn<double> cashTotal = GeneratedColumn<double>(
    'cash_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _telebirrTotalMeta = const VerificationMeta(
    'telebirrTotal',
  );
  @override
  late final GeneratedColumn<double> telebirrTotal = GeneratedColumn<double>(
    'telebirr_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cbeBirrTotalMeta = const VerificationMeta(
    'cbeBirrTotal',
  );
  @override
  late final GeneratedColumn<double> cbeBirrTotal = GeneratedColumn<double>(
    'cbe_birr_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cashCountMeta = const VerificationMeta(
    'cashCount',
  );
  @override
  late final GeneratedColumn<double> cashCount = GeneratedColumn<double>(
    'cash_count',
    aliasedName,
    false,
    type: DriftSqlType.double,
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
    defaultValue: const Constant('PENDING_SYNC'),
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousHashMeta = const VerificationMeta(
    'previousHash',
  );
  @override
  late final GeneratedColumn<String> previousHash = GeneratedColumn<String>(
    'previous_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentHashMeta = const VerificationMeta(
    'currentHash',
  );
  @override
  late final GeneratedColumn<String> currentHash = GeneratedColumn<String>(
    'current_hash',
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
    zNumber,
    reportDate,
    managerId,
    invoiceCount,
    netTotal,
    vatTotal,
    grossTotal,
    creditNetTotal,
    creditVatTotal,
    creditGrossTotal,
    cashTotal,
    telebirrTotal,
    cbeBirrTotal,
    cashCount,
    status,
    payload,
    previousHash,
    currentHash,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('z_number')) {
      context.handle(
        _zNumberMeta,
        zNumber.isAcceptableOrUnknown(data['z_number']!, _zNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_zNumberMeta);
    }
    if (data.containsKey('report_date')) {
      context.handle(
        _reportDateMeta,
        reportDate.isAcceptableOrUnknown(data['report_date']!, _reportDateMeta),
      );
    } else if (isInserting) {
      context.missing(_reportDateMeta);
    }
    if (data.containsKey('manager_id')) {
      context.handle(
        _managerIdMeta,
        managerId.isAcceptableOrUnknown(data['manager_id']!, _managerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_managerIdMeta);
    }
    if (data.containsKey('invoice_count')) {
      context.handle(
        _invoiceCountMeta,
        invoiceCount.isAcceptableOrUnknown(
          data['invoice_count']!,
          _invoiceCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceCountMeta);
    }
    if (data.containsKey('net_total')) {
      context.handle(
        _netTotalMeta,
        netTotal.isAcceptableOrUnknown(data['net_total']!, _netTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_netTotalMeta);
    }
    if (data.containsKey('vat_total')) {
      context.handle(
        _vatTotalMeta,
        vatTotal.isAcceptableOrUnknown(data['vat_total']!, _vatTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_vatTotalMeta);
    }
    if (data.containsKey('gross_total')) {
      context.handle(
        _grossTotalMeta,
        grossTotal.isAcceptableOrUnknown(data['gross_total']!, _grossTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_grossTotalMeta);
    }
    if (data.containsKey('credit_net_total')) {
      context.handle(
        _creditNetTotalMeta,
        creditNetTotal.isAcceptableOrUnknown(
          data['credit_net_total']!,
          _creditNetTotalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creditNetTotalMeta);
    }
    if (data.containsKey('credit_vat_total')) {
      context.handle(
        _creditVatTotalMeta,
        creditVatTotal.isAcceptableOrUnknown(
          data['credit_vat_total']!,
          _creditVatTotalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creditVatTotalMeta);
    }
    if (data.containsKey('credit_gross_total')) {
      context.handle(
        _creditGrossTotalMeta,
        creditGrossTotal.isAcceptableOrUnknown(
          data['credit_gross_total']!,
          _creditGrossTotalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creditGrossTotalMeta);
    }
    if (data.containsKey('cash_total')) {
      context.handle(
        _cashTotalMeta,
        cashTotal.isAcceptableOrUnknown(data['cash_total']!, _cashTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_cashTotalMeta);
    }
    if (data.containsKey('telebirr_total')) {
      context.handle(
        _telebirrTotalMeta,
        telebirrTotal.isAcceptableOrUnknown(
          data['telebirr_total']!,
          _telebirrTotalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_telebirrTotalMeta);
    }
    if (data.containsKey('cbe_birr_total')) {
      context.handle(
        _cbeBirrTotalMeta,
        cbeBirrTotal.isAcceptableOrUnknown(
          data['cbe_birr_total']!,
          _cbeBirrTotalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cbeBirrTotalMeta);
    }
    if (data.containsKey('cash_count')) {
      context.handle(
        _cashCountMeta,
        cashCount.isAcceptableOrUnknown(data['cash_count']!, _cashCountMeta),
      );
    } else if (isInserting) {
      context.missing(_cashCountMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('previous_hash')) {
      context.handle(
        _previousHashMeta,
        previousHash.isAcceptableOrUnknown(
          data['previous_hash']!,
          _previousHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previousHashMeta);
    }
    if (data.containsKey('current_hash')) {
      context.handle(
        _currentHashMeta,
        currentHash.isAcceptableOrUnknown(
          data['current_hash']!,
          _currentHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentHashMeta);
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
  DailyReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      zNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}z_number'],
      )!,
      reportDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_date'],
      )!,
      managerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manager_id'],
      )!,
      invoiceCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_count'],
      )!,
      netTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}net_total'],
      )!,
      vatTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vat_total'],
      )!,
      grossTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gross_total'],
      )!,
      creditNetTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_net_total'],
      )!,
      creditVatTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_vat_total'],
      )!,
      creditGrossTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_gross_total'],
      )!,
      cashTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cash_total'],
      )!,
      telebirrTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}telebirr_total'],
      )!,
      cbeBirrTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cbe_birr_total'],
      )!,
      cashCount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cash_count'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      previousHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}previous_hash'],
      )!,
      currentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_hash'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DailyReportsTable createAlias(String alias) {
    return $DailyReportsTable(attachedDatabase, alias);
  }
}

class DailyReport extends DataClass implements Insertable<DailyReport> {
  final int id;
  final int zNumber;
  final String reportDate;
  final String managerId;
  final int invoiceCount;
  final double netTotal;
  final double vatTotal;
  final double grossTotal;
  final double creditNetTotal;
  final double creditVatTotal;
  final double creditGrossTotal;
  final double cashTotal;
  final double telebirrTotal;
  final double cbeBirrTotal;
  final double cashCount;
  final String status;
  final String payload;
  final String previousHash;
  final String currentHash;
  final DateTime createdAt;
  const DailyReport({
    required this.id,
    required this.zNumber,
    required this.reportDate,
    required this.managerId,
    required this.invoiceCount,
    required this.netTotal,
    required this.vatTotal,
    required this.grossTotal,
    required this.creditNetTotal,
    required this.creditVatTotal,
    required this.creditGrossTotal,
    required this.cashTotal,
    required this.telebirrTotal,
    required this.cbeBirrTotal,
    required this.cashCount,
    required this.status,
    required this.payload,
    required this.previousHash,
    required this.currentHash,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['z_number'] = Variable<int>(zNumber);
    map['report_date'] = Variable<String>(reportDate);
    map['manager_id'] = Variable<String>(managerId);
    map['invoice_count'] = Variable<int>(invoiceCount);
    map['net_total'] = Variable<double>(netTotal);
    map['vat_total'] = Variable<double>(vatTotal);
    map['gross_total'] = Variable<double>(grossTotal);
    map['credit_net_total'] = Variable<double>(creditNetTotal);
    map['credit_vat_total'] = Variable<double>(creditVatTotal);
    map['credit_gross_total'] = Variable<double>(creditGrossTotal);
    map['cash_total'] = Variable<double>(cashTotal);
    map['telebirr_total'] = Variable<double>(telebirrTotal);
    map['cbe_birr_total'] = Variable<double>(cbeBirrTotal);
    map['cash_count'] = Variable<double>(cashCount);
    map['status'] = Variable<String>(status);
    map['payload'] = Variable<String>(payload);
    map['previous_hash'] = Variable<String>(previousHash);
    map['current_hash'] = Variable<String>(currentHash);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DailyReportsCompanion toCompanion(bool nullToAbsent) {
    return DailyReportsCompanion(
      id: Value(id),
      zNumber: Value(zNumber),
      reportDate: Value(reportDate),
      managerId: Value(managerId),
      invoiceCount: Value(invoiceCount),
      netTotal: Value(netTotal),
      vatTotal: Value(vatTotal),
      grossTotal: Value(grossTotal),
      creditNetTotal: Value(creditNetTotal),
      creditVatTotal: Value(creditVatTotal),
      creditGrossTotal: Value(creditGrossTotal),
      cashTotal: Value(cashTotal),
      telebirrTotal: Value(telebirrTotal),
      cbeBirrTotal: Value(cbeBirrTotal),
      cashCount: Value(cashCount),
      status: Value(status),
      payload: Value(payload),
      previousHash: Value(previousHash),
      currentHash: Value(currentHash),
      createdAt: Value(createdAt),
    );
  }

  factory DailyReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyReport(
      id: serializer.fromJson<int>(json['id']),
      zNumber: serializer.fromJson<int>(json['zNumber']),
      reportDate: serializer.fromJson<String>(json['reportDate']),
      managerId: serializer.fromJson<String>(json['managerId']),
      invoiceCount: serializer.fromJson<int>(json['invoiceCount']),
      netTotal: serializer.fromJson<double>(json['netTotal']),
      vatTotal: serializer.fromJson<double>(json['vatTotal']),
      grossTotal: serializer.fromJson<double>(json['grossTotal']),
      creditNetTotal: serializer.fromJson<double>(json['creditNetTotal']),
      creditVatTotal: serializer.fromJson<double>(json['creditVatTotal']),
      creditGrossTotal: serializer.fromJson<double>(json['creditGrossTotal']),
      cashTotal: serializer.fromJson<double>(json['cashTotal']),
      telebirrTotal: serializer.fromJson<double>(json['telebirrTotal']),
      cbeBirrTotal: serializer.fromJson<double>(json['cbeBirrTotal']),
      cashCount: serializer.fromJson<double>(json['cashCount']),
      status: serializer.fromJson<String>(json['status']),
      payload: serializer.fromJson<String>(json['payload']),
      previousHash: serializer.fromJson<String>(json['previousHash']),
      currentHash: serializer.fromJson<String>(json['currentHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'zNumber': serializer.toJson<int>(zNumber),
      'reportDate': serializer.toJson<String>(reportDate),
      'managerId': serializer.toJson<String>(managerId),
      'invoiceCount': serializer.toJson<int>(invoiceCount),
      'netTotal': serializer.toJson<double>(netTotal),
      'vatTotal': serializer.toJson<double>(vatTotal),
      'grossTotal': serializer.toJson<double>(grossTotal),
      'creditNetTotal': serializer.toJson<double>(creditNetTotal),
      'creditVatTotal': serializer.toJson<double>(creditVatTotal),
      'creditGrossTotal': serializer.toJson<double>(creditGrossTotal),
      'cashTotal': serializer.toJson<double>(cashTotal),
      'telebirrTotal': serializer.toJson<double>(telebirrTotal),
      'cbeBirrTotal': serializer.toJson<double>(cbeBirrTotal),
      'cashCount': serializer.toJson<double>(cashCount),
      'status': serializer.toJson<String>(status),
      'payload': serializer.toJson<String>(payload),
      'previousHash': serializer.toJson<String>(previousHash),
      'currentHash': serializer.toJson<String>(currentHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DailyReport copyWith({
    int? id,
    int? zNumber,
    String? reportDate,
    String? managerId,
    int? invoiceCount,
    double? netTotal,
    double? vatTotal,
    double? grossTotal,
    double? creditNetTotal,
    double? creditVatTotal,
    double? creditGrossTotal,
    double? cashTotal,
    double? telebirrTotal,
    double? cbeBirrTotal,
    double? cashCount,
    String? status,
    String? payload,
    String? previousHash,
    String? currentHash,
    DateTime? createdAt,
  }) => DailyReport(
    id: id ?? this.id,
    zNumber: zNumber ?? this.zNumber,
    reportDate: reportDate ?? this.reportDate,
    managerId: managerId ?? this.managerId,
    invoiceCount: invoiceCount ?? this.invoiceCount,
    netTotal: netTotal ?? this.netTotal,
    vatTotal: vatTotal ?? this.vatTotal,
    grossTotal: grossTotal ?? this.grossTotal,
    creditNetTotal: creditNetTotal ?? this.creditNetTotal,
    creditVatTotal: creditVatTotal ?? this.creditVatTotal,
    creditGrossTotal: creditGrossTotal ?? this.creditGrossTotal,
    cashTotal: cashTotal ?? this.cashTotal,
    telebirrTotal: telebirrTotal ?? this.telebirrTotal,
    cbeBirrTotal: cbeBirrTotal ?? this.cbeBirrTotal,
    cashCount: cashCount ?? this.cashCount,
    status: status ?? this.status,
    payload: payload ?? this.payload,
    previousHash: previousHash ?? this.previousHash,
    currentHash: currentHash ?? this.currentHash,
    createdAt: createdAt ?? this.createdAt,
  );
  DailyReport copyWithCompanion(DailyReportsCompanion data) {
    return DailyReport(
      id: data.id.present ? data.id.value : this.id,
      zNumber: data.zNumber.present ? data.zNumber.value : this.zNumber,
      reportDate: data.reportDate.present
          ? data.reportDate.value
          : this.reportDate,
      managerId: data.managerId.present ? data.managerId.value : this.managerId,
      invoiceCount: data.invoiceCount.present
          ? data.invoiceCount.value
          : this.invoiceCount,
      netTotal: data.netTotal.present ? data.netTotal.value : this.netTotal,
      vatTotal: data.vatTotal.present ? data.vatTotal.value : this.vatTotal,
      grossTotal: data.grossTotal.present
          ? data.grossTotal.value
          : this.grossTotal,
      creditNetTotal: data.creditNetTotal.present
          ? data.creditNetTotal.value
          : this.creditNetTotal,
      creditVatTotal: data.creditVatTotal.present
          ? data.creditVatTotal.value
          : this.creditVatTotal,
      creditGrossTotal: data.creditGrossTotal.present
          ? data.creditGrossTotal.value
          : this.creditGrossTotal,
      cashTotal: data.cashTotal.present ? data.cashTotal.value : this.cashTotal,
      telebirrTotal: data.telebirrTotal.present
          ? data.telebirrTotal.value
          : this.telebirrTotal,
      cbeBirrTotal: data.cbeBirrTotal.present
          ? data.cbeBirrTotal.value
          : this.cbeBirrTotal,
      cashCount: data.cashCount.present ? data.cashCount.value : this.cashCount,
      status: data.status.present ? data.status.value : this.status,
      payload: data.payload.present ? data.payload.value : this.payload,
      previousHash: data.previousHash.present
          ? data.previousHash.value
          : this.previousHash,
      currentHash: data.currentHash.present
          ? data.currentHash.value
          : this.currentHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyReport(')
          ..write('id: $id, ')
          ..write('zNumber: $zNumber, ')
          ..write('reportDate: $reportDate, ')
          ..write('managerId: $managerId, ')
          ..write('invoiceCount: $invoiceCount, ')
          ..write('netTotal: $netTotal, ')
          ..write('vatTotal: $vatTotal, ')
          ..write('grossTotal: $grossTotal, ')
          ..write('creditNetTotal: $creditNetTotal, ')
          ..write('creditVatTotal: $creditVatTotal, ')
          ..write('creditGrossTotal: $creditGrossTotal, ')
          ..write('cashTotal: $cashTotal, ')
          ..write('telebirrTotal: $telebirrTotal, ')
          ..write('cbeBirrTotal: $cbeBirrTotal, ')
          ..write('cashCount: $cashCount, ')
          ..write('status: $status, ')
          ..write('payload: $payload, ')
          ..write('previousHash: $previousHash, ')
          ..write('currentHash: $currentHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    zNumber,
    reportDate,
    managerId,
    invoiceCount,
    netTotal,
    vatTotal,
    grossTotal,
    creditNetTotal,
    creditVatTotal,
    creditGrossTotal,
    cashTotal,
    telebirrTotal,
    cbeBirrTotal,
    cashCount,
    status,
    payload,
    previousHash,
    currentHash,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyReport &&
          other.id == this.id &&
          other.zNumber == this.zNumber &&
          other.reportDate == this.reportDate &&
          other.managerId == this.managerId &&
          other.invoiceCount == this.invoiceCount &&
          other.netTotal == this.netTotal &&
          other.vatTotal == this.vatTotal &&
          other.grossTotal == this.grossTotal &&
          other.creditNetTotal == this.creditNetTotal &&
          other.creditVatTotal == this.creditVatTotal &&
          other.creditGrossTotal == this.creditGrossTotal &&
          other.cashTotal == this.cashTotal &&
          other.telebirrTotal == this.telebirrTotal &&
          other.cbeBirrTotal == this.cbeBirrTotal &&
          other.cashCount == this.cashCount &&
          other.status == this.status &&
          other.payload == this.payload &&
          other.previousHash == this.previousHash &&
          other.currentHash == this.currentHash &&
          other.createdAt == this.createdAt);
}

class DailyReportsCompanion extends UpdateCompanion<DailyReport> {
  final Value<int> id;
  final Value<int> zNumber;
  final Value<String> reportDate;
  final Value<String> managerId;
  final Value<int> invoiceCount;
  final Value<double> netTotal;
  final Value<double> vatTotal;
  final Value<double> grossTotal;
  final Value<double> creditNetTotal;
  final Value<double> creditVatTotal;
  final Value<double> creditGrossTotal;
  final Value<double> cashTotal;
  final Value<double> telebirrTotal;
  final Value<double> cbeBirrTotal;
  final Value<double> cashCount;
  final Value<String> status;
  final Value<String> payload;
  final Value<String> previousHash;
  final Value<String> currentHash;
  final Value<DateTime> createdAt;
  const DailyReportsCompanion({
    this.id = const Value.absent(),
    this.zNumber = const Value.absent(),
    this.reportDate = const Value.absent(),
    this.managerId = const Value.absent(),
    this.invoiceCount = const Value.absent(),
    this.netTotal = const Value.absent(),
    this.vatTotal = const Value.absent(),
    this.grossTotal = const Value.absent(),
    this.creditNetTotal = const Value.absent(),
    this.creditVatTotal = const Value.absent(),
    this.creditGrossTotal = const Value.absent(),
    this.cashTotal = const Value.absent(),
    this.telebirrTotal = const Value.absent(),
    this.cbeBirrTotal = const Value.absent(),
    this.cashCount = const Value.absent(),
    this.status = const Value.absent(),
    this.payload = const Value.absent(),
    this.previousHash = const Value.absent(),
    this.currentHash = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DailyReportsCompanion.insert({
    this.id = const Value.absent(),
    required int zNumber,
    required String reportDate,
    required String managerId,
    required int invoiceCount,
    required double netTotal,
    required double vatTotal,
    required double grossTotal,
    required double creditNetTotal,
    required double creditVatTotal,
    required double creditGrossTotal,
    required double cashTotal,
    required double telebirrTotal,
    required double cbeBirrTotal,
    required double cashCount,
    this.status = const Value.absent(),
    required String payload,
    required String previousHash,
    required String currentHash,
    this.createdAt = const Value.absent(),
  }) : zNumber = Value(zNumber),
       reportDate = Value(reportDate),
       managerId = Value(managerId),
       invoiceCount = Value(invoiceCount),
       netTotal = Value(netTotal),
       vatTotal = Value(vatTotal),
       grossTotal = Value(grossTotal),
       creditNetTotal = Value(creditNetTotal),
       creditVatTotal = Value(creditVatTotal),
       creditGrossTotal = Value(creditGrossTotal),
       cashTotal = Value(cashTotal),
       telebirrTotal = Value(telebirrTotal),
       cbeBirrTotal = Value(cbeBirrTotal),
       cashCount = Value(cashCount),
       payload = Value(payload),
       previousHash = Value(previousHash),
       currentHash = Value(currentHash);
  static Insertable<DailyReport> custom({
    Expression<int>? id,
    Expression<int>? zNumber,
    Expression<String>? reportDate,
    Expression<String>? managerId,
    Expression<int>? invoiceCount,
    Expression<double>? netTotal,
    Expression<double>? vatTotal,
    Expression<double>? grossTotal,
    Expression<double>? creditNetTotal,
    Expression<double>? creditVatTotal,
    Expression<double>? creditGrossTotal,
    Expression<double>? cashTotal,
    Expression<double>? telebirrTotal,
    Expression<double>? cbeBirrTotal,
    Expression<double>? cashCount,
    Expression<String>? status,
    Expression<String>? payload,
    Expression<String>? previousHash,
    Expression<String>? currentHash,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (zNumber != null) 'z_number': zNumber,
      if (reportDate != null) 'report_date': reportDate,
      if (managerId != null) 'manager_id': managerId,
      if (invoiceCount != null) 'invoice_count': invoiceCount,
      if (netTotal != null) 'net_total': netTotal,
      if (vatTotal != null) 'vat_total': vatTotal,
      if (grossTotal != null) 'gross_total': grossTotal,
      if (creditNetTotal != null) 'credit_net_total': creditNetTotal,
      if (creditVatTotal != null) 'credit_vat_total': creditVatTotal,
      if (creditGrossTotal != null) 'credit_gross_total': creditGrossTotal,
      if (cashTotal != null) 'cash_total': cashTotal,
      if (telebirrTotal != null) 'telebirr_total': telebirrTotal,
      if (cbeBirrTotal != null) 'cbe_birr_total': cbeBirrTotal,
      if (cashCount != null) 'cash_count': cashCount,
      if (status != null) 'status': status,
      if (payload != null) 'payload': payload,
      if (previousHash != null) 'previous_hash': previousHash,
      if (currentHash != null) 'current_hash': currentHash,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DailyReportsCompanion copyWith({
    Value<int>? id,
    Value<int>? zNumber,
    Value<String>? reportDate,
    Value<String>? managerId,
    Value<int>? invoiceCount,
    Value<double>? netTotal,
    Value<double>? vatTotal,
    Value<double>? grossTotal,
    Value<double>? creditNetTotal,
    Value<double>? creditVatTotal,
    Value<double>? creditGrossTotal,
    Value<double>? cashTotal,
    Value<double>? telebirrTotal,
    Value<double>? cbeBirrTotal,
    Value<double>? cashCount,
    Value<String>? status,
    Value<String>? payload,
    Value<String>? previousHash,
    Value<String>? currentHash,
    Value<DateTime>? createdAt,
  }) {
    return DailyReportsCompanion(
      id: id ?? this.id,
      zNumber: zNumber ?? this.zNumber,
      reportDate: reportDate ?? this.reportDate,
      managerId: managerId ?? this.managerId,
      invoiceCount: invoiceCount ?? this.invoiceCount,
      netTotal: netTotal ?? this.netTotal,
      vatTotal: vatTotal ?? this.vatTotal,
      grossTotal: grossTotal ?? this.grossTotal,
      creditNetTotal: creditNetTotal ?? this.creditNetTotal,
      creditVatTotal: creditVatTotal ?? this.creditVatTotal,
      creditGrossTotal: creditGrossTotal ?? this.creditGrossTotal,
      cashTotal: cashTotal ?? this.cashTotal,
      telebirrTotal: telebirrTotal ?? this.telebirrTotal,
      cbeBirrTotal: cbeBirrTotal ?? this.cbeBirrTotal,
      cashCount: cashCount ?? this.cashCount,
      status: status ?? this.status,
      payload: payload ?? this.payload,
      previousHash: previousHash ?? this.previousHash,
      currentHash: currentHash ?? this.currentHash,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (zNumber.present) {
      map['z_number'] = Variable<int>(zNumber.value);
    }
    if (reportDate.present) {
      map['report_date'] = Variable<String>(reportDate.value);
    }
    if (managerId.present) {
      map['manager_id'] = Variable<String>(managerId.value);
    }
    if (invoiceCount.present) {
      map['invoice_count'] = Variable<int>(invoiceCount.value);
    }
    if (netTotal.present) {
      map['net_total'] = Variable<double>(netTotal.value);
    }
    if (vatTotal.present) {
      map['vat_total'] = Variable<double>(vatTotal.value);
    }
    if (grossTotal.present) {
      map['gross_total'] = Variable<double>(grossTotal.value);
    }
    if (creditNetTotal.present) {
      map['credit_net_total'] = Variable<double>(creditNetTotal.value);
    }
    if (creditVatTotal.present) {
      map['credit_vat_total'] = Variable<double>(creditVatTotal.value);
    }
    if (creditGrossTotal.present) {
      map['credit_gross_total'] = Variable<double>(creditGrossTotal.value);
    }
    if (cashTotal.present) {
      map['cash_total'] = Variable<double>(cashTotal.value);
    }
    if (telebirrTotal.present) {
      map['telebirr_total'] = Variable<double>(telebirrTotal.value);
    }
    if (cbeBirrTotal.present) {
      map['cbe_birr_total'] = Variable<double>(cbeBirrTotal.value);
    }
    if (cashCount.present) {
      map['cash_count'] = Variable<double>(cashCount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (previousHash.present) {
      map['previous_hash'] = Variable<String>(previousHash.value);
    }
    if (currentHash.present) {
      map['current_hash'] = Variable<String>(currentHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyReportsCompanion(')
          ..write('id: $id, ')
          ..write('zNumber: $zNumber, ')
          ..write('reportDate: $reportDate, ')
          ..write('managerId: $managerId, ')
          ..write('invoiceCount: $invoiceCount, ')
          ..write('netTotal: $netTotal, ')
          ..write('vatTotal: $vatTotal, ')
          ..write('grossTotal: $grossTotal, ')
          ..write('creditNetTotal: $creditNetTotal, ')
          ..write('creditVatTotal: $creditVatTotal, ')
          ..write('creditGrossTotal: $creditGrossTotal, ')
          ..write('cashTotal: $cashTotal, ')
          ..write('telebirrTotal: $telebirrTotal, ')
          ..write('cbeBirrTotal: $cbeBirrTotal, ')
          ..write('cashCount: $cashCount, ')
          ..write('status: $status, ')
          ..write('payload: $payload, ')
          ..write('previousHash: $previousHash, ')
          ..write('currentHash: $currentHash, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StoreConfigsTable storeConfigs = $StoreConfigsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $InvoiceItemsTable invoiceItems = $InvoiceItemsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  late final $CreditNotesTable creditNotes = $CreditNotesTable(this);
  late final $CreditNoteItemsTable creditNoteItems = $CreditNoteItemsTable(
    this,
  );
  late final $CancellationRequestsTable cancellationRequests =
      $CancellationRequestsTable(this);
  late final $DailyReportsTable dailyReports = $DailyReportsTable(this);
  late final StoreConfigDao storeConfigDao = StoreConfigDao(
    this as AppDatabase,
  );
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  late final CategoriesDao categoriesDao = CategoriesDao(this as AppDatabase);
  late final ProductsDao productsDao = ProductsDao(this as AppDatabase);
  late final InvoicesDao invoicesDao = InvoicesDao(this as AppDatabase);
  late final SyncQueueDao syncQueueDao = SyncQueueDao(this as AppDatabase);
  late final AuditDao auditDao = AuditDao(this as AppDatabase);
  late final TransactionDao transactionDao = TransactionDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    storeConfigs,
    users,
    categories,
    products,
    invoices,
    invoiceItems,
    payments,
    syncQueue,
    auditLogs,
    creditNotes,
    creditNoteItems,
    cancellationRequests,
    dailyReports,
  ];
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
  required String username,
  required String fullName,
  required String role,
  required String passwordHash,
  Value<String?> passwordSalt,
  Value<int?> passwordIterations,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String> username,
  Value<String> fullName,
  Value<String> role,
  Value<String> passwordHash,
  Value<String?> passwordSalt,
  Value<int?> passwordIterations,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: 'users__id__invoices__cashier_id',
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.cashierId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CreditNotesTable, List<CreditNote>>
  _creditNotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.creditNotes,
    aliasName: 'users__id__credit_notes__manager_id',
  );

  $$CreditNotesTableProcessedTableManager get creditNotesRefs {
    final manager = $$CreditNotesTableTableManager(
      $_db,
      $_db.creditNotes,
    ).filter((f) => f.managerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_creditNotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CancellationRequestsTable,
    List<CancellationRequest>
  >
  _cancellationRequestsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cancellationRequests,
        aliasName: 'users__id__cancellation_requests__manager_id',
      );

  $$CancellationRequestsTableProcessedTableManager
  get cancellationRequestsRefs {
    final manager = $$CancellationRequestsTableTableManager(
      $_db,
      $_db.cancellationRequests,
    ).filter((f) => f.managerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cancellationRequestsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DailyReportsTable, List<DailyReport>>
  _dailyReportsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dailyReports,
    aliasName: 'users__id__daily_reports__manager_id',
  );

  $$DailyReportsTableProcessedTableManager get dailyReportsRefs {
    final manager = $$DailyReportsTableTableManager(
      $_db,
      $_db.dailyReports,
    ).filter((f) => f.managerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyReportsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get passwordIterations => $composableBuilder(
    column: $table.passwordIterations,
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

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.cashierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> creditNotesRefs(
    Expression<bool> Function($$CreditNotesTableFilterComposer f) f,
  ) {
    final $$CreditNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditNotes,
      getReferencedColumn: (t) => t.managerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNotesTableFilterComposer(
            $db: $db,
            $table: $db.creditNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cancellationRequestsRefs(
    Expression<bool> Function($$CancellationRequestsTableFilterComposer f) f,
  ) {
    final $$CancellationRequestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cancellationRequests,
      getReferencedColumn: (t) => t.managerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CancellationRequestsTableFilterComposer(
            $db: $db,
            $table: $db.cancellationRequests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> dailyReportsRefs(
    Expression<bool> Function($$DailyReportsTableFilterComposer f) f,
  ) {
    final $$DailyReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyReports,
      getReferencedColumn: (t) => t.managerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyReportsTableFilterComposer(
            $db: $db,
            $table: $db.dailyReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get passwordIterations => $composableBuilder(
    column: $table.passwordIterations,
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

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get passwordIterations => $composableBuilder(
    column: $table.passwordIterations,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.cashierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> creditNotesRefs<T extends Object>(
    Expression<T> Function($$CreditNotesTableAnnotationComposer a) f,
  ) {
    final $$CreditNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditNotes,
      getReferencedColumn: (t) => t.managerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.creditNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cancellationRequestsRefs<T extends Object>(
    Expression<T> Function($$CancellationRequestsTableAnnotationComposer a) f,
  ) {
    final $$CancellationRequestsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.cancellationRequests,
          getReferencedColumn: (t) => t.managerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CancellationRequestsTableAnnotationComposer(
                $db: $db,
                $table: $db.cancellationRequests,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> dailyReportsRefs<T extends Object>(
    Expression<T> Function($$DailyReportsTableAnnotationComposer a) f,
  ) {
    final $$DailyReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyReports,
      getReferencedColumn: (t) => t.managerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({
            bool invoicesRefs,
            bool creditNotesRefs,
            bool cancellationRequestsRefs,
            bool dailyReportsRefs,
          })
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
                Value<String> username = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String?> passwordSalt = const Value.absent(),
                Value<int?> passwordIterations = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                fullName: fullName,
                role: role,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
                passwordIterations: passwordIterations,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String username,
                required String fullName,
                required String role,
                required String passwordHash,
                Value<String?> passwordSalt = const Value.absent(),
                Value<int?> passwordIterations = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                fullName: fullName,
                role: role,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
                passwordIterations: passwordIterations,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, User>(table),
                  $$UsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                invoicesRefs = false,
                creditNotesRefs = false,
                cancellationRequestsRefs = false,
                dailyReportsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoicesRefs) db.invoices,
                    if (creditNotesRefs) db.creditNotes,
                    if (cancellationRequestsRefs) db.cancellationRequests,
                    if (dailyReportsRefs) db.dailyReports,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoicesRefs)
                        await $_getPrefetchedData<User, $UsersTable, Invoice>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cashierId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (creditNotesRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          CreditNote
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._creditNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).creditNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.managerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (cancellationRequestsRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          CancellationRequest
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._cancellationRequestsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).cancellationRequestsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.managerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (dailyReportsRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          DailyReport
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._dailyReportsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).dailyReportsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.managerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
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
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({
        bool invoicesRefs,
        bool creditNotesRefs,
        bool cancellationRequestsRefs,
        bool dailyReportsRefs,
      })
    >;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  required String name,
  Value<String?> description,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
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

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
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

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
          Category,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                description: description,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                description: description,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, Category>(table),
                  BaseReferences<_$AppDatabase, $CategoriesTable, Category>(
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

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
      Category,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  required String id,
  required String categoryId,
  required String name,
  Value<String?> description,
  required String barcode,
  required double price,
  Value<double?> cost,
  Value<double> stockQuantity,
  required String unit,
  Value<double> vatRate,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<String> id,
  Value<String> categoryId,
  Value<String> name,
  Value<String?> description,
  Value<String> barcode,
  Value<double> price,
  Value<double?> cost,
  Value<double> stockQuantity,
  Value<String> unit,
  Value<double> vatRate,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
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

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
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

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vatRate => $composableBuilder(
    column: $table.vatRate,
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

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
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

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
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

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vatRate => $composableBuilder(
    column: $table.vatRate,
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

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<double> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get vatRate =>
      $composableBuilder(column: $table.vatRate, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
          Product,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> barcode = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double?> cost = const Value.absent(),
                Value<double> stockQuantity = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double> vatRate = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
                barcode: barcode,
                price: price,
                cost: cost,
                stockQuantity: stockQuantity,
                unit: unit,
                vatRate: vatRate,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String categoryId,
                required String name,
                Value<String?> description = const Value.absent(),
                required String barcode,
                required double price,
                Value<double?> cost = const Value.absent(),
                Value<double> stockQuantity = const Value.absent(),
                required String unit,
                Value<double> vatRate = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
                barcode: barcode,
                price: price,
                cost: cost,
                stockQuantity: stockQuantity,
                unit: unit,
                vatRate: vatRate,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductsTable, Product>(table),
                  BaseReferences<_$AppDatabase, $ProductsTable, Product>(
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

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
      Product,
      PrefetchHooks Function()
    >;
typedef $$InvoicesTableCreateCompanionBuilder = InvoicesCompanion Function({
  Value<int> id,
  required int invoiceNumber,
  required String cashierId,
  Value<String?> buyerTin,
  required double netTotal,
  required double vatTotal,
  required double grossTotal,
  Value<String> status,
  required String payload,
  required String previousHash,
  required String currentHash,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$InvoicesTableUpdateCompanionBuilder = InvoicesCompanion Function({
  Value<int> id,
  Value<int> invoiceNumber,
  Value<String> cashierId,
  Value<String?> buyerTin,
  Value<double> netTotal,
  Value<double> vatTotal,
  Value<double> grossTotal,
  Value<String> status,
  Value<String> payload,
  Value<String> previousHash,
  Value<String> currentHash,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _cashierIdTable(_$AppDatabase db) =>
      db.users.createAlias('invoices__cashier_id__users__id');

  $$UsersTableProcessedTableManager get cashierId {
    final $_column = $_itemColumn<String>('cashier_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cashierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InvoiceItemsTable, List<InvoiceItem>>
  _invoiceItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceItems,
    aliasName: 'invoices__id__invoice_items__invoice_id',
  );

  $$InvoiceItemsTableProcessedTableManager get invoiceItemsRefs {
    final manager = $$InvoiceItemsTableTableManager(
      $_db,
      $_db.invoiceItems,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoiceItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: 'invoices__id__payments__invoice_id',
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SyncQueueTable, List<SyncQueueData>>
  _syncQueueRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.syncQueue,
    aliasName: 'invoices__id__sync_queue__invoice_id',
  );

  $$SyncQueueTableProcessedTableManager get syncQueueRefs {
    final manager = $$SyncQueueTableTableManager(
      $_db,
      $_db.syncQueue,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncQueueRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AuditLogsTable, List<AuditLog>>
  _auditLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.auditLogs,
    aliasName: 'invoices__id__audit_logs__invoice_id',
  );

  $$AuditLogsTableProcessedTableManager get auditLogsRefs {
    final manager = $$AuditLogsTableTableManager(
      $_db,
      $_db.auditLogs,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_auditLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CreditNotesTable, List<CreditNote>>
  _creditNotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.creditNotes,
    aliasName: 'invoices__id__credit_notes__invoice_id',
  );

  $$CreditNotesTableProcessedTableManager get creditNotesRefs {
    final manager = $$CreditNotesTableTableManager(
      $_db,
      $_db.creditNotes,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_creditNotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CancellationRequestsTable,
    List<CancellationRequest>
  >
  _cancellationRequestsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cancellationRequests,
        aliasName: 'invoices__id__cancellation_requests__invoice_id',
      );

  $$CancellationRequestsTableProcessedTableManager
  get cancellationRequestsRefs {
    final manager = $$CancellationRequestsTableTableManager(
      $_db,
      $_db.cancellationRequests,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cancellationRequestsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
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

  ColumnFilters<int> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get buyerTin => $composableBuilder(
    column: $table.buyerTin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get netTotal => $composableBuilder(
    column: $table.netTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vatTotal => $composableBuilder(
    column: $table.vatTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grossTotal => $composableBuilder(
    column: $table.grossTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
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

  $$UsersTableFilterComposer get cashierId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cashierId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoiceItemsRefs(
    Expression<bool> Function($$InvoiceItemsTableFilterComposer f) f,
  ) {
    final $$InvoiceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableFilterComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> syncQueueRefs(
    Expression<bool> Function($$SyncQueueTableFilterComposer f) f,
  ) {
    final $$SyncQueueTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncQueue,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncQueueTableFilterComposer(
            $db: $db,
            $table: $db.syncQueue,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> auditLogsRefs(
    Expression<bool> Function($$AuditLogsTableFilterComposer f) f,
  ) {
    final $$AuditLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.auditLogs,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuditLogsTableFilterComposer(
            $db: $db,
            $table: $db.auditLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> creditNotesRefs(
    Expression<bool> Function($$CreditNotesTableFilterComposer f) f,
  ) {
    final $$CreditNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditNotes,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNotesTableFilterComposer(
            $db: $db,
            $table: $db.creditNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cancellationRequestsRefs(
    Expression<bool> Function($$CancellationRequestsTableFilterComposer f) f,
  ) {
    final $$CancellationRequestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cancellationRequests,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CancellationRequestsTableFilterComposer(
            $db: $db,
            $table: $db.cancellationRequests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
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

  ColumnOrderings<int> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get buyerTin => $composableBuilder(
    column: $table.buyerTin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get netTotal => $composableBuilder(
    column: $table.netTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vatTotal => $composableBuilder(
    column: $table.vatTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grossTotal => $composableBuilder(
    column: $table.grossTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
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

  $$UsersTableOrderingComposer get cashierId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cashierId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get buyerTin =>
      $composableBuilder(column: $table.buyerTin, builder: (column) => column);

  GeneratedColumn<double> get netTotal =>
      $composableBuilder(column: $table.netTotal, builder: (column) => column);

  GeneratedColumn<double> get vatTotal =>
      $composableBuilder(column: $table.vatTotal, builder: (column) => column);

  GeneratedColumn<double> get grossTotal => $composableBuilder(
    column: $table.grossTotal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get cashierId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cashierId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoiceItemsRefs<T extends Object>(
    Expression<T> Function($$InvoiceItemsTableAnnotationComposer a) f,
  ) {
    final $$InvoiceItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> syncQueueRefs<T extends Object>(
    Expression<T> Function($$SyncQueueTableAnnotationComposer a) f,
  ) {
    final $$SyncQueueTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncQueue,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SyncQueueTableAnnotationComposer(
            $db: $db,
            $table: $db.syncQueue,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> auditLogsRefs<T extends Object>(
    Expression<T> Function($$AuditLogsTableAnnotationComposer a) f,
  ) {
    final $$AuditLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.auditLogs,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AuditLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.auditLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> creditNotesRefs<T extends Object>(
    Expression<T> Function($$CreditNotesTableAnnotationComposer a) f,
  ) {
    final $$CreditNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditNotes,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.creditNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cancellationRequestsRefs<T extends Object>(
    Expression<T> Function($$CancellationRequestsTableAnnotationComposer a) f,
  ) {
    final $$CancellationRequestsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.cancellationRequests,
          getReferencedColumn: (t) => t.invoiceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CancellationRequestsTableAnnotationComposer(
                $db: $db,
                $table: $db.cancellationRequests,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          Invoice,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (Invoice, $$InvoicesTableReferences),
          Invoice,
          PrefetchHooks Function({
            bool cashierId,
            bool invoiceItemsRefs,
            bool paymentsRefs,
            bool syncQueueRefs,
            bool auditLogsRefs,
            bool creditNotesRefs,
            bool cancellationRequestsRefs,
          })
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceNumber = const Value.absent(),
                Value<String> cashierId = const Value.absent(),
                Value<String?> buyerTin = const Value.absent(),
                Value<double> netTotal = const Value.absent(),
                Value<double> vatTotal = const Value.absent(),
                Value<double> grossTotal = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String> previousHash = const Value.absent(),
                Value<String> currentHash = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                invoiceNumber: invoiceNumber,
                cashierId: cashierId,
                buyerTin: buyerTin,
                netTotal: netTotal,
                vatTotal: vatTotal,
                grossTotal: grossTotal,
                status: status,
                payload: payload,
                previousHash: previousHash,
                currentHash: currentHash,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceNumber,
                required String cashierId,
                Value<String?> buyerTin = const Value.absent(),
                required double netTotal,
                required double vatTotal,
                required double grossTotal,
                Value<String> status = const Value.absent(),
                required String payload,
                required String previousHash,
                required String currentHash,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                invoiceNumber: invoiceNumber,
                cashierId: cashierId,
                buyerTin: buyerTin,
                netTotal: netTotal,
                vatTotal: vatTotal,
                grossTotal: grossTotal,
                status: status,
                payload: payload,
                previousHash: previousHash,
                currentHash: currentHash,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InvoicesTable, Invoice>(table),
                  $$InvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                cashierId = false,
                invoiceItemsRefs = false,
                paymentsRefs = false,
                syncQueueRefs = false,
                auditLogsRefs = false,
                creditNotesRefs = false,
                cancellationRequestsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoiceItemsRefs) db.invoiceItems,
                    if (paymentsRefs) db.payments,
                    if (syncQueueRefs) db.syncQueue,
                    if (auditLogsRefs) db.auditLogs,
                    if (creditNotesRefs) db.creditNotes,
                    if (cancellationRequestsRefs) db.cancellationRequests,
                  ],
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
                        if (cashierId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.cashierId,
                            referencedTable: $$InvoicesTableReferences
                                ._cashierIdTable(db),
                            referencedColumn: $$InvoicesTableReferences
                                ._cashierIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoiceItemsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          InvoiceItem
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._invoiceItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          Payment
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (syncQueueRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          SyncQueueData
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._syncQueueRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).syncQueueRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (auditLogsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          AuditLog
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._auditLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).auditLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (creditNotesRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          CreditNote
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._creditNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).creditNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (cancellationRequestsRefs)
                        await $_getPrefetchedData<
                          Invoice,
                          $InvoicesTable,
                          CancellationRequest
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._cancellationRequestsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).cancellationRequestsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      Invoice,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (Invoice, $$InvoicesTableReferences),
      Invoice,
      PrefetchHooks Function({
        bool cashierId,
        bool invoiceItemsRefs,
        bool paymentsRefs,
        bool syncQueueRefs,
        bool auditLogsRefs,
        bool creditNotesRefs,
        bool cancellationRequestsRefs,
      })
    >;
typedef $$InvoiceItemsTableCreateCompanionBuilder =
    InvoiceItemsCompanion Function({
      Value<int> id,
      required int invoiceId,
      required String productId,
      required String productName,
      required double unitPrice,
      Value<int> quantity,
      Value<double> vatRate,
      required double netAmount,
      required double vatAmount,
      required double grossAmount,
    });
typedef $$InvoiceItemsTableUpdateCompanionBuilder =
    InvoiceItemsCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<String> productId,
      Value<String> productName,
      Value<double> unitPrice,
      Value<int> quantity,
      Value<double> vatRate,
      Value<double> netAmount,
      Value<double> vatAmount,
      Value<double> grossAmount,
    });

final class $$InvoiceItemsTableReferences
    extends BaseReferences<_$AppDatabase, $InvoiceItemsTable, InvoiceItem> {
  $$InvoiceItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('invoice_items__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CreditNoteItemsTable, List<CreditNoteItem>>
  _creditNoteItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.creditNoteItems,
    aliasName: 'invoice_items__id__credit_note_items__invoice_item_id',
  );

  $$CreditNoteItemsTableProcessedTableManager get creditNoteItemsRefs {
    final manager = $$CreditNoteItemsTableTableManager(
      $_db,
      $_db.creditNoteItems,
    ).filter((f) => f.invoiceItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _creditNoteItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvoiceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableFilterComposer({
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

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vatRate => $composableBuilder(
    column: $table.vatRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get netAmount => $composableBuilder(
    column: $table.netAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vatAmount => $composableBuilder(
    column: $table.vatAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grossAmount => $composableBuilder(
    column: $table.grossAmount,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> creditNoteItemsRefs(
    Expression<bool> Function($$CreditNoteItemsTableFilterComposer f) f,
  ) {
    final $$CreditNoteItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditNoteItems,
      getReferencedColumn: (t) => t.invoiceItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNoteItemsTableFilterComposer(
            $db: $db,
            $table: $db.creditNoteItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoiceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableOrderingComposer({
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

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vatRate => $composableBuilder(
    column: $table.vatRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get netAmount => $composableBuilder(
    column: $table.netAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vatAmount => $composableBuilder(
    column: $table.vatAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grossAmount => $composableBuilder(
    column: $table.grossAmount,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get vatRate =>
      $composableBuilder(column: $table.vatRate, builder: (column) => column);

  GeneratedColumn<double> get netAmount =>
      $composableBuilder(column: $table.netAmount, builder: (column) => column);

  GeneratedColumn<double> get vatAmount =>
      $composableBuilder(column: $table.vatAmount, builder: (column) => column);

  GeneratedColumn<double> get grossAmount => $composableBuilder(
    column: $table.grossAmount,
    builder: (column) => column,
  );

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> creditNoteItemsRefs<T extends Object>(
    Expression<T> Function($$CreditNoteItemsTableAnnotationComposer a) f,
  ) {
    final $$CreditNoteItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditNoteItems,
      getReferencedColumn: (t) => t.invoiceItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNoteItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.creditNoteItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoiceItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceItemsTable,
          InvoiceItem,
          $$InvoiceItemsTableFilterComposer,
          $$InvoiceItemsTableOrderingComposer,
          $$InvoiceItemsTableAnnotationComposer,
          $$InvoiceItemsTableCreateCompanionBuilder,
          $$InvoiceItemsTableUpdateCompanionBuilder,
          (InvoiceItem, $$InvoiceItemsTableReferences),
          InvoiceItem,
          PrefetchHooks Function({bool invoiceId, bool creditNoteItemsRefs})
        > {
  $$InvoiceItemsTableTableManager(_$AppDatabase db, $InvoiceItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> vatRate = const Value.absent(),
                Value<double> netAmount = const Value.absent(),
                Value<double> vatAmount = const Value.absent(),
                Value<double> grossAmount = const Value.absent(),
              }) => InvoiceItemsCompanion(
                id: id,
                invoiceId: invoiceId,
                productId: productId,
                productName: productName,
                unitPrice: unitPrice,
                quantity: quantity,
                vatRate: vatRate,
                netAmount: netAmount,
                vatAmount: vatAmount,
                grossAmount: grossAmount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                required String productId,
                required String productName,
                required double unitPrice,
                Value<int> quantity = const Value.absent(),
                Value<double> vatRate = const Value.absent(),
                required double netAmount,
                required double vatAmount,
                required double grossAmount,
              }) => InvoiceItemsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                productId: productId,
                productName: productName,
                unitPrice: unitPrice,
                quantity: quantity,
                vatRate: vatRate,
                netAmount: netAmount,
                vatAmount: vatAmount,
                grossAmount: grossAmount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InvoiceItemsTable, InvoiceItem>(table),
                  $$InvoiceItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({invoiceId = false, creditNoteItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (creditNoteItemsRefs) db.creditNoteItems,
                  ],
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
                        if (invoiceId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.invoiceId,
                            referencedTable: $$InvoiceItemsTableReferences
                                ._invoiceIdTable(db),
                            referencedColumn: $$InvoiceItemsTableReferences
                                ._invoiceIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (creditNoteItemsRefs)
                        await $_getPrefetchedData<
                          InvoiceItem,
                          $InvoiceItemsTable,
                          CreditNoteItem
                        >(
                          currentTable: table,
                          referencedTable: $$InvoiceItemsTableReferences
                              ._creditNoteItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoiceItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).creditNoteItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InvoiceItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceItemsTable,
      InvoiceItem,
      $$InvoiceItemsTableFilterComposer,
      $$InvoiceItemsTableOrderingComposer,
      $$InvoiceItemsTableAnnotationComposer,
      $$InvoiceItemsTableCreateCompanionBuilder,
      $$InvoiceItemsTableUpdateCompanionBuilder,
      (InvoiceItem, $$InvoiceItemsTableReferences),
      InvoiceItem,
      PrefetchHooks Function({bool invoiceId, bool creditNoteItemsRefs})
    >;
typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  required int invoiceId,
  required String method,
  required double amount,
  Value<double?> cashTendered,
  Value<String?> referenceCode,
  Value<DateTime> createdAt,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  Value<int> invoiceId,
  Value<String> method,
  Value<double> amount,
  Value<double?> cashTendered,
  Value<String?> referenceCode,
  Value<DateTime> createdAt,
});

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('payments__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
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

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cashTendered => $composableBuilder(
    column: $table.cashTendered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceCode => $composableBuilder(
    column: $table.referenceCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
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

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cashTendered => $composableBuilder(
    column: $table.cashTendered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceCode => $composableBuilder(
    column: $table.referenceCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get cashTendered => $composableBuilder(
    column: $table.cashTendered,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceCode => $composableBuilder(
    column: $table.referenceCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          Payment,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (Payment, $$PaymentsTableReferences),
          Payment,
          PrefetchHooks Function({bool invoiceId})
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<double?> cashTendered = const Value.absent(),
                Value<String?> referenceCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                invoiceId: invoiceId,
                method: method,
                amount: amount,
                cashTendered: cashTendered,
                referenceCode: referenceCode,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                required String method,
                required double amount,
                Value<double?> cashTendered = const Value.absent(),
                Value<String?> referenceCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                method: method,
                amount: amount,
                cashTendered: cashTendered,
                referenceCode: referenceCode,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PaymentsTable, Payment>(table),
                  $$PaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false}) {
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
                    if (invoiceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.invoiceId,
                        referencedTable: $$PaymentsTableReferences
                            ._invoiceIdTable(db),
                        referencedColumn: $$PaymentsTableReferences
                            ._invoiceIdTable(db)
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

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      Payment,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (Payment, $$PaymentsTableReferences),
      Payment,
      PrefetchHooks Function({bool invoiceId})
    >;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  required int invoiceId,
  required String operation,
  Value<String> status,
  required String payload,
  Value<int> retryCount,
  Value<String?> lastError,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> lastAttemptAt,
  Value<DateTime?> syncedAt,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<int> invoiceId,
  Value<String> operation,
  Value<String> status,
  Value<String> payload,
  Value<int> retryCount,
  Value<String?> lastError,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> lastAttemptAt,
  Value<DateTime?> syncedAt,
});

final class $$SyncQueueTableReferences
    extends BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData> {
  $$SyncQueueTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('sync_queue__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
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

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
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

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
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

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
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

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (SyncQueueData, $$SyncQueueTableReferences),
          SyncQueueData,
          PrefetchHooks Function({bool invoiceId})
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                invoiceId: invoiceId,
                operation: operation,
                status: status,
                payload: payload,
                retryCount: retryCount,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastAttemptAt: lastAttemptAt,
                syncedAt: syncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                required String operation,
                Value<String> status = const Value.absent(),
                required String payload,
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                operation: operation,
                status: status,
                payload: payload,
                retryCount: retryCount,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
                lastAttemptAt: lastAttemptAt,
                syncedAt: syncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncQueueTable, SyncQueueData>(table),
                  $$SyncQueueTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false}) {
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
                    if (invoiceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.invoiceId,
                        referencedTable: $$SyncQueueTableReferences
                            ._invoiceIdTable(db),
                        referencedColumn: $$SyncQueueTableReferences
                            ._invoiceIdTable(db)
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

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (SyncQueueData, $$SyncQueueTableReferences),
      SyncQueueData,
      PrefetchHooks Function({bool invoiceId})
    >;
typedef $$AuditLogsTableCreateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  required String action,
  Value<int?> invoiceId,
  required String userId,
  required String details,
  Value<String?> payload,
  required String previousHash,
  required String currentHash,
  Value<DateTime> createdAt,
});
typedef $$AuditLogsTableUpdateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  Value<String> action,
  Value<int?> invoiceId,
  Value<String> userId,
  Value<String> details,
  Value<String?> payload,
  Value<String> previousHash,
  Value<String> currentHash,
  Value<DateTime> createdAt,
});

final class $$AuditLogsTableReferences
    extends BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog> {
  $$AuditLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('audit_logs__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager? get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id');
    if ($_column == null) return null;
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
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

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
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

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLog,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (AuditLog, $$AuditLogsTableReferences),
          AuditLog,
          PrefetchHooks Function({bool invoiceId})
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<int?> invoiceId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> details = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<String> previousHash = const Value.absent(),
                Value<String> currentHash = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                action: action,
                invoiceId: invoiceId,
                userId: userId,
                details: details,
                payload: payload,
                previousHash: previousHash,
                currentHash: currentHash,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String action,
                Value<int?> invoiceId = const Value.absent(),
                required String userId,
                required String details,
                Value<String?> payload = const Value.absent(),
                required String previousHash,
                required String currentHash,
                Value<DateTime> createdAt = const Value.absent(),
              }) => AuditLogsCompanion.insert(
                id: id,
                action: action,
                invoiceId: invoiceId,
                userId: userId,
                details: details,
                payload: payload,
                previousHash: previousHash,
                currentHash: currentHash,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AuditLogsTable, AuditLog>(table),
                  $$AuditLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false}) {
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
                    if (invoiceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.invoiceId,
                        referencedTable: $$AuditLogsTableReferences
                            ._invoiceIdTable(db),
                        referencedColumn: $$AuditLogsTableReferences
                            ._invoiceIdTable(db)
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

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLog,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (AuditLog, $$AuditLogsTableReferences),
      AuditLog,
      PrefetchHooks Function({bool invoiceId})
    >;
typedef $$CreditNotesTableCreateCompanionBuilder =
    CreditNotesCompanion Function({
      Value<int> id,
      required int creditNoteNumber,
      required int invoiceId,
      required String managerId,
      required String reason,
      Value<String> status,
      required double netTotal,
      required double vatTotal,
      required double grossTotal,
      required String payload,
      required String previousHash,
      required String currentHash,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$CreditNotesTableUpdateCompanionBuilder =
    CreditNotesCompanion Function({
      Value<int> id,
      Value<int> creditNoteNumber,
      Value<int> invoiceId,
      Value<String> managerId,
      Value<String> reason,
      Value<String> status,
      Value<double> netTotal,
      Value<double> vatTotal,
      Value<double> grossTotal,
      Value<String> payload,
      Value<String> previousHash,
      Value<String> currentHash,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

final class $$CreditNotesTableReferences
    extends BaseReferences<_$AppDatabase, $CreditNotesTable, CreditNote> {
  $$CreditNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('credit_notes__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _managerIdTable(_$AppDatabase db) =>
      db.users.createAlias('credit_notes__manager_id__users__id');

  $$UsersTableProcessedTableManager get managerId {
    final $_column = $_itemColumn<String>('manager_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_managerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CreditNoteItemsTable, List<CreditNoteItem>>
  _creditNoteItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.creditNoteItems,
    aliasName: 'credit_notes__id__credit_note_items__credit_note_id',
  );

  $$CreditNoteItemsTableProcessedTableManager get creditNoteItemsRefs {
    final manager = $$CreditNoteItemsTableTableManager(
      $_db,
      $_db.creditNoteItems,
    ).filter((f) => f.creditNoteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _creditNoteItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CreditNotesTableFilterComposer
    extends Composer<_$AppDatabase, $CreditNotesTable> {
  $$CreditNotesTableFilterComposer({
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

  ColumnFilters<int> get creditNoteNumber => $composableBuilder(
    column: $table.creditNoteNumber,
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

  ColumnFilters<double> get netTotal => $composableBuilder(
    column: $table.netTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vatTotal => $composableBuilder(
    column: $table.vatTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grossTotal => $composableBuilder(
    column: $table.grossTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
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

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get managerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> creditNoteItemsRefs(
    Expression<bool> Function($$CreditNoteItemsTableFilterComposer f) f,
  ) {
    final $$CreditNoteItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditNoteItems,
      getReferencedColumn: (t) => t.creditNoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNoteItemsTableFilterComposer(
            $db: $db,
            $table: $db.creditNoteItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditNotesTable> {
  $$CreditNotesTableOrderingComposer({
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

  ColumnOrderings<int> get creditNoteNumber => $composableBuilder(
    column: $table.creditNoteNumber,
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

  ColumnOrderings<double> get netTotal => $composableBuilder(
    column: $table.netTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vatTotal => $composableBuilder(
    column: $table.vatTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grossTotal => $composableBuilder(
    column: $table.grossTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
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

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get managerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CreditNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditNotesTable> {
  $$CreditNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get creditNoteNumber => $composableBuilder(
    column: $table.creditNoteNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get netTotal =>
      $composableBuilder(column: $table.netTotal, builder: (column) => column);

  GeneratedColumn<double> get vatTotal =>
      $composableBuilder(column: $table.vatTotal, builder: (column) => column);

  GeneratedColumn<double> get grossTotal => $composableBuilder(
    column: $table.grossTotal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get managerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> creditNoteItemsRefs<T extends Object>(
    Expression<T> Function($$CreditNoteItemsTableAnnotationComposer a) f,
  ) {
    final $$CreditNoteItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.creditNoteItems,
      getReferencedColumn: (t) => t.creditNoteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNoteItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.creditNoteItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditNotesTable,
          CreditNote,
          $$CreditNotesTableFilterComposer,
          $$CreditNotesTableOrderingComposer,
          $$CreditNotesTableAnnotationComposer,
          $$CreditNotesTableCreateCompanionBuilder,
          $$CreditNotesTableUpdateCompanionBuilder,
          (CreditNote, $$CreditNotesTableReferences),
          CreditNote,
          PrefetchHooks Function({
            bool invoiceId,
            bool managerId,
            bool creditNoteItemsRefs,
          })
        > {
  $$CreditNotesTableTableManager(_$AppDatabase db, $CreditNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> creditNoteNumber = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<String> managerId = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double> netTotal = const Value.absent(),
                Value<double> vatTotal = const Value.absent(),
                Value<double> grossTotal = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String> previousHash = const Value.absent(),
                Value<String> currentHash = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => CreditNotesCompanion(
                id: id,
                creditNoteNumber: creditNoteNumber,
                invoiceId: invoiceId,
                managerId: managerId,
                reason: reason,
                status: status,
                netTotal: netTotal,
                vatTotal: vatTotal,
                grossTotal: grossTotal,
                payload: payload,
                previousHash: previousHash,
                currentHash: currentHash,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int creditNoteNumber,
                required int invoiceId,
                required String managerId,
                required String reason,
                Value<String> status = const Value.absent(),
                required double netTotal,
                required double vatTotal,
                required double grossTotal,
                required String payload,
                required String previousHash,
                required String currentHash,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => CreditNotesCompanion.insert(
                id: id,
                creditNoteNumber: creditNoteNumber,
                invoiceId: invoiceId,
                managerId: managerId,
                reason: reason,
                status: status,
                netTotal: netTotal,
                vatTotal: vatTotal,
                grossTotal: grossTotal,
                payload: payload,
                previousHash: previousHash,
                currentHash: currentHash,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CreditNotesTable, CreditNote>(table),
                  $$CreditNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                invoiceId = false,
                managerId = false,
                creditNoteItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (creditNoteItemsRefs) db.creditNoteItems,
                  ],
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
                        if (invoiceId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.invoiceId,
                            referencedTable: $$CreditNotesTableReferences
                                ._invoiceIdTable(db),
                            referencedColumn: $$CreditNotesTableReferences
                                ._invoiceIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (managerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.managerId,
                            referencedTable: $$CreditNotesTableReferences
                                ._managerIdTable(db),
                            referencedColumn: $$CreditNotesTableReferences
                                ._managerIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (creditNoteItemsRefs)
                        await $_getPrefetchedData<
                          CreditNote,
                          $CreditNotesTable,
                          CreditNoteItem
                        >(
                          currentTable: table,
                          referencedTable: $$CreditNotesTableReferences
                              ._creditNoteItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CreditNotesTableReferences(
                                db,
                                table,
                                p0,
                              ).creditNoteItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.creditNoteId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CreditNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditNotesTable,
      CreditNote,
      $$CreditNotesTableFilterComposer,
      $$CreditNotesTableOrderingComposer,
      $$CreditNotesTableAnnotationComposer,
      $$CreditNotesTableCreateCompanionBuilder,
      $$CreditNotesTableUpdateCompanionBuilder,
      (CreditNote, $$CreditNotesTableReferences),
      CreditNote,
      PrefetchHooks Function({
        bool invoiceId,
        bool managerId,
        bool creditNoteItemsRefs,
      })
    >;
typedef $$CreditNoteItemsTableCreateCompanionBuilder =
    CreditNoteItemsCompanion Function({
      Value<int> id,
      required int creditNoteId,
      required int invoiceItemId,
      required double quantity,
      required double netAmount,
      required double vatAmount,
      required double grossAmount,
    });
typedef $$CreditNoteItemsTableUpdateCompanionBuilder =
    CreditNoteItemsCompanion Function({
      Value<int> id,
      Value<int> creditNoteId,
      Value<int> invoiceItemId,
      Value<double> quantity,
      Value<double> netAmount,
      Value<double> vatAmount,
      Value<double> grossAmount,
    });

final class $$CreditNoteItemsTableReferences
    extends
        BaseReferences<_$AppDatabase, $CreditNoteItemsTable, CreditNoteItem> {
  $$CreditNoteItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CreditNotesTable _creditNoteIdTable(_$AppDatabase db) => db
      .creditNotes
      .createAlias('credit_note_items__credit_note_id__credit_notes__id');

  $$CreditNotesTableProcessedTableManager get creditNoteId {
    final $_column = $_itemColumn<int>('credit_note_id')!;

    final manager = $$CreditNotesTableTableManager(
      $_db,
      $_db.creditNotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_creditNoteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InvoiceItemsTable _invoiceItemIdTable(_$AppDatabase db) => db
      .invoiceItems
      .createAlias('credit_note_items__invoice_item_id__invoice_items__id');

  $$InvoiceItemsTableProcessedTableManager get invoiceItemId {
    final $_column = $_itemColumn<int>('invoice_item_id')!;

    final manager = $$InvoiceItemsTableTableManager(
      $_db,
      $_db.invoiceItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CreditNoteItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CreditNoteItemsTable> {
  $$CreditNoteItemsTableFilterComposer({
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

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get netAmount => $composableBuilder(
    column: $table.netAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vatAmount => $composableBuilder(
    column: $table.vatAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grossAmount => $composableBuilder(
    column: $table.grossAmount,
    builder: (column) => ColumnFilters(column),
  );

  $$CreditNotesTableFilterComposer get creditNoteId {
    final $$CreditNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.creditNoteId,
      referencedTable: $db.creditNotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNotesTableFilterComposer(
            $db: $db,
            $table: $db.creditNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoiceItemsTableFilterComposer get invoiceItemId {
    final $$InvoiceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceItemId,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableFilterComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CreditNoteItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditNoteItemsTable> {
  $$CreditNoteItemsTableOrderingComposer({
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

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get netAmount => $composableBuilder(
    column: $table.netAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vatAmount => $composableBuilder(
    column: $table.vatAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grossAmount => $composableBuilder(
    column: $table.grossAmount,
    builder: (column) => ColumnOrderings(column),
  );

  $$CreditNotesTableOrderingComposer get creditNoteId {
    final $$CreditNotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.creditNoteId,
      referencedTable: $db.creditNotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNotesTableOrderingComposer(
            $db: $db,
            $table: $db.creditNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoiceItemsTableOrderingComposer get invoiceItemId {
    final $$InvoiceItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceItemId,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableOrderingComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CreditNoteItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditNoteItemsTable> {
  $$CreditNoteItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get netAmount =>
      $composableBuilder(column: $table.netAmount, builder: (column) => column);

  GeneratedColumn<double> get vatAmount =>
      $composableBuilder(column: $table.vatAmount, builder: (column) => column);

  GeneratedColumn<double> get grossAmount => $composableBuilder(
    column: $table.grossAmount,
    builder: (column) => column,
  );

  $$CreditNotesTableAnnotationComposer get creditNoteId {
    final $$CreditNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.creditNoteId,
      referencedTable: $db.creditNotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CreditNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.creditNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoiceItemsTableAnnotationComposer get invoiceItemId {
    final $$InvoiceItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceItemId,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CreditNoteItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditNoteItemsTable,
          CreditNoteItem,
          $$CreditNoteItemsTableFilterComposer,
          $$CreditNoteItemsTableOrderingComposer,
          $$CreditNoteItemsTableAnnotationComposer,
          $$CreditNoteItemsTableCreateCompanionBuilder,
          $$CreditNoteItemsTableUpdateCompanionBuilder,
          (CreditNoteItem, $$CreditNoteItemsTableReferences),
          CreditNoteItem,
          PrefetchHooks Function({bool creditNoteId, bool invoiceItemId})
        > {
  $$CreditNoteItemsTableTableManager(
    _$AppDatabase db,
    $CreditNoteItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditNoteItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditNoteItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditNoteItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> creditNoteId = const Value.absent(),
                Value<int> invoiceItemId = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> netAmount = const Value.absent(),
                Value<double> vatAmount = const Value.absent(),
                Value<double> grossAmount = const Value.absent(),
              }) => CreditNoteItemsCompanion(
                id: id,
                creditNoteId: creditNoteId,
                invoiceItemId: invoiceItemId,
                quantity: quantity,
                netAmount: netAmount,
                vatAmount: vatAmount,
                grossAmount: grossAmount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int creditNoteId,
                required int invoiceItemId,
                required double quantity,
                required double netAmount,
                required double vatAmount,
                required double grossAmount,
              }) => CreditNoteItemsCompanion.insert(
                id: id,
                creditNoteId: creditNoteId,
                invoiceItemId: invoiceItemId,
                quantity: quantity,
                netAmount: netAmount,
                vatAmount: vatAmount,
                grossAmount: grossAmount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CreditNoteItemsTable, CreditNoteItem>(table),
                  $$CreditNoteItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({creditNoteId = false, invoiceItemId = false}) {
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
                        if (creditNoteId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.creditNoteId,
                            referencedTable: $$CreditNoteItemsTableReferences
                                ._creditNoteIdTable(db),
                            referencedColumn: $$CreditNoteItemsTableReferences
                                ._creditNoteIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (invoiceItemId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.invoiceItemId,
                            referencedTable: $$CreditNoteItemsTableReferences
                                ._invoiceItemIdTable(db),
                            referencedColumn: $$CreditNoteItemsTableReferences
                                ._invoiceItemIdTable(db)
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

typedef $$CreditNoteItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditNoteItemsTable,
      CreditNoteItem,
      $$CreditNoteItemsTableFilterComposer,
      $$CreditNoteItemsTableOrderingComposer,
      $$CreditNoteItemsTableAnnotationComposer,
      $$CreditNoteItemsTableCreateCompanionBuilder,
      $$CreditNoteItemsTableUpdateCompanionBuilder,
      (CreditNoteItem, $$CreditNoteItemsTableReferences),
      CreditNoteItem,
      PrefetchHooks Function({bool creditNoteId, bool invoiceItemId})
    >;
typedef $$CancellationRequestsTableCreateCompanionBuilder =
    CancellationRequestsCompanion Function({
      Value<int> id,
      required int invoiceId,
      required String managerId,
      required String reason,
      Value<String> status,
      required String payload,
      required String previousHash,
      required String currentHash,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$CancellationRequestsTableUpdateCompanionBuilder =
    CancellationRequestsCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<String> managerId,
      Value<String> reason,
      Value<String> status,
      Value<String> payload,
      Value<String> previousHash,
      Value<String> currentHash,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

final class $$CancellationRequestsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CancellationRequestsTable,
          CancellationRequest
        > {
  $$CancellationRequestsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) => db.invoices
      .createAlias('cancellation_requests__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsersTable _managerIdTable(_$AppDatabase db) =>
      db.users.createAlias('cancellation_requests__manager_id__users__id');

  $$UsersTableProcessedTableManager get managerId {
    final $_column = $_itemColumn<String>('manager_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_managerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CancellationRequestsTableFilterComposer
    extends Composer<_$AppDatabase, $CancellationRequestsTable> {
  $$CancellationRequestsTableFilterComposer({
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

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
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

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get managerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CancellationRequestsTableOrderingComposer
    extends Composer<_$AppDatabase, $CancellationRequestsTable> {
  $$CancellationRequestsTableOrderingComposer({
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

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
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

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get managerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CancellationRequestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CancellationRequestsTable> {
  $$CancellationRequestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get managerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CancellationRequestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CancellationRequestsTable,
          CancellationRequest,
          $$CancellationRequestsTableFilterComposer,
          $$CancellationRequestsTableOrderingComposer,
          $$CancellationRequestsTableAnnotationComposer,
          $$CancellationRequestsTableCreateCompanionBuilder,
          $$CancellationRequestsTableUpdateCompanionBuilder,
          (CancellationRequest, $$CancellationRequestsTableReferences),
          CancellationRequest,
          PrefetchHooks Function({bool invoiceId, bool managerId})
        > {
  $$CancellationRequestsTableTableManager(
    _$AppDatabase db,
    $CancellationRequestsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CancellationRequestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CancellationRequestsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CancellationRequestsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<String> managerId = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String> previousHash = const Value.absent(),
                Value<String> currentHash = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => CancellationRequestsCompanion(
                id: id,
                invoiceId: invoiceId,
                managerId: managerId,
                reason: reason,
                status: status,
                payload: payload,
                previousHash: previousHash,
                currentHash: currentHash,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                required String managerId,
                required String reason,
                Value<String> status = const Value.absent(),
                required String payload,
                required String previousHash,
                required String currentHash,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => CancellationRequestsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                managerId: managerId,
                reason: reason,
                status: status,
                payload: payload,
                previousHash: previousHash,
                currentHash: currentHash,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CancellationRequestsTable, CancellationRequest>(
                    table,
                  ),
                  $$CancellationRequestsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false, managerId = false}) {
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
                    if (invoiceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.invoiceId,
                        referencedTable: $$CancellationRequestsTableReferences
                            ._invoiceIdTable(db),
                        referencedColumn: $$CancellationRequestsTableReferences
                            ._invoiceIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (managerId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.managerId,
                        referencedTable: $$CancellationRequestsTableReferences
                            ._managerIdTable(db),
                        referencedColumn: $$CancellationRequestsTableReferences
                            ._managerIdTable(db)
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

typedef $$CancellationRequestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CancellationRequestsTable,
      CancellationRequest,
      $$CancellationRequestsTableFilterComposer,
      $$CancellationRequestsTableOrderingComposer,
      $$CancellationRequestsTableAnnotationComposer,
      $$CancellationRequestsTableCreateCompanionBuilder,
      $$CancellationRequestsTableUpdateCompanionBuilder,
      (CancellationRequest, $$CancellationRequestsTableReferences),
      CancellationRequest,
      PrefetchHooks Function({bool invoiceId, bool managerId})
    >;
typedef $$DailyReportsTableCreateCompanionBuilder =
    DailyReportsCompanion Function({
      Value<int> id,
      required int zNumber,
      required String reportDate,
      required String managerId,
      required int invoiceCount,
      required double netTotal,
      required double vatTotal,
      required double grossTotal,
      required double creditNetTotal,
      required double creditVatTotal,
      required double creditGrossTotal,
      required double cashTotal,
      required double telebirrTotal,
      required double cbeBirrTotal,
      required double cashCount,
      Value<String> status,
      required String payload,
      required String previousHash,
      required String currentHash,
      Value<DateTime> createdAt,
    });
typedef $$DailyReportsTableUpdateCompanionBuilder =
    DailyReportsCompanion Function({
      Value<int> id,
      Value<int> zNumber,
      Value<String> reportDate,
      Value<String> managerId,
      Value<int> invoiceCount,
      Value<double> netTotal,
      Value<double> vatTotal,
      Value<double> grossTotal,
      Value<double> creditNetTotal,
      Value<double> creditVatTotal,
      Value<double> creditGrossTotal,
      Value<double> cashTotal,
      Value<double> telebirrTotal,
      Value<double> cbeBirrTotal,
      Value<double> cashCount,
      Value<String> status,
      Value<String> payload,
      Value<String> previousHash,
      Value<String> currentHash,
      Value<DateTime> createdAt,
    });

final class $$DailyReportsTableReferences
    extends BaseReferences<_$AppDatabase, $DailyReportsTable, DailyReport> {
  $$DailyReportsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _managerIdTable(_$AppDatabase db) =>
      db.users.createAlias('daily_reports__manager_id__users__id');

  $$UsersTableProcessedTableManager get managerId {
    final $_column = $_itemColumn<String>('manager_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_managerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DailyReportsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyReportsTable> {
  $$DailyReportsTableFilterComposer({
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

  ColumnFilters<int> get zNumber => $composableBuilder(
    column: $table.zNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportDate => $composableBuilder(
    column: $table.reportDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get invoiceCount => $composableBuilder(
    column: $table.invoiceCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get netTotal => $composableBuilder(
    column: $table.netTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vatTotal => $composableBuilder(
    column: $table.vatTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grossTotal => $composableBuilder(
    column: $table.grossTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creditNetTotal => $composableBuilder(
    column: $table.creditNetTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creditVatTotal => $composableBuilder(
    column: $table.creditVatTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creditGrossTotal => $composableBuilder(
    column: $table.creditGrossTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cashTotal => $composableBuilder(
    column: $table.cashTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get telebirrTotal => $composableBuilder(
    column: $table.telebirrTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cbeBirrTotal => $composableBuilder(
    column: $table.cbeBirrTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cashCount => $composableBuilder(
    column: $table.cashCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get managerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyReportsTable> {
  $$DailyReportsTableOrderingComposer({
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

  ColumnOrderings<int> get zNumber => $composableBuilder(
    column: $table.zNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportDate => $composableBuilder(
    column: $table.reportDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get invoiceCount => $composableBuilder(
    column: $table.invoiceCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get netTotal => $composableBuilder(
    column: $table.netTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vatTotal => $composableBuilder(
    column: $table.vatTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grossTotal => $composableBuilder(
    column: $table.grossTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creditNetTotal => $composableBuilder(
    column: $table.creditNetTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creditVatTotal => $composableBuilder(
    column: $table.creditVatTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creditGrossTotal => $composableBuilder(
    column: $table.creditGrossTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cashTotal => $composableBuilder(
    column: $table.cashTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get telebirrTotal => $composableBuilder(
    column: $table.telebirrTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cbeBirrTotal => $composableBuilder(
    column: $table.cbeBirrTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cashCount => $composableBuilder(
    column: $table.cashCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get managerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyReportsTable> {
  $$DailyReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get zNumber =>
      $composableBuilder(column: $table.zNumber, builder: (column) => column);

  GeneratedColumn<String> get reportDate => $composableBuilder(
    column: $table.reportDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get invoiceCount => $composableBuilder(
    column: $table.invoiceCount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get netTotal =>
      $composableBuilder(column: $table.netTotal, builder: (column) => column);

  GeneratedColumn<double> get vatTotal =>
      $composableBuilder(column: $table.vatTotal, builder: (column) => column);

  GeneratedColumn<double> get grossTotal => $composableBuilder(
    column: $table.grossTotal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get creditNetTotal => $composableBuilder(
    column: $table.creditNetTotal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get creditVatTotal => $composableBuilder(
    column: $table.creditVatTotal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get creditGrossTotal => $composableBuilder(
    column: $table.creditGrossTotal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cashTotal =>
      $composableBuilder(column: $table.cashTotal, builder: (column) => column);

  GeneratedColumn<double> get telebirrTotal => $composableBuilder(
    column: $table.telebirrTotal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cbeBirrTotal => $composableBuilder(
    column: $table.cbeBirrTotal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cashCount =>
      $composableBuilder(column: $table.cashCount, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get previousHash => $composableBuilder(
    column: $table.previousHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentHash => $composableBuilder(
    column: $table.currentHash,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get managerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.managerId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyReportsTable,
          DailyReport,
          $$DailyReportsTableFilterComposer,
          $$DailyReportsTableOrderingComposer,
          $$DailyReportsTableAnnotationComposer,
          $$DailyReportsTableCreateCompanionBuilder,
          $$DailyReportsTableUpdateCompanionBuilder,
          (DailyReport, $$DailyReportsTableReferences),
          DailyReport,
          PrefetchHooks Function({bool managerId})
        > {
  $$DailyReportsTableTableManager(_$AppDatabase db, $DailyReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> zNumber = const Value.absent(),
                Value<String> reportDate = const Value.absent(),
                Value<String> managerId = const Value.absent(),
                Value<int> invoiceCount = const Value.absent(),
                Value<double> netTotal = const Value.absent(),
                Value<double> vatTotal = const Value.absent(),
                Value<double> grossTotal = const Value.absent(),
                Value<double> creditNetTotal = const Value.absent(),
                Value<double> creditVatTotal = const Value.absent(),
                Value<double> creditGrossTotal = const Value.absent(),
                Value<double> cashTotal = const Value.absent(),
                Value<double> telebirrTotal = const Value.absent(),
                Value<double> cbeBirrTotal = const Value.absent(),
                Value<double> cashCount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String> previousHash = const Value.absent(),
                Value<String> currentHash = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DailyReportsCompanion(
                id: id,
                zNumber: zNumber,
                reportDate: reportDate,
                managerId: managerId,
                invoiceCount: invoiceCount,
                netTotal: netTotal,
                vatTotal: vatTotal,
                grossTotal: grossTotal,
                creditNetTotal: creditNetTotal,
                creditVatTotal: creditVatTotal,
                creditGrossTotal: creditGrossTotal,
                cashTotal: cashTotal,
                telebirrTotal: telebirrTotal,
                cbeBirrTotal: cbeBirrTotal,
                cashCount: cashCount,
                status: status,
                payload: payload,
                previousHash: previousHash,
                currentHash: currentHash,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int zNumber,
                required String reportDate,
                required String managerId,
                required int invoiceCount,
                required double netTotal,
                required double vatTotal,
                required double grossTotal,
                required double creditNetTotal,
                required double creditVatTotal,
                required double creditGrossTotal,
                required double cashTotal,
                required double telebirrTotal,
                required double cbeBirrTotal,
                required double cashCount,
                Value<String> status = const Value.absent(),
                required String payload,
                required String previousHash,
                required String currentHash,
                Value<DateTime> createdAt = const Value.absent(),
              }) => DailyReportsCompanion.insert(
                id: id,
                zNumber: zNumber,
                reportDate: reportDate,
                managerId: managerId,
                invoiceCount: invoiceCount,
                netTotal: netTotal,
                vatTotal: vatTotal,
                grossTotal: grossTotal,
                creditNetTotal: creditNetTotal,
                creditVatTotal: creditVatTotal,
                creditGrossTotal: creditGrossTotal,
                cashTotal: cashTotal,
                telebirrTotal: telebirrTotal,
                cbeBirrTotal: cbeBirrTotal,
                cashCount: cashCount,
                status: status,
                payload: payload,
                previousHash: previousHash,
                currentHash: currentHash,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyReportsTable, DailyReport>(table),
                  $$DailyReportsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({managerId = false}) {
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
                    if (managerId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.managerId,
                        referencedTable: $$DailyReportsTableReferences
                            ._managerIdTable(db),
                        referencedColumn: $$DailyReportsTableReferences
                            ._managerIdTable(db)
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

typedef $$DailyReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyReportsTable,
      DailyReport,
      $$DailyReportsTableFilterComposer,
      $$DailyReportsTableOrderingComposer,
      $$DailyReportsTableAnnotationComposer,
      $$DailyReportsTableCreateCompanionBuilder,
      $$DailyReportsTableUpdateCompanionBuilder,
      (DailyReport, $$DailyReportsTableReferences),
      DailyReport,
      PrefetchHooks Function({bool managerId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StoreConfigsTableTableManager get storeConfigs =>
      $$StoreConfigsTableTableManager(_db, _db.storeConfigs);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$InvoiceItemsTableTableManager get invoiceItems =>
      $$InvoiceItemsTableTableManager(_db, _db.invoiceItems);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
  $$CreditNotesTableTableManager get creditNotes =>
      $$CreditNotesTableTableManager(_db, _db.creditNotes);
  $$CreditNoteItemsTableTableManager get creditNoteItems =>
      $$CreditNoteItemsTableTableManager(_db, _db.creditNoteItems);
  $$CancellationRequestsTableTableManager get cancellationRequests =>
      $$CancellationRequestsTableTableManager(_db, _db.cancellationRequests);
  $$DailyReportsTableTableManager get dailyReports =>
      $$DailyReportsTableTableManager(_db, _db.dailyReports);
}
