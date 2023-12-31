import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            leading: const Icon(
              Icons.check,
              color: Colors.green,
            ),
            title: Text(
              task.name,
              style: tilesText,
            ),
            trailing: GestureDetector(
                onTap: () => _onTapTrashIcon(task),
                child: Icon(Icons.delete, color: iconColor)),
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
    context.read<TaskCubit>().deleteTask(task: task);
  }
}
