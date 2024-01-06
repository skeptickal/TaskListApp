import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/resource/bottom_nav.dart';
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
      bottomNavigationBar: const BottomNav(),
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Add a Task',
          style: TextStyle(color: white),
        ),
        centerTitle: true,
        backgroundColor: black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: TextField(
              key: const Key('Add a task text field'),
              controller: _addTask,
              decoration: InputDecoration(
                labelText: 'e.g. walk the dog, do the dishes...',
                labelStyle: TextStyle(color: white, fontSize: 14),
              ),
            ),
          ),
          IconButton(
              key: const Key('Add Task Button'),
              icon: Icon(
                Icons.add,
                color: white,
              ),
              onPressed: () {
                context
                    .read<TaskCubit>()
                    .addTask(task: Task(name: _addTask.text));
                _addTask.clear();
                context.go('/');
              },
              style: ElevatedButton.styleFrom(backgroundColor: black)),
        ],
      ),
    );
  }
}
