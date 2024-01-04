import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/constants/constants.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _addTask = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Add a Task',
          style: TextStyle(letterSpacing: 2.0, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const Key('Add a task text field'),
              controller: _addTask,
              decoration: InputDecoration(
                filled: true,
                fillColor: white,
                hintText: 'Add a Task here',
              ),
            ),
          ),
          ElevatedButton.icon(
              key: const Key('Add Task Button'),
              icon: Icon(
                Icons.add,
                color: white,
              ),
              onPressed: () {
                context
                    .read<TaskCubit>()
                    .addTask(taskName: Task(name: _addTask.text));
                _addTask.clear();
                context.go('/');
              },
              label:  Text('Add Task',
                  style: TextStyle(letterSpacing: 2.0, color: white)),
              style: ElevatedButton.styleFrom(backgroundColor: black)),
        ],
      ),
    );
  }
}
