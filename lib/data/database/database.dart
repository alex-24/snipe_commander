import 'package:flutter/material.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';

import 'db_dao_&_tables.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [
  TokenModel,
  LiquidityModel,
  SnipeModel,
], daos: [
  SnipeDao,
])
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  static AppDatabase _singleton = AppDatabase._internal();

  factory AppDatabase() {
    return _singleton;
  }

  AppDatabase._internal() : super(_openConnection());

  Future<void> backup(BuildContext context) async {
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      //final dbFolder = await getDatabasesPath();
      final dbFolder = await getApplicationDocumentsDirectory();
      final dbLocation = p.join(dbFolder.path, 'db.sqlite');
      print(dbFolder.listSync().map((e) => "${e.path}"));

      final File file = File(dbLocation);
      //print(file.readAsStringSync());
      File bck = await file.copy('/storage/emulated/0/Download/sc_db_backup.sqlite');
      print("Backup");
    }
  }

  Future<void> restore(BuildContext context) async {
    if (await Permission.storage.request().isGranted) {
      final dbFolder = (await getApplicationDocumentsDirectory()).path;
      final dbLocation = p.join(dbFolder, 'db.sqlite');
      final File bck = File('/storage/emulated/0/Download/sc_db_backup.sqlite');

      AppDatabase._singleton.close();
      await bck.copy(dbLocation);
      File("/storage/emulated/0/Download/sc_db_backup.sqlite").delete();
      AppDatabase._singleton = AppDatabase._internal();
    }
  }

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        /*if (to > 15) {
          m.deleteTable("magazine_tag_model");
          m.deleteTable("article_tag_model");
          m.deleteTable("tag_model");
        }*/
      });
}
