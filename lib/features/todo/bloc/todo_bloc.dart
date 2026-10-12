import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/bloc/todo_event.dart';
import 'package:todo_app/features/todo/bloc/todo_state.dart';
import 'package:todo_app/features/todo/repository/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({required this.repository}) : super(const TodoLoading()) {
    on<TodoLoad>(_onTodoLoad);
    on<TodoSaved>(_onTodoSaved);
    on<TodoDeleted>(_onTodoDeleted);
    on<TodoToggled>(_onTodoToggled);
  }

  final TodoRepository repository;
  static const _delayDuration = 1;

  Future<void> _onTodoLoad(TodoLoad event, Emitter<TodoState> emit) async {
    try {
      emit(const TodoLoading());
      // DBからTodoを取得
      final todos = await repository.getTodos();
      // TodoSuccessをemit（成功）
      emit(TodoSuccess(todos));
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> _onTodoSaved(TodoSaved event, Emitter<TodoState> emit) async {
    try {
      emit(const TodoLoading());
      await Future.delayed(const Duration(seconds: _delayDuration));

      // event.todoをRepositoryに渡して保存する
      await repository.saveTodo(event.todo);
      // 保存後のTodo一覧を取得する
      final todos = await repository.getTodos();
      emit(TodoSuccess(todos));
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
      await Future.delayed(const Duration(seconds: _delayDuration));

      // DBからTodoを削除
      await repository.deleteTodo(event.todo.id);
      final todos = await repository.getTodos();
      emit(TodoSuccess(todos));
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> _onTodoToggled(
    TodoToggled event,
    Emitter<TodoState> emit,
  ) async {
    try {
      // 一覧がスピナーに切り替わってスクロール位置が戻らないよう、Loadingはemitしない
      // DBでisCompletedを反転
      final updatedTodo = event.todo.copyWith(
        isCompleted: !event.todo.isCompleted,
      );
      // 変更したTodoをDBに保存
      await repository.saveTodo(updatedTodo);
      final todos = await repository.getTodos();
      emit(TodoSuccess(todos));
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }
}
