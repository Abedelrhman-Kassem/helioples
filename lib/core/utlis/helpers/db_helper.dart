import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/db_change_notifier.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static late Database database;

  static init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DB_Name);
    database = await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("DROP TABLE IF EXISTS $cartTable");
          await db.execute("DROP TABLE IF EXISTS $searchTable");
          await _onCreate(db, newVersion);
        }
      },
      onOpen: (db) {
        //
      },
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
              CREATE TABLE $cartTable (
              $cartItemId VARCHAR(255) PRIMARY KEY,
              $cartItemEnName TEXT NOT NULL,
              $cartItemEnDesc TEXT NOT NULL,
              $cartItemName VARCHAR(255) NOT NULL,
              $cartItemDesc VARCHAR(255) NOT NULL,
              $cartItemQty REAL NOT NULL,
              $cartItemImageUrl VARCHAR(255) NOT NULL,
              $cartItemPrice REAL NOT NULL,
              $cartItemDiscount REAL NOT NULL
              )
            ''');

      await db.execute('''
              CREATE TABLE $searchTable (
              $searchItemId INTEGER PRIMARY KEY,
              $searchItemName TEXT NOT NULL UNIQUE
              )
            ''');

      if (kDebugMode) {
        print('$cartTable table created');
        print('$searchTable table created');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future<int> insertData({
    required String table,
    required Map<String, dynamic> values,
  }) async {
    try {
      final DbChangeNotifier productsCount = DbChangeNotifier();

      int row = await database.insert(
        table,
        values,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      productsCount.fetchItemCount();

      return row;
    } catch (e) {
      log(e.toString());
      throw '${values[cartItemName]} is not inserted succefully';
    }
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
    try {
      final DbChangeNotifier productsCount = DbChangeNotifier();

      int updatedRow = await database.update(
        table,
        values,
        where: where,
        whereArgs: whereArgs,
      );

      productsCount.fetchItemCount();

      return updatedRow;
    } catch (e) {
      throw '$e, ${whereArgs?[0]} not updated successfully';
    }
  }

  static Future<int> deleteData({
    required String table,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      final DbChangeNotifier productsCount = DbChangeNotifier();

      int deletedRow = await database.delete(
        table,
        where: where,
        whereArgs: whereArgs,
      );

      productsCount.fetchItemCount();

      return deletedRow;
    } catch (e) {
      throw '$e, ${whereArgs?[0]} not deleted successfully';
    }
  }

  static Future<int> getCartItemCount() async {
    final List<Map<String, dynamic>> result = await database.rawQuery(
      'SELECT COUNT(*) as count FROM $cartTable',
    );

    int count = Sqflite.firstIntValue(result) ?? 0;

    return count;
  }

  static Future<DbChangeNotifierModel> getDbData() async {
    List<Map<String, Object?>> items = await DBHelper.queryData(
      table: cartTable,
      columns: [cartItemQty, cartItemPrice, cartItemDiscount],
    );

    double totalPrice = 0;
    double totalDiscount = 0;

    for (var item in items) {
      double qty = item[cartItemQty] as double;
      double price = item[cartItemPrice] as double;
      double discount = item[cartItemDiscount] as double;

      totalPrice += qty * price;
      totalDiscount += qty * discount;
    }

    totalPrice = double.parse(totalPrice.toStringAsFixed(2));
    return DbChangeNotifierModel(
      count: items.length,
      totalPrice: totalPrice,
      totalDiscount: totalDiscount,
    );
  }

  static Future<List<String>> getTables(Database database) async {
    List<Map<String, Object?>> tables = await database.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table'",
    );

    List<String> tableNames = tables
        .map((table) => table['name'] as String)
        .toList();

    return tableNames;
  }

  static Future<void> deleteDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, DB_Name);
    return await deleteDatabase(path);
  }
}
