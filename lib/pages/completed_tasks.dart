import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/resource/bottom_nav.dart';
import 'package:task_list_app/constants/constants.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';

class CompletedTaskScreen extends StatelessWidget {
  const CompletedTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().readTasksByStatus(TaskStatus.completed);
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        List<Widget> completedTasks = state.tasks.map(
          (task) {
            return ListTile(
              key: const Key('completed_tiles'),
              leading: const Icon(
                Icons.check,
                color: Colors.green,
              ),
              title: Text(
                task.name,
                style: tilesText,
              ),
              trailing: IconButton(
                key: const Key('completed_trash_icon'),
                onPressed: () => _onTapTrashIcon(context, task),
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
            itemBuilder: (context, index) => completedTasks[index],
          ),
        );
      },
    );
  }

  void _onTapTrashIcon(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        key: const Key('incomplete_or_delete'),
        surfaceTintColor: bgColor,
        backgroundColor: bgColor,
        title: Text(
          'Mark as Incomplete or Delete Task?',
          style: TextStyle(color: white),
        ),
        actions: [
          TextButton(
            key: const Key('complete_mark_incomplete'),
            child: Text(
              'Mark Incomplete',
              style: TextStyle(color: white),
            ),
            onPressed: () => _markIncomplete(context, task),
          ),
          TextButton(
            key: const Key('complete_mark_deleted'),
            child: Text(
              'Delete Permanently',
              style: TextStyle(color: white),
            ),
            onPressed: () => _deletePermanently(context, task),
          ),
        ],
      ),
    );
  }

  void _markIncomplete(BuildContext context, Task task) {
    context.read<TaskCubit>().updateTask(task: task, newStatus: TaskStatus.todo).then((result) {
      context.read<TaskCubit>().readTasksByStatus(TaskStatus.completed);
      context.pop();
    });
  }

  void _deletePermanently(BuildContext context, Task task) {
    context.read<TaskCubit>().deleteTask(task: task).then((result) {
      context.read<TaskCubit>().readTasksByStatus(TaskStatus.completed);
      context.pop();
    });
  }
}
