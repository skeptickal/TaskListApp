import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/resource/bottom_nav.dart';
import 'package:task_list_app/constants/constants.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';
import 'package:task_list_app/pages/edit_task.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().readTasksByStatus(TaskStatus.todo);
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        List<Widget> tasks = state.tasks.map(
          (task) {
            return ListTile(
              key: const Key('task_tiles'),
              leading: IconButton(
                onPressed: () => _showEditPanel(context, task),
                icon: Icon(
                  key: const Key('edit_icon'),
                  Icons.edit,
                  color: iconColor,
                ),
              ),
              title: Text(
                task.name,
                style: tilesText,
              ),
              trailing: IconButton(
                  key: const Key('move_task_icon'),
                  onPressed: () => _onTapCompleteIcon(context, task),
                  icon: const Icon(Icons.remove_circle_outline, color: Colors.green)),
            );
          },
        ).toList();
        return Scaffold(
          bottomNavigationBar: const BottomNav(),
          backgroundColor: bgColor,
          appBar: AppBar(
            actions: [IconButton(key: const Key('go_to_recycle_bin'), onPressed: () => context.go('/recycle'), icon: const Icon(Icons.recycling))],
            iconTheme: IconThemeData(color: iconColor),
            title: Text(
              'Task List',
              style: TextStyle(color: white),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return tasks[index];
            },
          ),
        );
      },
    );
  }

  void _showEditPanel(BuildContext context, Task task) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            key: const Key('edit_container'),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            color: bgColor,
            child: EditTask(
                task: task,
                onTaskUpdated: (String? newName) {
                  context.read<TaskCubit>().updateTask(task: task, newName: newName);
                }),
          );
        });
  }

  void _onTapCompleteIcon(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        key: const Key('complete_or_recycle'),
        title: Text(
          'Complete or Recycle Task?',
          style: TextStyle(color: white),
        ),
        backgroundColor: bgColor,
        surfaceTintColor: bgColor,
        actions: [
          TextButton(
            key: const Key('incomplete_mark_complete'),
            child: Text(
              'Complete',
              style: TextStyle(color: white),
            ),
            onPressed: () => _markComplete(context, task),
          ),
          TextButton(
            key: const Key('incomplete_mark_recycled'),
            child: Text(
              'Recycle',
              style: TextStyle(color: white),
            ),
            onPressed: () => _recycleTask(context, task),
          ),
        ],
      ),
    );
  }

  void _recycleTask(BuildContext context, Task task) {
    context.read<TaskCubit>().updateTask(task: task, newStatus: TaskStatus.recycled).then((result) {
      context.read<TaskCubit>().readTasksByStatus(TaskStatus.todo);
      context.pop();
    });
  }

  void _markComplete(BuildContext context, Task task) {
    context.read<TaskCubit>().updateTask(task: task, newStatus: TaskStatus.completed).then((result) {
      context.read<TaskCubit>().readTasksByStatus(TaskStatus.todo);
      context.pop();
    });
  }
}
