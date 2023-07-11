import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/material.dart';

// the timestamp is stored as yyyy-mm-dd and is in GMT convert it into local while presening
//well now im using Datetime.now() and it shows local time so no need to change anything afterwards
class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        price INT,
        date TEXT,
        month TEXT,
        year TEXT,
        type Text
      )
      """);
    print("data base created");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbforexpense_one.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
        print("database create tables");
      },
    );
  }

  // Create new item
  static Future<int> createItem(
      String title, String? descrption, int price, String type) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': descrption,
      'price': price,
      'date': DateTime.now().day.toString(),
      'month': DateTime.now().month.toString(),
      'year': DateTime.now().year.toString(),
      'type': type
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    print("called func getallitems");
    return db.query('items', orderBy: "id");
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String title, String? descrption,
      int price, String date, String month, String year, String type) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': descrption,
      'price': price,
      'date': DateTime.now().day.toString(),
      'month': DateTime.now().month.toString(),
      'year': DateTime.now().year.toString(),
      'type': type
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
