import 'package:flutter/material.dart';
import 'package:task_list_app/router.dart';
import 'package:task_list_app/task_bloc_provider.dart';

class Materializer extends StatelessWidget {
  const Materializer({super.key, required this.testRoute, this.platform});
  final String testRoute;
  final TargetPlatform? platform;

  @override
  Widget build(BuildContext context) {
    return TaskBlocProvider(
      child: MaterialApp.router(
        routerConfig: router(initialLocation: testRoute),
      ),
    );
  }
}
