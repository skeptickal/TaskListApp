import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_list_app/models/task.dart';
import 'package:task_list_app/service/task_service.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  TaskService service = TaskService();

  void addTask({required Task taskName}) {
    service.addTask(taskName: taskName);
    emit(
      state.copyWith(
        taskNames: [...state.taskNames, taskName],
        completedTasks: state.completedTasks,
      ),
    );
  }

  Future<void> readTasks() async {
    List<Task> tasks = await service.readTasks();
    emit(state.copyWith(
      taskNames: [...tasks],
    ));
  }

  void removeTask({required Task taskName}) {
    //taskClient.removeTask(taskName);
    emit(state.removeTask(taskName));
  }

  void completeTask({required Task taskName}) {
    emit(
      state.copyWith(
        completedTasks: [
          ...state.completedTasks,
          taskName
        ], // Add the completed task
      ),
    );
  }

  void deleteTask({required Task taskName}) {
    emit(state.deleteTask(taskName));
  }
}
