import 'package:flutter/material.dart';
import 'package:todo_app/common/constants/app_texts.dart';

// Todo が 1 件もないときに表示する案内
class TodoEmptyView extends StatelessWidget {
  const TodoEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 56,
              backgroundColor: colorScheme.primary.withValues(alpha: 0.2),
              child: Icon(
                Icons.checklist_rounded,
                size: 64,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppTexts.emptyTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: colorScheme.primary,
                      child: Icon(
                        Icons.add,
                        size: 18,
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
