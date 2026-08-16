import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/common/constants/app_texts.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';
import 'package:todo_app/features/todo/view/widget/todo_item_card.dart';

class TodoHomePage extends StatelessWidget {
  TodoHomePage({super.key});

  final List<TodoItem> todos = [
    TodoItem(
      id: 1,
      title: 'Flutterを勉強する',
      memo: 'Todoアプリを作る',
      date: DateTime(2026, 8, 20),
      isCompleted: true,
    ),
    TodoItem(
      id: 2,
      title: 'Englishを勉強する',
      memo: 'Todoアプリを作る',
      date: DateTime(2026, 9, 1),
      isCompleted: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        title: const Text(AppTexts.todoList),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.perm_identity),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.info)),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return TodoItemCard(todo: todo);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/edit');
        },
        backgroundColor: colorScheme.primary,
        child: Icon(Icons.add, color: colorScheme.onPrimary),
      ),
    );
  }
}
