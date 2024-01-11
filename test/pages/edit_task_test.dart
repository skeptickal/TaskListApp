import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';
import 'package:task_list_app/pages/edit_task.dart';
import '../materializer.dart';
import '../mocks.dart';

void main() {
  Task updatedTask = const Task(name: 'example', status: TaskStatus.todo);
  setUpAll(() {
    // Register a fallback value for Task
    registerFallbackValue(const Task(id: 0, name: 'dummy', status: TaskStatus.todo));
  });
  testWidgets('Edit tasks title is displayed, and edit button exists', (WidgetTester tester) async {
    // Set up mock cubit(s)
    final MockTaskCubit mockTaskCubit = MockTaskCubit();
    when(() => mockTaskCubit.state).thenReturn(
      const TaskState(tasks: []),
    );
    when(() => mockTaskCubit.updateTask(task: updatedTask)).thenAnswer((_) => Future.value());

    // Render the widget with a MaterialApp
    await tester.pumpWidget(
      Materializer(
        mockCubits: [mockTaskCubit],
        child: Scaffold(
          body: EditTask(
            task: const Task(name: 'updatedTask', status: TaskStatus.todo),
            onTaskUpdated: (updatedTaskName) {
              mockTaskCubit.updateTask(task: updatedTask, newName: updatedTaskName);
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Perform your tests
    final titleFinder = find.byKey(const Key('edit_task_form'));
    expect(titleFinder, findsOneWidget);

    final editButtonfinder = find.byKey(const Key('edit_task_button'));
    expect(editButtonfinder, findsOneWidget);
  });
}
