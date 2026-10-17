import 'package:go_router/go_router.dart';
import 'package:todo_app/app/router/app_routes.dart';
import 'package:todo_app/features/todo/model/todo_item.dart';
import 'package:todo_app/features/todo/view/todo_edit_page.dart';
import 'package:todo_app/features/todo/view/todo_home_page.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const TodoHomePage(),
    ),
    GoRoute(
      path: AppRoutes.edit,
      builder: (context, state) {
        final todo = state.extra as TodoItem?;

        return TodoEditPage(todo: todo);
      },
    ),
  ],
);
