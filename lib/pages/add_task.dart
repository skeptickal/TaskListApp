import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
      backgroundColor: const Color.fromARGB(255, 48, 48, 48),
      appBar: AppBar(
        title: const Text(
          'Add a Task',
          style: TextStyle(letterSpacing: 2.0, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _addTask,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 255, 255, 255),
                hintText: 'Add a Task here',
              ),
            ),
          ),
          ElevatedButton.icon(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                context.read<TaskCubit>().addTask(taskName: Task(id: null, name: _addTask.text));
                _addTask.clear();
                context.go('/');
              },
              label: const Text('Add Task',
                  style: TextStyle(letterSpacing: 2.0, color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black)),
        ],
      ),
    );
  }
}
