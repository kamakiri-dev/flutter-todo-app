import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase {
  static const _databaseName = 'todo.db';
  static const _databaseVersion = 1;

  // テーブル名・カラム名（DataSource / Mapper からも参照する）
  static const tableName = 'todos';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnMemo = 'memo';
  static const columnDate = 'date';
  static const columnIsCompleted = 'is_completed';

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
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle TEXT NOT NULL,
        $columnMemo TEXT NOT NULL,
        $columnDate TEXT NOT NULL,
        $columnIsCompleted INTEGER NOT NULL
      )
    ''');
  }
}
