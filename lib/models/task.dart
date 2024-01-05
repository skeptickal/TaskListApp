import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int? id;
  final String name;

  const Task({this.id, required this.name});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id']
          as int?, // Check if 'id' is present before converting to int?
      name: json['name'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'name': name};
    if (id != null) {
      data['id'] = id.toString();
    }
    return data;
  }

  @override
  List<Object?> get props => [id, name];
}
