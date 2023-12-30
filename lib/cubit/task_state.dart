part of 'task_cubit.dart';

@immutable
class TaskState extends Equatable {
  final List<Task> taskNames;
  final Task? taskName;
  final List<Task> completedTasks;
  @override
  List<Object?> get props => [taskName, taskNames, completedTasks];
  const TaskState(
      {required this.taskNames, this.taskName, required this.completedTasks});

  TaskState copyWith({List<Task>? taskNames, List<Task>? completedTasks}) {
    return TaskState(
        taskNames: taskNames ?? this.taskNames,
        completedTasks: completedTasks ?? this.completedTasks);
  }
}

final class TaskInitial extends TaskState {
  TaskInitial()
      : super(
          taskNames: [],
          completedTasks: [],
        );
}
