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

  Future<List<Task>> readTasksByStatus(TaskStatus status) async {
    try {
      dynamic data = await client.getData(
        uri: '/${Task.getStatusString(status)}',
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

  Future<void> recoverTask({required Task task}) async {
    try {
      task = task.copyWithStatus(TaskStatus.todo);
      await client.putData(
        uri: '$taskApiBase/${task.id}/todo',
        body: task.toJson(),
      );
    } catch (e) {
      print('Error completing task: $e');
      throw Exception('Recover Task Failed');
    }
  }

  Future<void> completeTask({required Task task}) async {
    try {
      task = task.copyWithStatus(TaskStatus.completed);
      await client.putData(
        uri: '$taskApiBase/${task.id}/complete',
        body: task.toJson(),
      );
    } catch (e) {
      print('Error completing task: $e');
      throw Exception('Complete Task Failed');
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

  Future<void> recycleTask({required Task task}) async {
    try {
      task = task.copyWithStatus(TaskStatus.recycled);
      await client.putData(
        uri: '$taskApiBase/${task.id}/recycle',
        body: task.toJson(),
      );
    } catch (e) {
      print('Error recycling task: $e');
      throw Exception('Recycle Task Failed');
    }
  }
}
