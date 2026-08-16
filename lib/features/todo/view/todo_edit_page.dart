import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/common/constants/app_texts.dart';
import 'package:todo_app/common/formatter/date_formatter.dart';
import 'package:todo_app/common/validator/todo_validator.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';

const double _padding = 16.0;

class TodoEditPage extends StatelessWidget {
  const TodoEditPage({super.key, this.todo});

  final TodoItem? todo;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      // Blocにイベントを送る
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final title = todo?.title ?? '';
    final memo = todo?.memo ?? '';
    final date = todo?.date ?? DateTime.now();
    final formattedDate = DateFormatter.format(date);
    final pageTitle = todo == null ? AppTexts.todoCreate : AppTexts.todoEdit;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(pageTitle),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: _padding,
            children: [
              const Text(AppTexts.todoTitle),
              TextFormField(
                initialValue: title,
                validator: TodoValidator.validateTitle,
                autovalidateMode: AutovalidateMode.onUnfocus,
                decoration: InputDecoration(
                  hintText: AppTexts.titleHint,
                  hintStyle: TextStyle(color: colorScheme.onSecondary),
                  errorStyle: TextStyle(color: colorScheme.error),
                  border: OutlineInputBorder(),
                ),
              ),

              const Text(AppTexts.todoDate),
              TextFormField(
                readOnly: true,
                onTap: () => _selectDate(context),
                initialValue: formattedDate,
                decoration: InputDecoration(
                  hintText: AppTexts.dateHint,
                  hintStyle: TextStyle(color: colorScheme.onSecondary),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),

              const Text(AppTexts.todoMemo),
              TextFormField(
                initialValue: memo,
                decoration: InputDecoration(
                  hintText: AppTexts.memoHint,
                  hintStyle: TextStyle(color: colorScheme.onSecondary),
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text(AppTexts.todoSave),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
