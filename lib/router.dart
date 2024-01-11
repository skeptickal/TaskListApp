import 'package:go_router/go_router.dart';
import 'package:task_list_app/pages/add_task.dart';
import 'package:task_list_app/pages/completed_tasks.dart';
import 'package:task_list_app/pages/recycle_task.dart';
import 'package:task_list_app/pages/task_list.dart';
import 'package:flutter/material.dart';

CustomTransitionPage buildPageWithRightSlideTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

CustomTransitionPage buildPageWithLeftSlideTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

GoRouter router({String initialLocation = '/'}) => GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const TaskList();
          },
        ),
        GoRoute(
          path: '/add_task',
          pageBuilder: (context, state) =>
              buildPageWithRightSlideTransition<void>(
            context: context,
            state: state,
            child: const AddTaskScreen(),
          ),
        ),
        GoRoute(
          path: '/completed_tasks',
          pageBuilder: (context, state) =>
              buildPageWithLeftSlideTransition<void>(
            context: context,
            state: state,
            child: const CompletedTaskScreen(),
          ),
        ),
        GoRoute(
          path: '/recycle',
          builder: (BuildContext context, GoRouterState state) {
            return const RecycleTaskScreen();
          },
        ),
      ],
      initialLocation: initialLocation,
    );
