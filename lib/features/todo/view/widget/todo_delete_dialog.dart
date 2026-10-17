import 'package:flutter/material.dart';
import 'package:todo_app/app/theme/app_sizes.dart';
import 'package:todo_app/common/constants/app_texts.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';

// 削除前の確認ダイアログ
class TodoDeleteDialog extends StatelessWidget {
  const TodoDeleteDialog({super.key, required this.todo});

  final TodoItem todo;

  // ダイアログを表示し、「削除」が押されたら true を返す
  static Future<bool> show(BuildContext context, TodoItem todo) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => TodoDeleteDialog(todo: todo),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AlertDialog(
      icon: Icon(
        Icons.delete_outline,
        size: AppSizes.dialogIcon,
        color: colorScheme.error,
      ),
      title: const Text(AppTexts.deleteConfirmTitle),
      content: Text(
        AppTexts.deleteConfirmMessage(todo.title),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(AppTexts.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
          ),
          child: const Text(AppTexts.delete),
        ),
      ],
    );
  }
}
