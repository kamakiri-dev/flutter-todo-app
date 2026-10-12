import 'package:flutter/material.dart';
import 'package:todo_app/common/constants/app_texts.dart';

// 保存・削除・読み込みなどに失敗したときのエラーダイアログ
class TodoErrorDialog extends StatelessWidget {
  const TodoErrorDialog({super.key});

  // OK が押されるまで閉じないようにする
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const TodoErrorDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AlertDialog(
      icon: Icon(Icons.error_outline, size: 32.0, color: colorScheme.error),
      title: const Text(AppTexts.errorTitle),
      content: const Text(AppTexts.errorMessage, textAlign: TextAlign.center),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppTexts.ok),
        ),
      ],
    );
  }
}
