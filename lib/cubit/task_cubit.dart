import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_list_app/models/task.dart';
import 'package:task_list_app/service/task_service.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskService taskService;

  TaskCubit({TaskService? taskService})
      : taskService = taskService ?? TaskService(),
        super(TaskInitial());

  Future<void> addTask({required Task task}) async {
    try {
      await taskService.addTask(task: task);
      emit(
        state.copyWith(
          tasks: [...state.tasks, task],
        ),
      );
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<void> readTasksByStatus(TaskStatus status) async {
    try {
      final List<Task> tasks = await taskService.readTasksByStatus(status);
      emit(state.copyWith(
        tasks: [...tasks],
      ));
    } catch (e) {
      print('Error reading tasks by status: $e');
    }
  }

 
  Future<void> updateTask({
    required Task task,
    TaskStatus? newStatus,
    String? newName,
  }) async {
    try {
      final updatedTask = task.copyWith(
        status: newStatus ?? task.status,
        name: newName ?? task.name,
      );

      await taskService.updateTask(task: updatedTask);

      final updatedTasks =
          state.tasks.map((t) => t.id == task.id ? updatedTask : t).toList();

      emit(state.copyWith(tasks: updatedTasks));
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTask({required Task task}) async {
    try {
      await taskService.deleteTask(task: task);
      emit(state.copyWith(
        tasks: state.tasks
            .map((t) =>
                t.id == task.id ? task.copyWith(status: TaskStatus.deleted) : t)
            .toList(),
      ));
    } catch (e) {
      print(e);
    }
  }
}
