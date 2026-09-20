import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/Bloc/todo_event.dart';
import 'package:todo_app/features/todo/Bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoLoading()) {
    on<TodoLoad>(_onTodoLoad);
    on<TodoSaved>(_onTodoSaved);
    on<TodoDeleted>(_onTodoDeleted);
    on<TodoToggled>(_onTodoToggled);
  }

  Future<void> _onTodoLoad(TodoLoad event, Emitter<TodoState> emit) async {
    try {
      emit(const TodoLoading());
      // DBからTodoを取得
      // TodoSuccessをemit（成功）
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> _onTodoSaved(TodoSaved event, Emitter<TodoState> emit) async {
    try {
      emit(const TodoLoading());
      // event.todoをRepositoryに渡して保存する
      // 保存後のTodo一覧を取得する
      // TodoSuccessを発行する
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> _onTodoDeleted(
    TodoDeleted event,
    Emitter<TodoState> emit,
  ) async {
    try {
      emit(const TodoLoading());
      // DBからTodoを削除
      // emit(TodoSuccess(todos));
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> _onTodoToggled(
    TodoToggled event,
    Emitter<TodoState> emit,
  ) async {
    try {
      emit(const TodoLoading());
      // DBでisCompletedを変更する
      // 変更した状態をemit
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }
}
