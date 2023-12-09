part of 'task_cubit.dart';

@immutable
class TaskState extends Equatable {
  final List<String> taskNames;
  final String? taskName;
  final List<String> completedTasks;
  @override
  List<Object?> get props => [
        taskName, taskNames, completedTasks
        // all properties here, comma separated
      ];
  const TaskState(
      {required this.taskNames, this.taskName, required this.completedTasks});

  TaskState copyWith(
      {List<String>? taskNames, required List<String> completedTasks}) {
    return TaskState(
        taskNames: taskNames ?? this.taskNames, completedTasks: completedTasks);
  }

  TaskState removeTask(String taskNameToRemove) {
    List<String> newTaskNames = List.from(taskNames);
    newTaskNames.remove(taskNameToRemove);
    return TaskState(
        taskNames: newTaskNames,
        taskName: taskName,
        completedTasks: completedTasks);
  }

  TaskState completeTask({List<String>? completedTasks}) {
    return TaskState(
        taskNames: taskNames,
        completedTasks: completedTasks ?? this.completedTasks);
  }

  TaskState deleteTask(String taskNameToRemove) {
    List<String> newCompletedTasks = List.from(completedTasks);
    newCompletedTasks.remove(taskNameToRemove);
    return TaskState(
        taskNames: taskNames,
        taskName: taskName,
        completedTasks: newCompletedTasks);
  }
}

final class TaskInitial extends TaskState {
  TaskInitial()
      : super(
          taskNames: [],
          completedTasks: [],
        );
}
