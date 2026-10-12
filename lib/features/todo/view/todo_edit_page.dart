import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/common/constants/app_texts.dart';
import 'package:todo_app/common/formatter/date_formatter.dart';
import 'package:todo_app/common/validator/todo_validator.dart';
import 'package:todo_app/features/todo/bloc/todo_bloc.dart';
import 'package:todo_app/features/todo/bloc/todo_event.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';

const double _padding = 16.0;

class TodoEditPage extends StatelessWidget {
  const TodoEditPage({super.key, this.todo});

  final TodoItem? todo;

  Future<void> _selectDate(
    BuildContext context,
    FormFieldState<DateTime> field,
  ) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: field.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      field.didChange(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final labelStyle = theme.textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.bold,
    );

    final title = todo?.title ?? '';
    final memo = todo?.memo ?? '';
    final date = todo?.date ?? DateTime.now();

    final pageTitle = todo == null ? AppTexts.todoCreate : AppTexts.todoEdit;

    // 保存時にFormから値を受け取る
    String inputTitle = title;
    String inputMemo = memo;
    DateTime inputDate = date;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(pageTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: _padding,
            children: [
              Text(AppTexts.todoTitle, style: labelStyle),

              TextFormField(
                initialValue: title,
                validator: TodoValidator.validateTitle,
                autovalidateMode: AutovalidateMode.onUnfocus,
                onSaved: (value) {
                  inputTitle = value ?? '';
                },
                decoration: InputDecoration(
                  hintText: AppTexts.titleHint,
                  errorStyle: TextStyle(color: colorScheme.error),
                ),
              ),

              Text(AppTexts.todoDate, style: labelStyle),

              FormField<DateTime>(
                initialValue: date,
                onSaved: (value) {
                  inputDate = value ?? date;
                },
                builder: (field) {
                  return InkWell(
                    onTap: () => _selectDate(context, field),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      child: Text(DateFormatter.format(field.value ?? date)),
                    ),
                  );
                },
              ),

              Text(AppTexts.todoMemo, style: labelStyle),

              TextFormField(
                initialValue: memo,
                onSaved: (value) {
                  inputMemo = value ?? '';
                },
                maxLines: 4,
                minLines: 2,
                decoration: const InputDecoration(hintText: AppTexts.memoHint),
              ),

              SizedBox(
                width: double.infinity,
                child: Builder(
                  builder: (formContext) {
                    return FilledButton(
                      onPressed: () {
                        final form = Form.of(formContext);

                        if (!form.validate()) {
                          return;
                        }

                        form.save();

                        final savedTodo =
                            todo?.copyWith(
                              title: inputTitle,
                              memo: inputMemo,
                              date: inputDate,
                            ) ??
                            TodoItem(
                              id: 0,
                              title: inputTitle,
                              memo: inputMemo,
                              date: inputDate,
                            );

                        context.read<TodoBloc>().add(TodoSaved(savedTodo));

                        context.pop();
                      },
                      child: const Text(AppTexts.todoSave),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
