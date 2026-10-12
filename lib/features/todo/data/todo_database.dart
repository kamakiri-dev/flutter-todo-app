import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase {
  static const _databaseName = 'todo.db';
  static const _databaseVersion = 1;
  static const _tableName = 'todos';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // Web はパス不要（IndexedDB に DB 名で保存される）
    final path = kIsWeb
        ? _databaseName
        : '${await getDatabasesPath()}/$_databaseName';

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await _createTable(db);
      },
    );

    return _database!;
  }

  Future<void> _createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        memo TEXT NOT NULL,
        date TEXT NOT NULL,
        is_completed INTEGER NOT NULL
      )
    ''');
  }
}
