import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/common/constants/app_texts.dart';
import 'package:todo_app/features/todo/bloc/todo_bloc.dart';
import 'package:todo_app/features/todo/bloc/todo_event.dart';
import 'package:todo_app/features/todo/bloc/todo_state.dart';
import 'package:todo_app/features/todo/view/widget/todo_empty_view.dart';
import 'package:todo_app/features/todo/view/widget/todo_item_card.dart';
import 'package:todo_app/features/todo/view/widget/todo_summary_header.dart';

// FAB にカードが隠れないよう、一覧の下に余白を取る
const double _listBottomPadding = 96.0;

class TodoHomePage extends StatelessWidget {
  const TodoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppTexts.todoList)),
      body: BlocConsumer<TodoBloc, TodoState>(
        // 保存・削除などに失敗したら SnackBar で知らせる
        listener: (context, state) {
          if (state is TodoFailure) {
            final colorScheme = Theme.of(context).colorScheme;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppTexts.errorTitle),
                backgroundColor: colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TodoFailure) {
            return _ErrorView(error: state.error);
          }

          if (state is TodoSuccess) {
            if (state.todos.isEmpty) {
              return const TodoEmptyView();
            }

            return Column(
              children: [
                TodoSummaryHeader(todos: state.todos),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      16.0,
                      8.0,
                      16.0,
                      _listBottomPadding,
                    ),
                    itemCount: state.todos.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10.0),
                    itemBuilder: (context, index) {
                      return TodoItemCard(todo: state.todos[index]);
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/edit');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// エラー時の表示（再読み込みボタン付き）
class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 56.0, color: colorScheme.error),
            const SizedBox(height: 16.0),
            Text(
              AppTexts.errorTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              error,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            const SizedBox(height: 24.0),
            FilledButton.icon(
              onPressed: () {
                context.read<TodoBloc>().add(const TodoLoad());
              },
              icon: const Icon(Icons.refresh),
              label: const Text(AppTexts.retry),
            ),
          ],
        ),
      ),
    );
  }
}
