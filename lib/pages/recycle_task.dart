import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/resource/bottom_nav.dart';
import 'package:task_list_app/constants/constants.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';

class RecycleTaskScreen extends StatefulWidget {
  const RecycleTaskScreen({super.key});

  @override
  State<RecycleTaskScreen> createState() => _RecycleTaskScreenState();
}

class _RecycleTaskScreenState extends State<RecycleTaskScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().readTasks();
    return BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
      List<Widget> recycledTasks = state.tasks.map(
        (task) {
          return ListTile(
            key: const Key('completed tiles'),
            leading: IconButton(
              icon: const Icon(Icons.recycling),
              color: Colors.blueGrey,
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
            'Recycled Tasks',
            style: TextStyle(color: white),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: recycledTasks.length,
          itemBuilder: (context, index) {
            return recycledTasks[index];
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
            'Recover or Delete Task?',
            style: TextStyle(color: white),
          ),
          actions: [
            TextButton(
              child: Text(
                'Recover Task',
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
