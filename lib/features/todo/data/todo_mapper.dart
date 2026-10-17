import 'package:todo_app/features/todo/data/todo_database.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';

class TodoMapper {
  // TodoItem→DB
  Map<String, dynamic> toMap(TodoItem todo) {
    return {
      TodoDatabase.columnId: todo.id,
      TodoDatabase.columnTitle: todo.title,
      TodoDatabase.columnMemo: todo.memo,
      TodoDatabase.columnDate: todo.date.toIso8601String(),
      TodoDatabase.columnIsCompleted: todo.isCompleted ? 1 : 0,
    };
  }

  // DB→TodoItem
  TodoItem fromMap(Map<String, dynamic> map) {
    return TodoItem(
      id: map[TodoDatabase.columnId],
      title: map[TodoDatabase.columnTitle],
      memo: map[TodoDatabase.columnMemo],
      date: DateTime.parse(map[TodoDatabase.columnDate]),
      isCompleted: map[TodoDatabase.columnIsCompleted] == 1, // 1と等しければtrue
    );
  }
}
