import 'dart:ffi';

import 'package:task_list_app/client/backend_client.dart';
import 'package:task_list_app/models/Task.dart';

class TaskService {
  const TaskService();
  static const String taskApiBase = '/tasks';

  Future<void> addTask({required Task taskName}) async {}

  Future<List<Task>> readTasks() async {
    BackendClient client = const BackendClient();
    List<Map<Long, String>> nonTask = await client.getData(uri: taskApiBase);
    List<Task> tasks = nonTask.map((task) {
      return Task(id: task['id'] ?? 0, name: task['name'] ?? '');
    }).toList();

    return tasks;
  }

  Future<void> removeTask({required Task taskName}) async {}

  Future<void> completeTask({required Task taskName}) async {}

  Future<void> deleteTask({required Task taskName}) async {}
}
