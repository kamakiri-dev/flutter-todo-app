import 'package:flutter/material.dart';
import 'package:todo_app/app/theme/app_colors.dart';
import 'package:todo_app/app/theme/app_sizes.dart';
import 'package:todo_app/common/constants/app_texts.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';

// 影のぼかし具合と、下方向へのずれ
const double _shadowBlurRadius = 12.0;
const Offset _shadowOffset = Offset(0, 4);
// 進捗バーの太さ
const double _progressBarHeight = 8.0;

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
      margin: const EdgeInsets.fromLTRB(
        AppSizes.spaceL,
        AppSizes.spaceL,
        AppSizes.spaceL,
        AppSizes.spaceS,
      ),
      padding: const EdgeInsets.all(AppSizes.spaceL),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: _shadowBlurRadius,
            offset: _shadowOffset,
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
          const SizedBox(height: AppSizes.spaceM),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusL),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: _progressBarHeight,
              color: colorScheme.primary,
              backgroundColor: AppColors.card,
            ),
          ),
        ],
      ),
    );
  }
}
