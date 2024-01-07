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
        List<Task> tasks =
            List<Task>.from(data.map((taskData) => Task.fromJson(taskData)));
        return tasks;
      } else {
        print('Unexpected response format: $data');
        return [];
      }
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  Future<void> updateTask({
    required Task task,
    TaskStatus? newStatus,
  }) async {
    try {
      if (newStatus != null) {
        task = task.copyWithStatus(newStatus);
        await client.putData(
          uri: '$taskApiBase/${task.id}/${Task.getStatusString(newStatus)}',
          body: task.toJson(),
        );
      } else {
        await client.putData(
          uri: '$taskApiBase/${task.id}',
          body: task.toJson(),
        );
      }
    } catch (e) {
      print('Error updating task: $e');
      throw Exception('Update Task Failed');
    }
  }

  Future<void> deleteTask({required Task task}) async {
    try {
      task = task.copyWithStatus(TaskStatus.deleted);
      await client.deleteData(
        uri: '$taskApiBase/${task.id}/delete',
      );
    } catch (e) {
      print('Error deleting task: $e');
      throw Exception('Delete Task Failed');
    }
  }
}
