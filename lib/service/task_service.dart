import 'package:task_list_app/client/backend_client.dart';
import 'package:task_list_app/models/task.dart';

class TaskService {
  static const String taskApiBase = '/tasks';

  final BackendClient client;

  TaskService({BackendClient? client}) : client = client ?? BackendClient();

  Future<void> addTask({required Task task}) async {
    try {
      await client.postData(
        uri: taskApiBase,
        body: task.toJson(),
      );
    } catch (e) {
      print('Error adding task: $e');
      throw Exception('Add Task Failed');
    }
  }

  Future<List<Task>> readTasks() async {
    dynamic data = await client.getData(uri: taskApiBase);
    List<Task> tasks =
        List<Task>.from(data.map((taskData) => Task.fromJson(taskData)));
    print(data);
    return tasks;
  }

  Future<void> editTask({required Task task}) async {
    try {
      await client.putData(
        uri: '$taskApiBase/${task.id}',
        body: task.toJson(),
      );
    } catch (e) {
      print('Error editing task: $e');
      throw Exception('Edit Task Failed');
    }
  }

  Future<void> completeTask({required Task task}) async {}

  Future<void> deleteTask({required Task task}) async {}
}
