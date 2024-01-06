import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/resource/bottom_nav.dart';
import 'package:task_list_app/constants/constants.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().readTasks();
    return BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
      List<Widget> completedTasks = state.tasks.map(
        (task) {
          return ListTile(
            key: const Key('completed tiles'),
            leading: IconButton(
              icon: const Icon(Icons.check),
              color: Colors.green,
              onPressed: () {},
            ),
            title: Text(
              task.name,
              style: tilesText,
            ),
            trailing: IconButton(
              onPressed: () => _onTapTrashIcon(task),
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            ),
          );
        },
      ).toList();

      return Scaffold(
        bottomNavigationBar: const BottomNav(),
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Completed Tasks',
            style: TextStyle(color: white),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: completedTasks.length,
          itemBuilder: (context, index) {
            return completedTasks[index];
          },
        ),
      );
    });
  }

  void _onTapTrashIcon(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          surfaceTintColor: bgColor,
          backgroundColor: bgColor,
          title: Text(
            'Mark as Incomplete or Delete Task?',
            style: TextStyle(color: white),
          ),
          actions: [
            TextButton(
              child: Text(
                'Mark Incomplete',
                style: TextStyle(color: white),
              ),
              onPressed: () => context.pop(),
            ),
            TextButton(
              child: Text(
                'Delete Permanently',
                style: TextStyle(color: white),
              ),
              onPressed: () => context.pop(),
            ),
          ]),
    );
    context.read<TaskCubit>().deleteTask(task: task);
  }
}
