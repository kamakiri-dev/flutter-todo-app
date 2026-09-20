import 'package:todo_app/features/todo/model/todo_item.dart';

abstract class TodoEvent {
  const TodoEvent();
}

class TodoLoad extends TodoEvent {
  const TodoLoad();
}

class TodoSaved extends TodoEvent {
  const TodoSaved(this.todo);
  final TodoItem todo;
}

class TodoDeleted extends TodoEvent {
  const TodoDeleted(this.todo);
  final TodoItem todo;
}

class TodoToggled extends TodoEvent {
  const TodoToggled(this.todo);
  final TodoItem todo;
}
