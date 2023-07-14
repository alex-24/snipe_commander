// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Token extends DataClass implements Insertable<Token> {
  final String address;
  final String? name;
  final String? symbol;
  final String? decimals;
  final String? balance;
  final String? owner;
  Token(
      {required this.address,
      this.name,
      this.symbol,
      this.decimals,
      this.balance,
      this.owner});
  factory Token.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Token(
      address: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}address'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      symbol: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}symbol']),
      decimals: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}decimals']),
      balance: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}balance']),
      owner: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}owner']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['address'] = Variable<String>(address);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    if (!nullToAbsent || symbol != null) {
      map['symbol'] = Variable<String?>(symbol);
    }
    if (!nullToAbsent || decimals != null) {
      map['decimals'] = Variable<String?>(decimals);
    }
    if (!nullToAbsent || balance != null) {
      map['balance'] = Variable<String?>(balance);
    }
    if (!nullToAbsent || owner != null) {
      map['owner'] = Variable<String?>(owner);
    }
    return map;
  }

  TokenModelCompanion toCompanion(bool nullToAbsent) {
    return TokenModelCompanion(
      address: Value(address),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      symbol:
          symbol == null && nullToAbsent ? const Value.absent() : Value(symbol),
      decimals: decimals == null && nullToAbsent
          ? const Value.absent()
          : Value(decimals),
      balance: balance == null && nullToAbsent
          ? const Value.absent()
          : Value(balance),
      owner:
          owner == null && nullToAbsent ? const Value.absent() : Value(owner),
    );
  }

  factory Token.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Token(
      address: serializer.fromJson<String>(json['address']),
      name: serializer.fromJson<String?>(json['name']),
      symbol: serializer.fromJson<String?>(json['symbol']),
      decimals: serializer.fromJson<String?>(json['decimals']),
      balance: serializer.fromJson<String?>(json['balance']),
      owner: serializer.fromJson<String?>(json['owner']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'address': serializer.toJson<String>(address),
      'name': serializer.toJson<String?>(name),
      'symbol': serializer.toJson<String?>(symbol),
      'decimals': serializer.toJson<String?>(decimals),
      'balance': serializer.toJson<String?>(balance),
      'owner': serializer.toJson<String?>(owner),
    };
  }

  Token copyWith(
          {String? address,
          String? name,
          String? symbol,
          String? decimals,
          String? balance,
          String? owner}) =>
      Token(
        address: address ?? this.address,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        decimals: decimals ?? this.decimals,
        balance: balance ?? this.balance,
        owner: owner ?? this.owner,
      );
  @override
  String toString() {
    return (StringBuffer('Token(')
          ..write('address: $address, ')
          ..write('name: $name, ')
          ..write('symbol: $symbol, ')
          ..write('decimals: $decimals, ')
          ..write('balance: $balance, ')
          ..write('owner: $owner')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(address, name, symbol, decimals, balance, owner);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Token &&
          other.address == this.address &&
          other.name == this.name &&
          other.symbol == this.symbol &&
          other.decimals == this.decimals &&
          other.balance == this.balance &&
          other.owner == this.owner);
}

class TokenModelCompanion extends UpdateCompanion<Token> {
  final Value<String> address;
  final Value<String?> name;
  final Value<String?> symbol;
  final Value<String?> decimals;
  final Value<String?> balance;
  final Value<String?> owner;
  const TokenModelCompanion({
    this.address = const Value.absent(),
    this.name = const Value.absent(),
    this.symbol = const Value.absent(),
    this.decimals = const Value.absent(),
    this.balance = const Value.absent(),
    this.owner = const Value.absent(),
  });
  TokenModelCompanion.insert({
    required String address,
    this.name = const Value.absent(),
    this.symbol = const Value.absent(),
    this.decimals = const Value.absent(),
    this.balance = const Value.absent(),
    this.owner = const Value.absent(),
  }) : address = Value(address);
  static Insertable<Token> custom({
    Expression<String>? address,
    Expression<String?>? name,
    Expression<String?>? symbol,
    Expression<String?>? decimals,
    Expression<String?>? balance,
    Expression<String?>? owner,
  }) {
    return RawValuesInsertable({
      if (address != null) 'address': address,
      if (name != null) 'name': name,
      if (symbol != null) 'symbol': symbol,
      if (decimals != null) 'decimals': decimals,
      if (balance != null) 'balance': balance,
      if (owner != null) 'owner': owner,
    });
  }

