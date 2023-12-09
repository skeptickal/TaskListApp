import 'package:go_router/go_router.dart';
import 'package:task_list_app/pages/add_task.dart';
import 'package:task_list_app/pages/completed_tasks.dart';
import 'package:task_list_app/pages/task_list.dart';
import 'package:flutter/material.dart';

GoRouter router({String initialLocation = '/'}) => GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const TaskList();
          },
        ),
        GoRoute(
          path: '/addtask',
          builder: (BuildContext context, GoRouterState state) {
            return const AddTaskScreen();
          },
        ),
        GoRoute(
          path: '/completed_tasks',
          builder: (BuildContext context, GoRouterState state) {
            return const CompletedTaskScreen();
          },
        ),
      ],
      initialLocation: initialLocation,
    );
