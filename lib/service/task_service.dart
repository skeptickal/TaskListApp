import 'package:task_list_app/client/backend_client.dart';
import 'package:task_list_app/models/task.dart';

class TaskService {
  const TaskService();
  static const String taskApiBase = '/tasks';

  Future<void> addTask({required Task taskName}) async {}

  Future<List<Task>> readTasks() async {
    BackendClient client = const BackendClient();
    List<Map<String, String>> apiTask = await client.getData(uri: taskApiBase);
    return apiTask.map((task) => Task.fromJson(task)).toList();
  }

  Future<void> removeTask({required Task taskName}) async {}

  Future<void> completeTask({required Task taskName}) async {}

  Future<void> deleteTask({required Task taskName}) async {}
}
