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

  Future<void> readTasks() async {
    final List<Task> tasks = await taskService.readTasks();
    emit(state.copyWith(
      tasks: [...tasks],
    ));
  }

  Future<void> completeTask({required Task task}) async {}

  Future<void> deleteTask({required Task task}) async {}

  Future<void> updateTask({required Task updatedTask}) async {
    try {
      await taskService.editTask(task: updatedTask);

      // Find the index of the updated task in the tasks list
      int indexOfUpdatedTask =
          state.tasks.indexWhere((task) => task.id == updatedTask.id);

      if (indexOfUpdatedTask != -1) {
        List<Task> updatedTaskNames = List.from(state.tasks);
        updatedTaskNames[indexOfUpdatedTask] = updatedTask;

        emit(state.copyWith(
          tasks: updatedTaskNames,
        ));
      } else {
        print('Task not found in tasks list.');
      }
    } catch (e) {
      print('Error updating task: $e');
    }
  }
}
