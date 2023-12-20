import 'package:task_list_app/client/backend_client.dart';
import 'package:task_list_app/models/task.dart';

class TaskService {
  TaskService();
  static const String taskApiBase = '/tasks';
  BackendClient client = BackendClient();

  Future<void> addTask({required Task taskName}) async {
    try {
      await client.postData(
        uri: taskApiBase,
        body: taskName.toJson(),
      );
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<List<Task>> readTasks() async {
    dynamic data = await client.getData(uri: taskApiBase);
    List<Task> tasks =
        List<Task>.from(data.map((taskData) => Task.fromJson(taskData)));
    print(data);
    return tasks;
  }

  Future<void> removeTask({required Task taskName}) async {}

  Future<void> completeTask({required Task taskName}) async {}

  Future<void> deleteTask({required Task taskName}) async {}
}
