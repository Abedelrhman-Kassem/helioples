import 'package:flutter/foundation.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // TO DO REMOVE STATIC FROM database instance -------------------------------------------
  static late Database database;

  static init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_Name);
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        try {
          await db.execute('''
              CREATE TABLE $cartItemTable (
              $cartItemId INTEGER PRIMARY KEY,
              $cartItemEnName TEXT NOT NULL,
              $cartItemEnDesc TEXT NOT NULL,
              $cartItemName TEXT NOT NULL,
              $cartItemDesc TEXT NOT NULL,
              $cartItemQty INTEGER NOT NULL,
              $cartItemImageUrl TEXT NOT NULL,
              $cartItemPrice REAL NOT NULL
              )
            ''');
          if (kDebugMode) {
            print('$cartItemTable table created');
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
      },
      onOpen: (db) {
        //
      },
    );
  }

  static Future<int> insertData({
    required String table,
    required Map<String, dynamic> values,
  }) async {
    return await database.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object?>>> queryData({
    required String table,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    return await database.query(
      table,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
    );
  }

  static Future<int> updateData({
    required String table,
    required Map<String, Object?> values,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    return await database.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }

  static Future<int> deleteData({
    required String table,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    return await database.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  static Future<List<String>> getTables(Database database) async {
    List<Map<String, Object?>> tables = await database
        .rawQuery("SELECT name FROM sqlite_master WHERE type='table'");

    List<String> tableNames =
        tables.map((table) => table['name'] as String).toList();

    return tableNames;
  }

  static Future<void> deleteDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, DB_Name);
    return await deleteDatabase(path);
  }
}
