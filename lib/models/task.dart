class Task {
  String? id;
  String name;

  Task({id, required this.name});

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
}
