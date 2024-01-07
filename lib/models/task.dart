import 'package:equatable/equatable.dart';

enum TaskStatus {
  todo,
  completed,
  recycled,
  deleted,
}

class Task extends Equatable {
  final int? id;
  final String name;
  final TaskStatus status;

  const Task({this.id, required this.name, required this.status});

  Task copyWithStatus(TaskStatus newStatus) {
    return Task(
      id: id,
      name: name,
      status: newStatus,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id']
            as int?, // Check if 'id' is present before converting to int?
        name: json['name'].toString(),
        status: _getStatusFromJson(json['status']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'name': name};
    if (id != null) {
      data['id'] = id.toString();
    }
    data['status'] = getStatusString(status);
    return data;
  }

  static TaskStatus _getStatusFromJson(String status) {
    switch (status) {
      case 'todo':
        return TaskStatus.todo;
      case 'completed':
        return TaskStatus.completed;
      case 'recycled':
        return TaskStatus.recycled;
      case 'deleted':
        return TaskStatus.deleted;
      default:
        return TaskStatus.todo;
    }
  }

  static String getStatusString(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo:
        return 'todo';
      case TaskStatus.completed:
        return 'completed';
      case TaskStatus.recycled:
        return 'recycled';
      case TaskStatus.deleted:
        return 'deleted';
    }
  }

  Task copyWith({
    int? id,
    String? name,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, name, status];
}
