import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
            key: const Key('completed tiles'),
            leading: Icon(
              Icons.task,
              color: iconColor,
            ),
            title: Text(
              taskName.name,
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
          leading: IconButton(
            icon: Icon(
              Icons.home,
              color: iconColor,
            ),
            onPressed: () => context.go('/'),
          ),
          backgroundColor: Colors.black,
          title: const Text(
            'Completed Tasks',
            style: TextStyle(color: Colors.white),
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
}