  TokenModelCompanion copyWith(
      {Value<String>? address,
      Value<String?>? name,
      Value<String?>? symbol,
      Value<String?>? decimals,
      Value<String?>? balance,
      Value<String?>? owner}) {
    return TokenModelCompanion(
      address: address ?? this.address,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      decimals: decimals ?? this.decimals,
      balance: balance ?? this.balance,
      owner: owner ?? this.owner,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (symbol.present) {
      map['symbol'] = Variable<String?>(symbol.value);
    }
    if (decimals.present) {
      map['decimals'] = Variable<String?>(decimals.value);
    }
    if (balance.present) {
      map['balance'] = Variable<String?>(balance.value);
    }
    if (owner.present) {
      map['owner'] = Variable<String?>(owner.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TokenModelCompanion(')
          ..write('address: $address, ')
          ..write('name: $name, ')
          ..write('symbol: $symbol, ')
          ..write('decimals: $decimals, ')
          ..write('balance: $balance, ')
          ..write('owner: $owner')
          ..write(')'))
        .toString();
  }
}

class $TokenModelTable extends TokenModel
    with TableInfo<$TokenModelTable, Token> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TokenModelTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _addressMeta = const VerificationMeta('address');
  @override
  late final GeneratedColumn<String?> address = GeneratedColumn<String?>(
      'address', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: Constant(""));
  final VerificationMeta _symbolMeta = const VerificationMeta('symbol');
  @override
  late final GeneratedColumn<String?> symbol = GeneratedColumn<String?>(
      'symbol', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: Constant(""));
  final VerificationMeta _decimalsMeta = const VerificationMeta('decimals');
  @override
  late final GeneratedColumn<String?> decimals = GeneratedColumn<String?>(
      'decimals', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: Constant(""));
  final VerificationMeta _balanceMeta = const VerificationMeta('balance');
  @override
  late final GeneratedColumn<String?> balance = GeneratedColumn<String?>(
      'balance', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: Constant(""));
  final VerificationMeta _ownerMeta = const VerificationMeta('owner');
  @override
  late final GeneratedColumn<String?> owner = GeneratedColumn<String?>(
      'owner', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: Constant(""));
  @override
  List<GeneratedColumn> get $columns =>
      [address, name, symbol, decimals, balance, owner];
  @override
  String get aliasedName => _alias ?? 'token_model';
  @override
  String get actualTableName => 'token_model';
  @override
  VerificationContext validateIntegrity(Insertable<Token> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('symbol')) {
      context.handle(_symbolMeta,
          symbol.isAcceptableOrUnknown(data['symbol']!, _symbolMeta));
    }
    if (data.containsKey('decimals')) {
      context.handle(_decimalsMeta,
          decimals.isAcceptableOrUnknown(data['decimals']!, _decimalsMeta));
    }
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    }
    if (data.containsKey('owner')) {
      context.handle(
          _ownerMeta, owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {address};
  @override
  Token map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Token.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TokenModelTable createAlias(String alias) {
    return $TokenModelTable(attachedDatabase, alias);
  }
}

class Liquidity extends DataClass implements Insertable<Liquidity> {
  final int? id;
  final String tokenToBuyAddress;
  final String tokenToSpendAddress;
  final DateTime? dateCreated;
  Liquidity(
      {this.id,
      required this.tokenToBuyAddress,
      required this.tokenToSpendAddress,
      this.dateCreated});
  factory Liquidity.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Liquidity(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      tokenToBuyAddress: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}token_to_buy_address'])!,
      tokenToSpendAddress: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}token_to_spend_address'])!,
      dateCreated: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date_created']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    map['token_to_buy_address'] = Variable<String>(tokenToBuyAddress);
    map['token_to_spend_address'] = Variable<String>(tokenToSpendAddress);
    if (!nullToAbsent || dateCreated != null) {
      map['date_created'] = Variable<DateTime?>(dateCreated);
    }
    return map;
  }

  LiquidityModelCompanion toCompanion(bool nullToAbsent) {
    return LiquidityModelCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      tokenToBuyAddress: Value(tokenToBuyAddress),
      tokenToSpendAddress: Value(tokenToSpendAddress),
      dateCreated: dateCreated == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreated),
    );
  }

  factory Liquidity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Liquidity(
      id: serializer.fromJson<int?>(json['id']),
      tokenToBuyAddress: serializer.fromJson<String>(json['tokenToBuyAddress']),
      tokenToSpendAddress:
          serializer.fromJson<String>(json['tokenToSpendAddress']),
      dateCreated: serializer.fromJson<DateTime?>(json['dateCreated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'tokenToBuyAddress': serializer.toJson<String>(tokenToBuyAddress),
      'tokenToSpendAddress': serializer.toJson<String>(tokenToSpendAddress),
      'dateCreated': serializer.toJson<DateTime?>(dateCreated),
    };
  }

  Liquidity copyWith(
          {int? id,
          String? tokenToBuyAddress,
          String? tokenToSpendAddress,
          DateTime? dateCreated}) =>
      Liquidity(
        id: id ?? this.id,
        tokenToBuyAddress: tokenToBuyAddress ?? this.tokenToBuyAddress,
        tokenToSpendAddress: tokenToSpendAddress ?? this.tokenToSpendAddress,
        dateCreated: dateCreated ?? this.dateCreated,
      );
  @override
  String toString() {
    return (StringBuffer('Liquidity(')
          ..write('id: $id, ')
          ..write('tokenToBuyAddress: $tokenToBuyAddress, ')
          ..write('tokenToSpendAddress: $tokenToSpendAddress, ')
          ..write('dateCreated: $dateCreated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tokenToBuyAddress, tokenToSpendAddress, dateCreated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Liquidity &&
          other.id == this.id &&
          other.tokenToBuyAddress == this.tokenToBuyAddress &&
          other.tokenToSpendAddress == this.tokenToSpendAddress &&
          other.dateCreated == this.dateCreated);
}

class LiquidityModelCompanion extends UpdateCompanion<Liquidity> {
  final Value<int?> id;
  final Value<String> tokenToBuyAddress;
  final Value<String> tokenToSpendAddress;
  final Value<DateTime?> dateCreated;
  const LiquidityModelCompanion({
    this.id = const Value.absent(),
    this.tokenToBuyAddress = const Value.absent(),
    this.tokenToSpendAddress = const Value.absent(),
    this.dateCreated = const Value.absent(),
  });
  LiquidityModelCompanion.insert({
    this.id = const Value.absent(),
    required String tokenToBuyAddress,
    required String tokenToSpendAddress,
    this.dateCreated = const Value.absent(),
  })  : tokenToBuyAddress = Value(tokenToBuyAddress),
        tokenToSpendAddress = Value(tokenToSpendAddress);
  static Insertable<Liquidity> custom({
    Expression<int?>? id,
    Expression<String>? tokenToBuyAddress,
    Expression<String>? tokenToSpendAddress,
    Expression<DateTime?>? dateCreated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tokenToBuyAddress != null) 'token_to_buy_address': tokenToBuyAddress,
      if (tokenToSpendAddress != null)
        'token_to_spend_address': tokenToSpendAddress,
      if (dateCreated != null) 'date_created': dateCreated,
    });
  }

  LiquidityModelCompanion copyWith(
      {Value<int?>? id,
      Value<String>? tokenToBuyAddress,
      Value<String>? tokenToSpendAddress,
      Value<DateTime?>? dateCreated}) {
    return LiquidityModelCompanion(
      id: id ?? this.id,
      tokenToBuyAddress: tokenToBuyAddress ?? this.tokenToBuyAddress,
      tokenToSpendAddress: tokenToSpendAddress ?? this.tokenToSpendAddress,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (tokenToBuyAddress.present) {
      map['token_to_buy_address'] = Variable<String>(tokenToBuyAddress.value);
    }
    if (tokenToSpendAddress.present) {
      map['token_to_spend_address'] =
          Variable<String>(tokenToSpendAddress.value);
    }
    if (dateCreated.present) {
      map['date_created'] = Variable<DateTime?>(dateCreated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LiquidityModelCompanion(')
          ..write('id: $id, ')
          ..write('tokenToBuyAddress: $tokenToBuyAddress, ')
          ..write('tokenToSpendAddress: $tokenToSpendAddress, ')
          ..write('dateCreated: $dateCreated')
          ..write(')'))
        .toString();
  }
}

class $LiquidityModelTable extends LiquidityModel
    with TableInfo<$LiquidityModelTable, Liquidity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LiquidityModelTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _tokenToBuyAddressMeta =
      const VerificationMeta('tokenToBuyAddress');
  @override
  late final GeneratedColumn<String?> tokenToBuyAddress =
      GeneratedColumn<String?>('token_to_buy_address', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _tokenToSpendAddressMeta =
      const VerificationMeta('tokenToSpendAddress');
  @override
  late final GeneratedColumn<String?> tokenToSpendAddress =
      GeneratedColumn<String?>('token_to_spend_address', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _dateCreatedMeta =
      const VerificationMeta('dateCreated');
  @override
  late final GeneratedColumn<DateTime?> dateCreated =
      GeneratedColumn<DateTime?>('date_created', aliasedName, true,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns =>
      [id, tokenToBuyAddress, tokenToSpendAddress, dateCreated];
  @override
  String get aliasedName => _alias ?? 'liquidity_model';
  @override
  String get actualTableName => 'liquidity_model';
  @override
  VerificationContext validateIntegrity(Insertable<Liquidity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('token_to_buy_address')) {
      context.handle(
          _tokenToBuyAddressMeta,
          tokenToBuyAddress.isAcceptableOrUnknown(
              data['token_to_buy_address']!, _tokenToBuyAddressMeta));
    } else if (isInserting) {
      context.missing(_tokenToBuyAddressMeta);
    }
    if (data.containsKey('token_to_spend_address')) {
      context.handle(
          _tokenToSpendAddressMeta,
          tokenToSpendAddress.isAcceptableOrUnknown(
              data['token_to_spend_address']!, _tokenToSpendAddressMeta));
    } else if (isInserting) {
      context.missing(_tokenToSpendAddressMeta);
    }
    if (data.containsKey('date_created')) {
      context.handle(
          _dateCreatedMeta,
          dateCreated.isAcceptableOrUnknown(
              data['date_created']!, _dateCreatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Liquidity map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Liquidity.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LiquidityModelTable createAlias(String alias) {
    return $LiquidityModelTable(attachedDatabase, alias);
  }
}

class Snipe extends DataClass implements Insertable<Snipe> {
  final int id;
  final String tokenToBuyId;
  final String tokenToSpendId;
  final double amountToSpend;
  final double amountReceived;
  final double slippage;
  final double gas;
  final double amountSpent;
  final double dcaBuyTrigger;
  final bool dcaBuyTargets;
  final String? datesBought;
  final double amountSold;
  final double dcaSellTrigger;
  final bool dcaSellTargets;
  final String? datesSold;
  final bool autoTransac;
  final int snipeStatusId;
  Snipe(
      {required this.id,
      required this.tokenToBuyId,
      required this.tokenToSpendId,
      required this.amountToSpend,
      required this.amountReceived,
      required this.slippage,
      required this.gas,
      required this.amountSpent,
      required this.dcaBuyTrigger,
      required this.dcaBuyTargets,
      this.datesBought,
      required this.amountSold,
      required this.dcaSellTrigger,
      required this.dcaSellTargets,
      this.datesSold,
      required this.autoTransac,
      required this.snipeStatusId});
  factory Snipe.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Snipe(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      tokenToBuyId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}token_to_buy_id'])!,
      tokenToSpendId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}token_to_spend_id'])!,
      amountToSpend: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount_to_spend'])!,
      amountReceived: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount_received'])!,
      slippage: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}slippage'])!,
      gas: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}gas'])!,
      amountSpent: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount_spent'])!,
      dcaBuyTrigger: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dca_buy_trigger'])!,
      dcaBuyTargets: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dca_buy_targets'])!,
      datesBought: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dates_bought']),
      amountSold: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount_sold'])!,
      dcaSellTrigger: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dca_sell_trigger'])!,
      dcaSellTargets: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dca_sell_targets'])!,
      datesSold: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dates_sold']),
      autoTransac: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}auto_transac'])!,
      snipeStatusId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}snipe_status_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['token_to_buy_id'] = Variable<String>(tokenToBuyId);
    map['token_to_spend_id'] = Variable<String>(tokenToSpendId);
    map['amount_to_spend'] = Variable<double>(amountToSpend);
    map['amount_received'] = Variable<double>(amountReceived);
    map['slippage'] = Variable<double>(slippage);
    map['gas'] = Variable<double>(gas);
    map['amount_spent'] = Variable<double>(amountSpent);
    map['dca_buy_trigger'] = Variable<double>(dcaBuyTrigger);
    map['dca_buy_targets'] = Variable<bool>(dcaBuyTargets);
    if (!nullToAbsent || datesBought != null) {
      map['dates_bought'] = Variable<String?>(datesBought);
    }
    map['amount_sold'] = Variable<double>(amountSold);
    map['dca_sell_trigger'] = Variable<double>(dcaSellTrigger);
    map['dca_sell_targets'] = Variable<bool>(dcaSellTargets);
    if (!nullToAbsent || datesSold != null) {
      map['dates_sold'] = Variable<String?>(datesSold);
    }
    map['auto_transac'] = Variable<bool>(autoTransac);
    map['snipe_status_id'] = Variable<int>(snipeStatusId);
    return map;
  }

  SnipeModelCompanion toCompanion(bool nullToAbsent) {
    return SnipeModelCompanion(
      id: Value(id),
      tokenToBuyId: Value(tokenToBuyId),
      tokenToSpendId: Value(tokenToSpendId),
      amountToSpend: Value(amountToSpend),
      amountReceived: Value(amountReceived),
      slippage: Value(slippage),
      gas: Value(gas),
      amountSpent: Value(amountSpent),
      dcaBuyTrigger: Value(dcaBuyTrigger),
      dcaBuyTargets: Value(dcaBuyTargets),
      datesBought: datesBought == null && nullToAbsent
          ? const Value.absent()
          : Value(datesBought),
      amountSold: Value(amountSold),
      dcaSellTrigger: Value(dcaSellTrigger),
      dcaSellTargets: Value(dcaSellTargets),
      datesSold: datesSold == null && nullToAbsent
          ? const Value.absent()
          : Value(datesSold),
      autoTransac: Value(autoTransac),
      snipeStatusId: Value(snipeStatusId),
    );
  }

  factory Snipe.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Snipe(
      id: serializer.fromJson<int>(json['id']),
      tokenToBuyId: serializer.fromJson<String>(json['tokenToBuyId']),
      tokenToSpendId: serializer.fromJson<String>(json['tokenToSpendId']),
      amountToSpend: serializer.fromJson<double>(json['amountToSpend']),
      amountReceived: serializer.fromJson<double>(json['amountReceived']),
      slippage: serializer.fromJson<double>(json['slippage']),
      gas: serializer.fromJson<double>(json['gas']),
      amountSpent: serializer.fromJson<double>(json['amountSpent']),
      dcaBuyTrigger: serializer.fromJson<double>(json['dcaBuyTrigger']),
      dcaBuyTargets: serializer.fromJson<bool>(json['dcaBuyTargets']),
      datesBought: serializer.fromJson<String?>(json['datesBought']),
      amountSold: serializer.fromJson<double>(json['amountSold']),
      dcaSellTrigger: serializer.fromJson<double>(json['dcaSellTrigger']),
      dcaSellTargets: serializer.fromJson<bool>(json['dcaSellTargets']),
      datesSold: serializer.fromJson<String?>(json['datesSold']),
      autoTransac: serializer.fromJson<bool>(json['autoTransac']),
      snipeStatusId: serializer.fromJson<int>(json['snipeStatusId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tokenToBuyId': serializer.toJson<String>(tokenToBuyId),
      'tokenToSpendId': serializer.toJson<String>(tokenToSpendId),
      'amountToSpend': serializer.toJson<double>(amountToSpend),
      'amountReceived': serializer.toJson<double>(amountReceived),
      'slippage': serializer.toJson<double>(slippage),
      'gas': serializer.toJson<double>(gas),
      'amountSpent': serializer.toJson<double>(amountSpent),
      'dcaBuyTrigger': serializer.toJson<double>(dcaBuyTrigger),
      'dcaBuyTargets': serializer.toJson<bool>(dcaBuyTargets),
      'datesBought': serializer.toJson<String?>(datesBought),
      'amountSold': serializer.toJson<double>(amountSold),
      'dcaSellTrigger': serializer.toJson<double>(dcaSellTrigger),
      'dcaSellTargets': serializer.toJson<bool>(dcaSellTargets),
      'datesSold': serializer.toJson<String?>(datesSold),
      'autoTransac': serializer.toJson<bool>(autoTransac),
      'snipeStatusId': serializer.toJson<int>(snipeStatusId),
    };
  }

  Snipe copyWith(
          {int? id,
          String? tokenToBuyId,
          String? tokenToSpendId,
          double? amountToSpend,
          double? amountReceived,
          double? slippage,
          double? gas,
          double? amountSpent,
          double? dcaBuyTrigger,
          bool? dcaBuyTargets,
          String? datesBought,
          double? amountSold,
          double? dcaSellTrigger,
          bool? dcaSellTargets,
          String? datesSold,
          bool? autoTransac,
          int? snipeStatusId}) =>
      Snipe(
        id: id ?? this.id,
        tokenToBuyId: tokenToBuyId ?? this.tokenToBuyId,
        tokenToSpendId: tokenToSpendId ?? this.tokenToSpendId,
        amountToSpend: amountToSpend ?? this.amountToSpend,
        amountReceived: amountReceived ?? this.amountReceived,
        slippage: slippage ?? this.slippage,
        gas: gas ?? this.gas,
        amountSpent: amountSpent ?? this.amountSpent,
        dcaBuyTrigger: dcaBuyTrigger ?? this.dcaBuyTrigger,
        dcaBuyTargets: dcaBuyTargets ?? this.dcaBuyTargets,
        datesBought: datesBought ?? this.datesBought,
        amountSold: amountSold ?? this.amountSold,
        dcaSellTrigger: dcaSellTrigger ?? this.dcaSellTrigger,
        dcaSellTargets: dcaSellTargets ?? this.dcaSellTargets,
        datesSold: datesSold ?? this.datesSold,
        autoTransac: autoTransac ?? this.autoTransac,
        snipeStatusId: snipeStatusId ?? this.snipeStatusId,
      );
  @override
  String toString() {
    return (StringBuffer('Snipe(')
          ..write('id: $id, ')
          ..write('tokenToBuyId: $tokenToBuyId, ')
          ..write('tokenToSpendId: $tokenToSpendId, ')
          ..write('amountToSpend: $amountToSpend, ')
          ..write('amountReceived: $amountReceived, ')
          ..write('slippage: $slippage, ')
          ..write('gas: $gas, ')
          ..write('amountSpent: $amountSpent, ')
          ..write('dcaBuyTrigger: $dcaBuyTrigger, ')
          ..write('dcaBuyTargets: $dcaBuyTargets, ')
          ..write('datesBought: $datesBought, ')
          ..write('amountSold: $amountSold, ')
          ..write('dcaSellTrigger: $dcaSellTrigger, ')
          ..write('dcaSellTargets: $dcaSellTargets, ')
          ..write('datesSold: $datesSold, ')
          ..write('autoTransac: $autoTransac, ')
          ..write('snipeStatusId: $snipeStatusId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tokenToBuyId,
      tokenToSpendId,
      amountToSpend,
      amountReceived,
      slippage,
      gas,
      amountSpent,
      dcaBuyTrigger,
      dcaBuyTargets,
      datesBought,
      amountSold,
      dcaSellTrigger,
      dcaSellTargets,
      datesSold,
      autoTransac,
      snipeStatusId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Snipe &&
          other.id == this.id &&
          other.tokenToBuyId == this.tokenToBuyId &&
          other.tokenToSpendId == this.tokenToSpendId &&
          other.amountToSpend == this.amountToSpend &&
          other.amountReceived == this.amountReceived &&
          other.slippage == this.slippage &&
          other.gas == this.gas &&
          other.amountSpent == this.amountSpent &&
          other.dcaBuyTrigger == this.dcaBuyTrigger &&
          other.dcaBuyTargets == this.dcaBuyTargets &&
          other.datesBought == this.datesBought &&
          other.amountSold == this.amountSold &&
          other.dcaSellTrigger == this.dcaSellTrigger &&
          other.dcaSellTargets == this.dcaSellTargets &&
          other.datesSold == this.datesSold &&
          other.autoTransac == this.autoTransac &&
          other.snipeStatusId == this.snipeStatusId);
}

class SnipeModelCompanion extends UpdateCompanion<Snipe> {
  final Value<int> id;
  final Value<String> tokenToBuyId;
  final Value<String> tokenToSpendId;
  final Value<double> amountToSpend;
  final Value<double> amountReceived;
  final Value<double> slippage;
  final Value<double> gas;
  final Value<double> amountSpent;
  final Value<double> dcaBuyTrigger;
  final Value<bool> dcaBuyTargets;
  final Value<String?> datesBought;
  final Value<double> amountSold;
  final Value<double> dcaSellTrigger;
  final Value<bool> dcaSellTargets;
  final Value<String?> datesSold;
  final Value<bool> autoTransac;
  final Value<int> snipeStatusId;
  const SnipeModelCompanion({
    this.id = const Value.absent(),
    this.tokenToBuyId = const Value.absent(),
    this.tokenToSpendId = const Value.absent(),
    this.amountToSpend = const Value.absent(),
    this.amountReceived = const Value.absent(),
    this.slippage = const Value.absent(),
    this.gas = const Value.absent(),
    this.amountSpent = const Value.absent(),
    this.dcaBuyTrigger = const Value.absent(),
    this.dcaBuyTargets = const Value.absent(),
    this.datesBought = const Value.absent(),
    this.amountSold = const Value.absent(),
    this.dcaSellTrigger = const Value.absent(),
    this.dcaSellTargets = const Value.absent(),
    this.datesSold = const Value.absent(),
    this.autoTransac = const Value.absent(),
    this.snipeStatusId = const Value.absent(),
  });
  SnipeModelCompanion.insert({
    this.id = const Value.absent(),
    required String tokenToBuyId,
    required String tokenToSpendId,
    required double amountToSpend,
    required double amountReceived,
    required double slippage,
    required double gas,
    required double amountSpent,
    required double dcaBuyTrigger,
    required bool dcaBuyTargets,
    this.datesBought = const Value.absent(),
    required double amountSold,
    required double dcaSellTrigger,
    required bool dcaSellTargets,
    this.datesSold = const Value.absent(),
    required bool autoTransac,
    required int snipeStatusId,
  })  : tokenToBuyId = Value(tokenToBuyId),
        tokenToSpendId = Value(tokenToSpendId),
        amountToSpend = Value(amountToSpend),
        amountReceived = Value(amountReceived),
        slippage = Value(slippage),
        gas = Value(gas),
        amountSpent = Value(amountSpent),
        dcaBuyTrigger = Value(dcaBuyTrigger),
        dcaBuyTargets = Value(dcaBuyTargets),
        amountSold = Value(amountSold),
        dcaSellTrigger = Value(dcaSellTrigger),
        dcaSellTargets = Value(dcaSellTargets),
        autoTransac = Value(autoTransac),
        snipeStatusId = Value(snipeStatusId);
  static Insertable<Snipe> custom({
    Expression<int>? id,
    Expression<String>? tokenToBuyId,
    Expression<String>? tokenToSpendId,
    Expression<double>? amountToSpend,
    Expression<double>? amountReceived,
    Expression<double>? slippage,
    Expression<double>? gas,
    Expression<double>? amountSpent,
    Expression<double>? dcaBuyTrigger,
    Expression<bool>? dcaBuyTargets,
    Expression<String?>? datesBought,
    Expression<double>? amountSold,
    Expression<double>? dcaSellTrigger,
    Expression<bool>? dcaSellTargets,
    Expression<String?>? datesSold,
    Expression<bool>? autoTransac,
    Expression<int>? snipeStatusId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tokenToBuyId != null) 'token_to_buy_id': tokenToBuyId,
      if (tokenToSpendId != null) 'token_to_spend_id': tokenToSpendId,
      if (amountToSpend != null) 'amount_to_spend': amountToSpend,
      if (amountReceived != null) 'amount_received': amountReceived,
      if (slippage != null) 'slippage': slippage,
      if (gas != null) 'gas': gas,
      if (amountSpent != null) 'amount_spent': amountSpent,
      if (dcaBuyTrigger != null) 'dca_buy_trigger': dcaBuyTrigger,
      if (dcaBuyTargets != null) 'dca_buy_targets': dcaBuyTargets,
      if (datesBought != null) 'dates_bought': datesBought,
      if (amountSold != null) 'amount_sold': amountSold,
      if (dcaSellTrigger != null) 'dca_sell_trigger': dcaSellTrigger,
      if (dcaSellTargets != null) 'dca_sell_targets': dcaSellTargets,
      if (datesSold != null) 'dates_sold': datesSold,
      if (autoTransac != null) 'auto_transac': autoTransac,
      if (snipeStatusId != null) 'snipe_status_id': snipeStatusId,
    });
  }

  SnipeModelCompanion copyWith(
      {Value<int>? id,
      Value<String>? tokenToBuyId,
      Value<String>? tokenToSpendId,
      Value<double>? amountToSpend,
      Value<double>? amountReceived,
      Value<double>? slippage,
      Value<double>? gas,
      Value<double>? amountSpent,
      Value<double>? dcaBuyTrigger,
      Value<bool>? dcaBuyTargets,
      Value<String?>? datesBought,
      Value<double>? amountSold,
      Value<double>? dcaSellTrigger,
      Value<bool>? dcaSellTargets,
      Value<String?>? datesSold,
      Value<bool>? autoTransac,
      Value<int>? snipeStatusId}) {
    return SnipeModelCompanion(
      id: id ?? this.id,
      tokenToBuyId: tokenToBuyId ?? this.tokenToBuyId,
      tokenToSpendId: tokenToSpendId ?? this.tokenToSpendId,
      amountToSpend: amountToSpend ?? this.amountToSpend,
      amountReceived: amountReceived ?? this.amountReceived,
      slippage: slippage ?? this.slippage,
      gas: gas ?? this.gas,
      amountSpent: amountSpent ?? this.amountSpent,
      dcaBuyTrigger: dcaBuyTrigger ?? this.dcaBuyTrigger,
      dcaBuyTargets: dcaBuyTargets ?? this.dcaBuyTargets,
      datesBought: datesBought ?? this.datesBought,
      amountSold: amountSold ?? this.amountSold,
      dcaSellTrigger: dcaSellTrigger ?? this.dcaSellTrigger,
      dcaSellTargets: dcaSellTargets ?? this.dcaSellTargets,
      datesSold: datesSold ?? this.datesSold,
      autoTransac: autoTransac ?? this.autoTransac,
      snipeStatusId: snipeStatusId ?? this.snipeStatusId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tokenToBuyId.present) {
      map['token_to_buy_id'] = Variable<String>(tokenToBuyId.value);
    }
    if (tokenToSpendId.present) {
      map['token_to_spend_id'] = Variable<String>(tokenToSpendId.value);
    }
    if (amountToSpend.present) {
      map['amount_to_spend'] = Variable<double>(amountToSpend.value);
    }
    if (amountReceived.present) {
      map['amount_received'] = Variable<double>(amountReceived.value);
    }
    if (slippage.present) {
      map['slippage'] = Variable<double>(slippage.value);
    }
    if (gas.present) {
      map['gas'] = Variable<double>(gas.value);
    }
    if (amountSpent.present) {
      map['amount_spent'] = Variable<double>(amountSpent.value);
    }
    if (dcaBuyTrigger.present) {
      map['dca_buy_trigger'] = Variable<double>(dcaBuyTrigger.value);
    }
    if (dcaBuyTargets.present) {
      map['dca_buy_targets'] = Variable<bool>(dcaBuyTargets.value);
    }
    if (datesBought.present) {
      map['dates_bought'] = Variable<String?>(datesBought.value);
    }
    if (amountSold.present) {
      map['amount_sold'] = Variable<double>(amountSold.value);
    }
    if (dcaSellTrigger.present) {
      map['dca_sell_trigger'] = Variable<double>(dcaSellTrigger.value);
    }
    if (dcaSellTargets.present) {
      map['dca_sell_targets'] = Variable<bool>(dcaSellTargets.value);
    }
    if (datesSold.present) {
      map['dates_sold'] = Variable<String?>(datesSold.value);
    }
    if (autoTransac.present) {
      map['auto_transac'] = Variable<bool>(autoTransac.value);
    }
    if (snipeStatusId.present) {
      map['snipe_status_id'] = Variable<int>(snipeStatusId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SnipeModelCompanion(')
          ..write('id: $id, ')
          ..write('tokenToBuyId: $tokenToBuyId, ')
          ..write('tokenToSpendId: $tokenToSpendId, ')
          ..write('amountToSpend: $amountToSpend, ')
          ..write('amountReceived: $amountReceived, ')
          ..write('slippage: $slippage, ')
          ..write('gas: $gas, ')
          ..write('amountSpent: $amountSpent, ')
          ..write('dcaBuyTrigger: $dcaBuyTrigger, ')
          ..write('dcaBuyTargets: $dcaBuyTargets, ')
          ..write('datesBought: $datesBought, ')
          ..write('amountSold: $amountSold, ')
          ..write('dcaSellTrigger: $dcaSellTrigger, ')
          ..write('dcaSellTargets: $dcaSellTargets, ')
          ..write('datesSold: $datesSold, ')
          ..write('autoTransac: $autoTransac, ')
          ..write('snipeStatusId: $snipeStatusId')
          ..write(')'))
        .toString();
  }
}

class $SnipeModelTable extends SnipeModel
    with TableInfo<$SnipeModelTable, Snipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SnipeModelTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _tokenToBuyIdMeta =
      const VerificationMeta('tokenToBuyId');
  @override
  late final GeneratedColumn<String?> tokenToBuyId = GeneratedColumn<String?>(
      'token_to_buy_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _tokenToSpendIdMeta =
      const VerificationMeta('tokenToSpendId');
  @override
  late final GeneratedColumn<String?> tokenToSpendId = GeneratedColumn<String?>(
      'token_to_spend_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _amountToSpendMeta =
      const VerificationMeta('amountToSpend');
  @override
  late final GeneratedColumn<double?> amountToSpend = GeneratedColumn<double?>(
      'amount_to_spend', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _amountReceivedMeta =
      const VerificationMeta('amountReceived');
  @override
  late final GeneratedColumn<double?> amountReceived = GeneratedColumn<double?>(
      'amount_received', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _slippageMeta = const VerificationMeta('slippage');
  @override
  late final GeneratedColumn<double?> slippage = GeneratedColumn<double?>(
      'slippage', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _gasMeta = const VerificationMeta('gas');
  @override
  late final GeneratedColumn<double?> gas = GeneratedColumn<double?>(
      'gas', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _amountSpentMeta =
      const VerificationMeta('amountSpent');
  @override
  late final GeneratedColumn<double?> amountSpent = GeneratedColumn<double?>(
      'amount_spent', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _dcaBuyTriggerMeta =
      const VerificationMeta('dcaBuyTrigger');
  @override
  late final GeneratedColumn<double?> dcaBuyTrigger = GeneratedColumn<double?>(
      'dca_buy_trigger', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _dcaBuyTargetsMeta =
      const VerificationMeta('dcaBuyTargets');
  @override
  late final GeneratedColumn<bool?> dcaBuyTargets = GeneratedColumn<bool?>(
      'dca_buy_targets', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (dca_buy_targets IN (0, 1))');
  final VerificationMeta _datesBoughtMeta =
      const VerificationMeta('datesBought');
  @override
  late final GeneratedColumn<String?> datesBought = GeneratedColumn<String?>(
      'dates_bought', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _amountSoldMeta = const VerificationMeta('amountSold');
  @override
  late final GeneratedColumn<double?> amountSold = GeneratedColumn<double?>(
      'amount_sold', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _dcaSellTriggerMeta =
      const VerificationMeta('dcaSellTrigger');
  @override
  late final GeneratedColumn<double?> dcaSellTrigger = GeneratedColumn<double?>(
      'dca_sell_trigger', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _dcaSellTargetsMeta =
      const VerificationMeta('dcaSellTargets');
  @override
  late final GeneratedColumn<bool?> dcaSellTargets = GeneratedColumn<bool?>(
      'dca_sell_targets', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (dca_sell_targets IN (0, 1))');
  final VerificationMeta _datesSoldMeta = const VerificationMeta('datesSold');
  @override
  late final GeneratedColumn<String?> datesSold = GeneratedColumn<String?>(
      'dates_sold', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _autoTransacMeta =
      const VerificationMeta('autoTransac');
  @override
  late final GeneratedColumn<bool?> autoTransac = GeneratedColumn<bool?>(
      'auto_transac', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (auto_transac IN (0, 1))');
  final VerificationMeta _snipeStatusIdMeta =
      const VerificationMeta('snipeStatusId');
  @override
  late final GeneratedColumn<int?> snipeStatusId = GeneratedColumn<int?>(
      'snipe_status_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tokenToBuyId,
        tokenToSpendId,
        amountToSpend,
        amountReceived,
        slippage,
        gas,
        amountSpent,
        dcaBuyTrigger,
        dcaBuyTargets,
        datesBought,
        amountSold,
        dcaSellTrigger,
        dcaSellTargets,
        datesSold,
        autoTransac,
        snipeStatusId
      ];
  @override
  String get aliasedName => _alias ?? 'snipe_model';
  @override
  String get actualTableName => 'snipe_model';
  @override
  VerificationContext validateIntegrity(Insertable<Snipe> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('token_to_buy_id')) {
      context.handle(
          _tokenToBuyIdMeta,
          tokenToBuyId.isAcceptableOrUnknown(
              data['token_to_buy_id']!, _tokenToBuyIdMeta));
    } else if (isInserting) {
      context.missing(_tokenToBuyIdMeta);
    }
    if (data.containsKey('token_to_spend_id')) {
      context.handle(
          _tokenToSpendIdMeta,
          tokenToSpendId.isAcceptableOrUnknown(
              data['token_to_spend_id']!, _tokenToSpendIdMeta));
    } else if (isInserting) {
      context.missing(_tokenToSpendIdMeta);
    }
    if (data.containsKey('amount_to_spend')) {
      context.handle(
          _amountToSpendMeta,
          amountToSpend.isAcceptableOrUnknown(
              data['amount_to_spend']!, _amountToSpendMeta));
    } else if (isInserting) {
      context.missing(_amountToSpendMeta);
    }
    if (data.containsKey('amount_received')) {
      context.handle(
          _amountReceivedMeta,
          amountReceived.isAcceptableOrUnknown(
              data['amount_received']!, _amountReceivedMeta));
    } else if (isInserting) {
      context.missing(_amountReceivedMeta);
    }
    if (data.containsKey('slippage')) {
      context.handle(_slippageMeta,
          slippage.isAcceptableOrUnknown(data['slippage']!, _slippageMeta));
    } else if (isInserting) {
      context.missing(_slippageMeta);
    }
    if (data.containsKey('gas')) {
      context.handle(
          _gasMeta, gas.isAcceptableOrUnknown(data['gas']!, _gasMeta));
    } else if (isInserting) {
      context.missing(_gasMeta);
    }
    if (data.containsKey('amount_spent')) {
      context.handle(
          _amountSpentMeta,
          amountSpent.isAcceptableOrUnknown(
              data['amount_spent']!, _amountSpentMeta));
    } else if (isInserting) {
      context.missing(_amountSpentMeta);
    }
    if (data.containsKey('dca_buy_trigger')) {
      context.handle(
          _dcaBuyTriggerMeta,
          dcaBuyTrigger.isAcceptableOrUnknown(
              data['dca_buy_trigger']!, _dcaBuyTriggerMeta));
    } else if (isInserting) {
      context.missing(_dcaBuyTriggerMeta);
    }
    if (data.containsKey('dca_buy_targets')) {
      context.handle(
          _dcaBuyTargetsMeta,
          dcaBuyTargets.isAcceptableOrUnknown(
              data['dca_buy_targets']!, _dcaBuyTargetsMeta));
    } else if (isInserting) {
      context.missing(_dcaBuyTargetsMeta);
    }
    if (data.containsKey('dates_bought')) {
      context.handle(
          _datesBoughtMeta,
          datesBought.isAcceptableOrUnknown(
              data['dates_bought']!, _datesBoughtMeta));
    }
    if (data.containsKey('amount_sold')) {
      context.handle(
          _amountSoldMeta,
          amountSold.isAcceptableOrUnknown(
              data['amount_sold']!, _amountSoldMeta));
    } else if (isInserting) {
      context.missing(_amountSoldMeta);
    }
    if (data.containsKey('dca_sell_trigger')) {
      context.handle(
          _dcaSellTriggerMeta,
          dcaSellTrigger.isAcceptableOrUnknown(
              data['dca_sell_trigger']!, _dcaSellTriggerMeta));
    } else if (isInserting) {
      context.missing(_dcaSellTriggerMeta);
    }
    if (data.containsKey('dca_sell_targets')) {
      context.handle(
          _dcaSellTargetsMeta,
          dcaSellTargets.isAcceptableOrUnknown(
              data['dca_sell_targets']!, _dcaSellTargetsMeta));
    } else if (isInserting) {
      context.missing(_dcaSellTargetsMeta);
    }
    if (data.containsKey('dates_sold')) {
      context.handle(_datesSoldMeta,
          datesSold.isAcceptableOrUnknown(data['dates_sold']!, _datesSoldMeta));
    }
    if (data.containsKey('auto_transac')) {
      context.handle(
          _autoTransacMeta,
          autoTransac.isAcceptableOrUnknown(
              data['auto_transac']!, _autoTransacMeta));
    } else if (isInserting) {
      context.missing(_autoTransacMeta);
    }
    if (data.containsKey('snipe_status_id')) {
      context.handle(
          _snipeStatusIdMeta,
          snipeStatusId.isAcceptableOrUnknown(
              data['snipe_status_id']!, _snipeStatusIdMeta));
    } else if (isInserting) {
      context.missing(_snipeStatusIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Snipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Snipe.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SnipeModelTable createAlias(String alias) {
    return $SnipeModelTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TokenModelTable tokenModel = $TokenModelTable(this);
  late final $LiquidityModelTable liquidityModel = $LiquidityModelTable(this);
  late final $SnipeModelTable snipeModel = $SnipeModelTable(this);
  late final SnipeDao snipeDao = SnipeDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tokenModel, liquidityModel, snipeModel];
}
