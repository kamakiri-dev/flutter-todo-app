import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/theme/app_colors.dart';
import 'package:todo_app/common/formatter/date_formatter.dart';
import 'package:todo_app/features/todo/bloc/todo_bloc.dart';
import 'package:todo_app/features/todo/bloc/todo_event.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';
import 'package:todo_app/features/todo/view/widget/todo_delete_dialog.dart';

const double _cardRadius = 14.0;
const double _titleMemoSpacing = 2.0;
const double _textDateSpacing = 12.0;

class TodoItemCard extends StatelessWidget {
  final TodoItem todo;

  const TodoItemCard({super.key, required this.todo});

  // 期限が今日より前で未完了なら期限切れ
  bool get _isOverdue {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return !todo.isCompleted && todo.date.isBefore(today);
  }

  Future<void> _confirmDelete(BuildContext context) async {
    // await 後に context を使わないよう、先に Bloc を取得しておく
    final bloc = context.read<TodoBloc>();
    final confirmed = await TodoDeleteDialog.show(context, todo);
    if (confirmed) {
      bloc.add(TodoDeleted(todo));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final subColor = _isOverdue ? colorScheme.error : colorScheme.onSecondary;

    return Card(
      color: todo.isCompleted ? AppColors.cardCompleted : AppColors.card,
      child: InkWell(
        borderRadius: BorderRadius.circular(_cardRadius),
        onTap: () {
          context.push('/edit', extra: todo);
        },
        onLongPress: () => _confirmDelete(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 12.0, 16.0, 12.0),
          child: Row(
            children: [
              // チェックボックス
              Checkbox(
                value: todo.isCompleted,
                onChanged: (value) {
                  // Todoの完了状態を変更
                  context.read<TodoBloc>().add(TodoToggled(todo));
                },
              ),

              const SizedBox(width: 4.0),

              // Todo情報
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        // 完了済みは取り消し線＋グレー
                        color: todo.isCompleted
                            ? colorScheme.onSecondary
                            : colorScheme.onSurface,
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),

                    if (todo.memo.isNotEmpty) ...[
                      const SizedBox(height: _titleMemoSpacing),
                      Text(
                        todo.memo,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: _textDateSpacing),

              // 期限（右寄せ）
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14.0,
                    color: subColor,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    DateFormatter.format(todo.date),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: subColor,
                      fontWeight: _isOverdue ? FontWeight.bold : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
