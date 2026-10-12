import 'package:todo_app/features/todo/model/todo_item.dart';

abstract class TodoState {
  const TodoState();
}

class TodoLoading extends TodoState {
  const TodoLoading();
}

class TodoSuccess extends TodoState {
  const TodoSuccess(this.todos);
  final List<TodoItem> todos;
}

class TodoFailure extends TodoState {
  const TodoFailure(this.error);
  final String error;
}
