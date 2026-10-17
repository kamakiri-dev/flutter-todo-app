import 'package:todo_app/features/todo/data/todo_database.dart';
import 'package:todo_app/features/todo/data/todo_mapper.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';

class TodoLocalDataSource {
  final TodoDatabase database;
  final TodoMapper mapper;

  TodoLocalDataSource({required this.database, required this.mapper});

  // id で 1 行を絞り込む WHERE 句
  static const _whereId = '${TodoDatabase.columnId} = ?';

  Future<List<TodoItem>> getTodos() async {
    final db = await database.database;
    // 期限（日時）が近い順。同じ日時なら作成順
    // date は ISO8601 文字列なので文字列比較でも日付順になる
    final data = await db.query(
      TodoDatabase.tableName,
      orderBy: '${TodoDatabase.columnDate} ASC, ${TodoDatabase.columnId} ASC',
    );

    return data.map(mapper.fromMap).toList();
  }

  Future<void> insertTodo(TodoItem todo) async {
    // DBを取得
    final db = await database.database;
    // TodoItemをDBに入れられるMapに変換
    final data = mapper.toMap(todo);
    // 新規はDBにidを渡さず自動採番させる
    data.remove(TodoDatabase.columnId);
    await db.insert(TodoDatabase.tableName, data);
  }

  Future<void> updateTodo(TodoItem todo) async {
    final db = await database.database;
    final data = mapper.toMap(todo);

    // todosテーブルの中からidがtodo.idと一致する行を更新
    await db.update(
      TodoDatabase.tableName,
      data,
      where: _whereId,
      whereArgs: [todo.id],
    );
  }

  Future<void> toggleTodo(int id) async {
    final db = await database.database;

    // 完了状態(0/1)をDB上で反転
    await db.rawUpdate(
      'UPDATE ${TodoDatabase.tableName} '
      'SET ${TodoDatabase.columnIsCompleted} = 1 - ${TodoDatabase.columnIsCompleted} '
      'WHERE $_whereId',
      [id],
    );
  }

  Future<void> deleteTodo(int id) async {
    final db = await database.database;

    await db.delete(TodoDatabase.tableName, where: _whereId, whereArgs: [id]);
  }
}
