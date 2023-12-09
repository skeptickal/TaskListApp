import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_list_app/cubit/task_cubit.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  Color bgColor = const Color.fromARGB(255, 48, 48, 48);
  TextStyle tilesText =
      const TextStyle(color: Colors.white, letterSpacing: 2.0);
  Color iconColor = const Color.fromARGB(255, 173, 173, 173);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
      List<Widget> completedTasks = state.completedTasks.map(
        (taskName) {
          return ListTile(
            leading: Icon(
              Icons.task,
              color: iconColor,
            ),
            title: Text(
              taskName,
              style: tilesText,
            ),
            trailing: GestureDetector(
                onTap: () {
                  context.read<TaskCubit>().deleteTask(taskName: taskName);
                },
                child: Icon(Icons.delete, color: iconColor)),
          );
        },
      ).toList();

      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Completed Tasks'),
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
}
