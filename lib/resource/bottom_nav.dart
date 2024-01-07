import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/constants/constants.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(height: 50, backgroundColor: black, destinations: [
      IconButton(
          key: const Key('Completed Tasks'),
          onPressed: () => context.go('/completed_tasks'),
          icon: Icon(
            Icons.list,
            color: white,
          )),
      IconButton(
          key: const Key('Home'),
          onPressed: () => context.go('/'),
          icon: Icon(Icons.home, color: white)),
      IconButton(
          key: const Key('Add Task'),
          onPressed: () => context.go('/add_task'),
          icon: Icon(
            Icons.add,
            color: white,
          )),
    ]);
  }
}
