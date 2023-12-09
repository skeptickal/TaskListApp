import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  void addTask({required String taskName}) {
    //taskClient.addTask(taskName);
    emit(
      state.copyWith(
        taskNames: [...state.taskNames, taskName],
        completedTasks: state.completedTasks,
      ),
    );
  }

  // void readTasks() {
  //   emit(
  //     state.copyWith(
  //       taskNames: [...state.taskNames, response.body],
  //     ),
  //   );
  // }

  void removeTask({required String taskName}) {
    //taskClient.removeTask(taskName);
    emit(state.removeTask(taskName));
  }

  void completeTask({required String taskName}) {
    emit(
      state.copyWith(
        completedTasks: [
          ...state.completedTasks,
          taskName
        ], // Add the completed task
      ),
    );
  }

  void deleteTask({required String taskName}) {
    emit(state.deleteTask(taskName));
  }
}
