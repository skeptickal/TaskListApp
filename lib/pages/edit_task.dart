import 'package:flutter/material.dart';
import 'package:task_list_app/constants/constants.dart';
import 'package:task_list_app/models/task.dart';

class EditTask extends StatefulWidget {
  final Task taskName;
  final Function(Task) onTaskUpdated;
  const EditTask(
      {super.key, required this.taskName, required this.onTaskUpdated});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.taskName.name);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: const Key('Form'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 42),
              child: TextField(
                style: TextStyle(color: iconColor),
                controller: _controller,
                decoration: const InputDecoration(
                    labelText: 'Edit Task Name',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                // Get the updated taskName from the TextField
                final String updatedTaskName = _controller.text;

                // Create a new TaskName object with the updated name
                final Task updatedTask =
                    Task(id: widget.taskName.id, name: updatedTaskName);

                // Call the callback function to return the updated taskName
                widget.onTaskUpdated(updatedTask);

                // Close the edit panel
                Navigator.pop(context);
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ));
  }
}
