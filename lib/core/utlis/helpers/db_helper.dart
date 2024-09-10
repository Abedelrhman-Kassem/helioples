import 'package:flutter/foundation.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // TO DO REMOVE STATIC FROM database instance -------------------------------------------
  static late Database database;

  static init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'inventory.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        try {
          // await db.execute(
          //     'CREATE TABLE ReceivedHeader (id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, reference_no TEXT NOT NULL, store_no TEXT, location_code TEXT NOT NULL, counted_data TEXT, is_sent TEXT)');
          // print('table 1 created');

          await db.execute(
              'CREATE TABLE table (id INTEGER PRIMARY KEY AUTOINCREMENT, document_no TEXT)');
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
    return await database.insert(table, values);
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

  // static void createTable(Database db) async {
  //   await db.execute(
  //       'CREATE TABLE ReceivedItems (id INTEGER PRIMARY KEY AUTOINCREMENT, document_no TEXT NOT NULL, barcode_value TEXT NOT NULL, description TEXT, quantity INTEGER)');
  //   print('table 2 created');
  // }

  static Future<List<String>> getTables(Database database) async {
    List<Map<String, Object?>> tables = await database
        .rawQuery("SELECT name FROM sqlite_master WHERE type='table'");

    List<String> tableNames =
        tables.map((table) => table['name'] as String).toList();

    return tableNames;
  }

  static Future<void> deleteDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'inventory.db');
    return await deleteDatabase(path);
  }
}
