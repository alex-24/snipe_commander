import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:jiffy/jiffy.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'database.dart';

part 'db_dao_&_tables.g.dart';
//flutter packages pub run build_runner build

enum DataBaseTableEnum {
  TOKEN,
  LIQUIDITY,
  SNIPE,
}

extension DataBaseTableEnumExtension on DataBaseTableEnum {
  String get name {
    return this.toString().split('.').last;
  }
}

enum SnipeStatus {
  INACTIVE,
  IN_PROGRESS,
  FINISHED,
}

extension SnipeStatusExtension on SnipeStatus {
  String get name {
    return this.toString().split('.').last;
  }
}

enum InitialInvestmentTrigger { ON_LIQUIDITY_CREATED, WHEN_PRICE_IS_AT }

extension InitialInvestmentTriggerExtension on InitialInvestmentTrigger {
  String get name {
    return this.toString().split('.').last;
  }
}

@DataClassName("Token")
class TokenModel extends Table {
  TextColumn get address => text()();
  TextColumn get name => text().nullable().withDefault(Constant(""))();
  TextColumn get symbol => text().nullable().withDefault(Constant(""))();
  TextColumn get decimals => text().nullable().withDefault(Constant(""))();
  TextColumn get balance => text().nullable().withDefault(Constant(""))();
  TextColumn get owner => text().nullable().withDefault(Constant(""))();

  @override
  Set<Column>? get primaryKey => {address};

}

@DataClassName("Liquidity")
class LiquidityModel extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get tokenToBuyAddress => text()();
  TextColumn get tokenToSpendAddress => text()();
  DateTimeColumn get dateCreated =>
      dateTime().nullable().withDefault(Constant(DateTime.now()))();
}

@DataClassName("Snipe")
class SnipeModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tokenToBuyId => text()();
  TextColumn get tokenToSpendId => text()();
  RealColumn get amountToSpend => real()();
  RealColumn get amountReceived => real()();
  RealColumn get slippage => real()();
  RealColumn get gas => real()();
  RealColumn get amountSpent => real()();
  RealColumn get dcaBuyTrigger => real()();
  BoolColumn get dcaBuyTargets => boolean()(); // % or time step
  TextColumn get datesBought =>
      text().nullable()(); //todo: err management, receipts
  RealColumn get amountSold => real()();
  RealColumn get dcaSellTrigger => real()();
  BoolColumn get dcaSellTargets => boolean()(); // % or time step
  TextColumn get datesSold => text().nullable()();
  BoolColumn get autoTransac => boolean()();
  IntColumn get snipeStatusId => integer()();
}

@UseDao(tables: [TokenModel, LiquidityModel, SnipeModel])
class SnipeDao extends DatabaseAccessor<AppDatabase> with _$SnipeDaoMixin {
  final AppDatabase db;

  SnipeDao(this.db) : super(db);

  Stream<List<Token>> watchAllTokens() {
    return (select(tokenModel)).watch();
  }

  Stream<List<Snipe>> watchAllSnipes() {
    return (select(snipeModel)).watch();
  }

  Future<Token> getToken({required String tokenAddress}){

    final query = select(tokenModel)
      ..where((tbl) => tbl.address.equals(tokenAddress));

    return query.getSingle();
  }

  Stream<List<Liquidity>> watchAllDetectedLiquidities() {
    return (select(liquidityModel)
      ..orderBy(
        [
              (a) => OrderingTerm(expression: a.dateCreated, mode: OrderingMode.asc),
        ],
      ))
        .watch();
  }

  Future<int> insertTokenModel(Insertable<Token> token) =>
      into(tokenModel).insert(token);
  Future<int> upsertTokenModel(Insertable<Token> token) =>
      into(tokenModel).insertOnConflictUpdate(token);
  Future<bool> replaceTokenModel(Insertable<Token> token) =>
      update(tokenModel).replace(token);
  Future<int> deleteTokenModel(Insertable<Token> token) =>
      delete(tokenModel).delete(token);

  Future<int> insertLiquidityModel({
    required String tokenToSpendAddress,
    required String tokenToBuyAddress,
}) {
    //return into(liquidityModel).insert(liquidity);

    return transaction(() async {
      await into(tokenModel).insert(Token(
        address: tokenToBuyAddress,
      ));
      return await into(liquidityModel).insert(Liquidity(
        id: null,
        tokenToBuyAddress: tokenToBuyAddress,
        tokenToSpendAddress: tokenToSpendAddress,
        dateCreated: DateTime.now(),
      ));
    });
  }

  Future<int> upsertLiquidityModel(Insertable<Liquidity> liquidity) =>
      into(liquidityModel).insertOnConflictUpdate(liquidity);
  Future<bool> replaceLiquidityModel(Insertable<Liquidity> liquidity) =>
      update(liquidityModel).replace(liquidity);
  Future<int> deleteLiquidityModel(Insertable<Liquidity> liquidity) =>
      delete(liquidityModel).delete(liquidity);

  Future<int> insertSnipeModel(Insertable<Snipe> snipe) =>
      into(snipeModel).insert(snipe);
  Future<int> upsertSnipeModel(Insertable<Snipe> snipe) =>
      into(snipeModel).insertOnConflictUpdate(snipe);
  Future<bool> replaceSnipeModel(Insertable<Snipe> snipe) =>
      update(snipeModel).replace(snipe);
  Future<int> deleteSnipeModel(Insertable<Snipe> snipe) =>
      delete(snipeModel).delete(snipe);
}
