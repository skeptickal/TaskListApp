part of 'task_cubit.dart';

@immutable
class TaskState extends Equatable {
  final List<Task> tasks;
  final Task? task;

  @override
  List<Object?> get props => [task, tasks];
  const TaskState({
    required this.tasks,
    this.task,
  });

  TaskState copyWith({List<Task>? tasks}) {
    return TaskState(
      tasks: tasks ?? this.tasks,
    );
  }
}

final class TaskInitial extends TaskState {
  TaskInitial()
      : super(
          tasks: [],
        );
}
