import 'package:go_router/go_router.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';
import 'package:todo_app/features/todo/view/todo_edit_page.dart';
import 'package:todo_app/features/todo/view/todo_home_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const TodoHomePage()),
    GoRoute(
      path: '/edit',
      builder: (context, state) {
        final todo = state.extra as TodoItem?;

        return TodoEditPage(todo: todo);
      },
    ),
  ],
);
