import 'package:task_list_app/client/backend_client.dart';

class TaskService {
  const TaskService();
  static const String taskApiBase = '/tasks';

  Future<void> addTask({required String taskName}) async {}

  Future<String> readTasks() async {
    BackendClient client = const BackendClient();
    return await client.getData(uri: taskApiBase);
  }

  Future<void> removeTask({required String taskName}) async {}

  Future<void> completeTask({required String taskName}) async {}

  Future<void> deleteTask({required String taskName}) async {}
}
