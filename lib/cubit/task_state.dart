part of 'task_cubit.dart';

@immutable
class TaskState extends Equatable {
  final List<Task> taskNames;
  final Task? taskName;
  final List<Task> completedTasks;
  @override
  List<Object?> get props => [
        taskName, taskNames, completedTasks
        // all properties here, comma separated
      ];
  const TaskState(
      {required this.taskNames, this.taskName, required this.completedTasks});

  TaskState copyWith({List<Task>? taskNames, List<Task>? completedTasks}) {
    return TaskState(
        taskNames: taskNames ?? this.taskNames,
        completedTasks: completedTasks ?? this.completedTasks);
  }

  TaskState removeTask(Task taskNameToRemove) {
    List<Task> newTaskNames = List.from(taskNames);
    newTaskNames.remove(taskNameToRemove);
    return TaskState(
        taskNames: newTaskNames,
        taskName: taskName,
        completedTasks: completedTasks);
  }

//make into one cubit ^

  TaskState completeTask({List<Task>? completedTasks}) {
    return TaskState(
        taskNames: taskNames,
        completedTasks: completedTasks ?? this.completedTasks);
  }

  TaskState deleteTask(String taskNameToRemove) {
    List<Task> newCompletedTasks = List.from(completedTasks);
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
