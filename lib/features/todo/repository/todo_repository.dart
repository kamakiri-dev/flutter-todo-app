import 'package:todo_app/features/todo/data/todo_local_data_source.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';

class TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepository({required this.localDataSource});

  Future<List<TodoItem>> getTodos() {
    return localDataSource.getTodos();
  }

  Future<void> saveTodo(TodoItem todo) {
    // 新規ならinsert、それ以外ならupdate
    if (todo.isNew) {
      return localDataSource.insertTodo(todo);
    }
    return localDataSource.updateTodo(todo);
  }

  Future<void> toggleTodo(int id) {
    return localDataSource.toggleTodo(id);
  }

  Future<void> deleteTodo(int id) {
    return localDataSource.deleteTodo(id);
  }
}
