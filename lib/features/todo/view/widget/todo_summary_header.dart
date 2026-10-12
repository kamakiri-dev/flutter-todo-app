import 'package:flutter/material.dart';
import 'package:todo_app/app/theme/app_colors.dart';
import 'package:todo_app/common/constants/app_texts.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';

const double _radius = 16.0;

// 一覧の上に出す進捗サマリー
class TodoSummaryHeader extends StatelessWidget {
  const TodoSummaryHeader({super.key, required this.todos});

  final List<TodoItem> todos;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final total = todos.length;
    final done = todos.where((todo) => todo.isCompleted).length;
    final progress = total == 0 ? 0.0 : done / total;

    return Container(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppTexts.remaining(total - done),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                AppTexts.progress(done, total),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(_radius),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8.0,
              color: colorScheme.primary,
              backgroundColor: AppColors.card,
            ),
          ),
        ],
      ),
    );
  }
}
