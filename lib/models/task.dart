import 'dart:ffi';

class Task {
  Long? id;
  String name;

  Task({id, required this.name});

  String getName() {
    return name;
  }

  Long? getId() {
    return id;
  }

  void setName(String name) {
    this.name = name;
  }
}
