import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list_app/resource/bottom_nav.dart';
import 'package:task_list_app/constants/constants.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';
import 'package:task_list_app/pages/edit_task.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().readTasks();
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        List<Widget> tasks = state.tasks.map(
          (task) {
            return ListTile(
              key: const Key('task tiles'),
              leading: GestureDetector(
                onTap: () => _showEditPanel(context, task),
                child: Icon(
                  Icons.edit,
                  color: iconColor,
                ),
              ),
              title: Text(
                task.name,
                style: tilesText,
              ),
              trailing: GestureDetector(
                  onTap: () => _onTapCompleteIcon(task),
                  child: Icon(Icons.remove_circle_outline, color: iconColor)),
            );
          },
        ).toList();
        return Scaffold(
          bottomNavigationBar: const BottomNav(),
          backgroundColor: bgColor,
          appBar: AppBar(
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            color: bgColor,
            child: EditTask(
                task: task,
                onTaskUpdated: (updatedTask) {
                  context
                      .read<TaskCubit>()
                      .updateTask(updatedTask: updatedTask);
                }),
          );
        });
  }

  void _onTapCompleteIcon(Task task) {
    context.read<TaskCubit>().completeTask(task: task);
  }
}
