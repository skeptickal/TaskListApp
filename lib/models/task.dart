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

  String getName() {
    return name;
  }

  String? getId() {
    return id;
  }

  void setName(String name) {
    this.name = name;
  }
}
