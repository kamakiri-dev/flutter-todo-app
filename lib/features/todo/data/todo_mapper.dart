import 'package:todo_app/features/todo/model/todo_item.dart';

class TodoMapper {
  // TodoItem→DB
  Map<String, dynamic> toMap(TodoItem todo) {
    return {
      'id': todo.id,
      'title': todo.title,
      'memo': todo.memo,
      'date': todo.date.toIso8601String(),
      'is_completed': todo.isCompleted ? 1 : 0,
    };
  }

  // DB→TodoItem
  TodoItem fromMap(Map<String, dynamic> map) {
    return TodoItem(
      id: map['id'],
      title: map['title'],
      memo: map['memo'],
      date: DateTime.parse(map['date']),
      isCompleted: map['is_completed'] == 1, // 1と等しければtrue
    );
  }
}
