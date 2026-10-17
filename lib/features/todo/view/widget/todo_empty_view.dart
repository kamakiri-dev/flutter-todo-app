import 'package:flutter/material.dart';
import 'package:todo_app/app/theme/app_colors.dart';
import 'package:todo_app/app/theme/app_sizes.dart';
import 'package:todo_app/common/constants/app_texts.dart';

// 中央の大きなアイコン（円の半径とアイコンの大きさ）
const double _iconCircleRadius = 56.0;
const double _iconSize = 64.0;
// 案内文の中に出す ＋ ボタンの絵（円の半径とアイコンの大きさ）
const double _addBadgeRadius = 12.0;
const double _addBadgeIconSize = 18.0;

// Todo が 1 件もないときに表示する案内
class TodoEmptyView extends StatelessWidget {
  const TodoEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceXxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: _iconCircleRadius,
              backgroundColor: AppColors.primaryLight,
              child: Icon(
                Icons.checklist_rounded,
                size: _iconSize,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: AppSizes.spaceXl),
            Text(
              AppTexts.emptyTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spaceM),
            Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: CircleAvatar(
                      radius: _addBadgeRadius,
                      backgroundColor: colorScheme.primary,
                      child: Icon(
                        Icons.add,
                        size: _addBadgeIconSize,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const TextSpan(text: AppTexts.emptyMessage),
                ],
              ),
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
