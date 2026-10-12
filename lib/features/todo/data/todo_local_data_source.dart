import 'package:todo_app/features/todo/data/todo_database.dart';
import 'package:todo_app/features/todo/data/todo_mapper.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';

class TodoLocalDataSource {
  final TodoDatabase database;
  final TodoMapper mapper;

  TodoLocalDataSource({required this.database, required this.mapper});

  Future<List<TodoItem>> getTodos() async {
    final db = await database.database;
    // 期限が近い順。同じ期限なら作成順
    // date は ISO8601 文字列なので文字列比較でも日付順になる
    final data = await db.query('todos', orderBy: 'date ASC, id ASC');

    return data.map(mapper.fromMap).toList();
  }

  Future<void> insertTodo(TodoItem todo) async {
    // DBを取得
    final db = await database.database;
    // TodoItemをDBに入れられるMapに変換
    final data = mapper.toMap(todo);
    // 新規はid=0、DBにidを渡さず自動採番させる
    data.remove('id');
    await db.insert('todos', data);
  }

  Future<void> updateTodo(TodoItem todo) async {
    final db = await database.database;
    final data = mapper.toMap(todo);

    // todosテーブルの中からidがtodo.idと一致する行を更新
    await db.update('todos', data, where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> deleteTodo(int id) async {
    final db = await database.database;

    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
