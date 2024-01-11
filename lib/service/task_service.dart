import 'package:task_list_app/client/backend_client.dart';
import 'package:task_list_app/models/task.dart';

class TaskService {
  static const String taskApiBase = '/tasks';

  final BackendClient client;

  TaskService({BackendClient? client}) : client = client ?? BackendClient();

  Future<void> addTask({required Task task, TaskStatus? status}) async {
    try {
      task = task.copyWithStatus(TaskStatus.todo);
      await client.postData(
        uri: taskApiBase,
        body: task.toJson(),
      );
    } catch (e) {
      print('Error adding task: $e');
      throw Exception('Add Task Failed');
    }
  }

  Future<List<Task>> readTasksByStatus(TaskStatus status) async {
    try {
      dynamic data = await client.getData(
        uri: '/tasks',
        queryParams: {'status': Task.getStatusString(status)},
      );

      if (data is List) {
        return List<Task>.from(data.map((taskData) => Task.fromJson(taskData)));
      } else {
        throw Exception('Unexpected response format: $data');
      }
    } catch (e) {
      print('Error fetching tasks: $e');
      throw Exception('Error fetching tasks: $e');
    }
  }

  Future<void> updateTask({
    required Task task,
  }) async {
    try {
      await client.putData(
        uri: '$taskApiBase/${task.id}',
        body: task.toJson(),
      );
    } catch (e) {
      print('Error updating task: $e');
      throw Exception('Update Task Failed');
    }
  }

  Future<void> deleteTask({required Task task}) async {
    try {
      task = task.copyWithStatus(TaskStatus.deleted);
      await client.deleteData(
        uri: '$taskApiBase/${task.id}',
      );
    } catch (e) {
      print('Error deleting task: $e');
      throw Exception('Delete Task Failed');
    }
  }
}
