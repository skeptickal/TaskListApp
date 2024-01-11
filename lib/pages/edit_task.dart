import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/constants/constants.dart';
import 'package:task_list_app/models/task.dart';

class EditTask extends StatelessWidget {
  final Task task;
  final Function(String) onTaskUpdated;

  const EditTask({super.key, required this.task, required this.onTaskUpdated});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(text: task.name);

    return Form(
      key: const Key('edit_task_form'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 42),
            child: TextField(
              style: TextStyle(color: iconColor),
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Edit Task Name',
                labelStyle: TextStyle(color: white, fontSize: 20),
              ),
            ),
          ),
          ElevatedButton(
            key: const Key('edit_task_button'),
            style: ElevatedButton.styleFrom(
              backgroundColor: black,
            ),
            onPressed: () {
              final String updatedTaskName = controller.text;
              onTaskUpdated(updatedTaskName);
              context.pop(context);
            },
            child: Text(
              'Save',
              style: TextStyle(color: white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
