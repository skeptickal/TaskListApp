import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String? id;
  final String name;

  const Task({required this.id, required this.name});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'].toString(),
      name: json['name'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'id': id, 'name': name};
    return data;
  }

  @override
  List<Object?> get props => [id, name];
}
