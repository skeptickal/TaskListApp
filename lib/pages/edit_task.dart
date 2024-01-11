import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/constants/constants.dart';
import 'package:task_list_app/models/task.dart';

class EditTask extends StatelessWidget {
  final Task task;
  final Function(String) onTaskUpdated;
  final TextStyle editTasksTextStyle = TextStyle(color: white, fontSize: 20);

  EditTask({
    Key? key,
    required this.task,
    required this.onTaskUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController editTask = TextEditingController(text: task.name);
    return Form(
      key: const Key('edit_task_form'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 42),
            child: TextField(
              style: TextStyle(color: iconColor),
              controller: editTask,
              decoration: InputDecoration(
                labelText: 'Edit Task Name',
                labelStyle: editTasksTextStyle,
              ),
            ),
          ),
          ElevatedButton(
            key: const Key('edit_task_button'),
            style: ElevatedButton.styleFrom(
              backgroundColor: black,
            ),
            onPressed: () => editATask(context, editTask),
            child: Text(
              'Save',
              style: editTasksTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  void editATask(BuildContext context, TextEditingController editTask) {
    onTaskUpdated(editTask.text);
    context.pop(context);
  }
}
