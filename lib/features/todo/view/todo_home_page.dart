import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/router/app_routes.dart';
import 'package:todo_app/app/theme/app_sizes.dart';
import 'package:todo_app/common/constants/app_texts.dart';
import 'package:todo_app/features/todo/bloc/todo_bloc.dart';
import 'package:todo_app/features/todo/bloc/todo_event.dart';
import 'package:todo_app/features/todo/bloc/todo_state.dart';
import 'package:todo_app/features/todo/view/widget/todo_empty_view.dart';
import 'package:todo_app/features/todo/view/widget/todo_error_dialog.dart';
import 'package:todo_app/features/todo/view/widget/todo_item_card.dart';
import 'package:todo_app/features/todo/view/widget/todo_summary_header.dart';

// FAB にカードが隠れないよう、一覧の下に余白を取る
const double _listBottomPadding = 96.0;
// カード同士の間隔
const double _listItemSpacing = 10.0;

class TodoHomePage extends StatelessWidget {
  const TodoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppTexts.todoList)),
      body: BlocConsumer<TodoBloc, TodoState>(
        // 失敗したらエラーダイアログを出し、閉じたら一覧を読み込み直す
        listener: (context, state) async {
          if (state is TodoFailure) {
            final bloc = context.read<TodoBloc>();
            await TodoErrorDialog.show(context);
            bloc.add(const TodoLoad());
          }
        },
        // 失敗時は画面を切り替えず、直前の表示のままダイアログだけ出す
        buildWhen: (previous, current) => current is! TodoFailure,
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
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
                      AppSizes.spaceL,
                      AppSizes.spaceS,
                      AppSizes.spaceL,
                      _listBottomPadding,
                    ),
                    itemCount: state.todos.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: _listItemSpacing),
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
          context.push(AppRoutes.edit);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
