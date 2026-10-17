import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/router/app_routes.dart';
import 'package:todo_app/app/theme/app_colors.dart';
import 'package:todo_app/app/theme/app_sizes.dart';
import 'package:todo_app/common/formatter/date_formatter.dart';
import 'package:todo_app/features/todo/bloc/todo_bloc.dart';
import 'package:todo_app/features/todo/bloc/todo_event.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';
import 'package:todo_app/features/todo/view/widget/todo_delete_dialog.dart';

// タイトルとメモの間隔
const double _titleMemoSpacing = 2.0;
// 期限の前のカレンダーアイコン
const double _dateIconSize = 14.0;
// 表示する最大行数（超えたら … で省略）
const int _titleMaxLines = 2;
const int _memoMaxLines = 1;

class TodoItemCard extends StatelessWidget {
  const TodoItemCard({super.key, required this.todo});

  final TodoItem todo;

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
        // タップ時の波紋がカードの角からはみ出さないよう、カードと同じ角丸にする
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
        onTap: () {
          context.push(AppRoutes.edit, extra: todo);
        },
        onLongPress: () => _confirmDelete(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.spaceXs,
            AppSizes.spaceM,
            AppSizes.spaceL,
            AppSizes.spaceM,
          ),
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

              const SizedBox(width: AppSizes.spaceXs),

              // Todo情報
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      maxLines: _titleMaxLines,
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
                        maxLines: _memoMaxLines,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: AppSizes.spaceM),

              // 期限（右寄せ）
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: _dateIconSize,
                    color: subColor,
                  ),
                  const SizedBox(width: AppSizes.spaceXs),
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
