import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/theme/app_colors.dart';
import 'package:todo_app/common/formatter/date_formatter.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';

const double _cardHorizontalPadding = 16.0;
const double _cardVerticalPadding = 14.0;
const double _iconTextSpacing = 12.0;
const double _titleDateSpacing = 6.0;
const double _cardRadius = 12.0;
const double _cardElevation = 2.0;

class TodoItemCard extends StatelessWidget {
  final TodoItem todo;

  const TodoItemCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      color: AppColors.card,
      elevation: _cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(_cardRadius),
        onTap: () {
          context.push('/edit', extra: todo);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: _cardHorizontalPadding,
            vertical: _cardVerticalPadding,
          ),
          child: Row(
            children: [
              // チェックボックス
              Checkbox(
                value: todo.isCompleted,
                onChanged: (value) {
                  // Todoの完了状態を変更
                },
              ),

              const SizedBox(width: _iconTextSpacing),

              // Todo情報
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: _titleDateSpacing),

                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 14.0,
                          color: colorScheme.onSecondary,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          DateFormatter.format(todo.date),
                          style: TextStyle(
                            fontSize: 13.0,
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
