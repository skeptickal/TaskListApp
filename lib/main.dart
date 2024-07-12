import 'package:flutter/material.dart';
import 'package:task_list_app/router.dart';
import 'package:task_list_app/task_bloc_provider.dart';

void main() {
  runApp(TaskBlocProvider(
    child: MaterialApp.router(
      routerConfig: router(),
    ),
  ));
}
// 