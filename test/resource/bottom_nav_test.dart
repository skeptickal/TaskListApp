import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';
import 'package:task_list_app/resource/bottom_nav.dart';
import '../materializer.dart';
import '../mocks.dart';

void main() {
  final MockGoRouter mockGoRouter = MockGoRouter();
  testWidgets('Home Icon Exists and Navigates', (WidgetTester tester) async {
    // Set up mock cubit(s)
    final MockTaskCubit mockTaskCubit = MockTaskCubit();
    when(() => mockTaskCubit.state).thenReturn(
      const TaskState(tasks: []),
    );
    when(() => mockTaskCubit.readTasksByStatus(TaskStatus.todo))
        .thenAnswer((_) => Future.value());

    // Render the widget with a MaterialApp
    await tester.pumpWidget(
      Materializer(
        mockGoRouter: mockGoRouter,
        mockCubits: [mockTaskCubit],
        child: const Scaffold(
          body: BottomNav(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Perform your tests
    final titleFinder = find.byKey(const Key('Home'));
    expect(titleFinder, findsOneWidget);
    await tester.tap(titleFinder);
    verify(() => mockGoRouter.go('/')).called(1);
  });
  testWidgets('Completed Tasks Icon Exists and Navigates',
      (WidgetTester tester) async {
    // Set up mock cubit(s)
    final MockTaskCubit mockTaskCubit = MockTaskCubit();
    when(() => mockTaskCubit.state).thenReturn(
      const TaskState(tasks: []),
    );
    when(() => mockTaskCubit.readTasksByStatus(TaskStatus.todo))
        .thenAnswer((_) => Future.value());

    // Render the widget with a MaterialApp
    await tester.pumpWidget(
      Materializer(
        mockGoRouter: mockGoRouter,
        mockCubits: [mockTaskCubit],
        child: const Scaffold(
          body: BottomNav(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Perform your tests
    final titleFinder = find.byKey(const Key('Completed Tasks'));
    expect(titleFinder, findsOneWidget);
    await tester.tap(titleFinder);
    verify(() => mockGoRouter.go('/completed_tasks')).called(1);
  });
  testWidgets('Add Task Icon Exists and Navigates',
      (WidgetTester tester) async {
    // Set up mock cubit(s)
    final MockTaskCubit mockTaskCubit = MockTaskCubit();
    when(() => mockTaskCubit.state).thenReturn(
      const TaskState(tasks: []),
    );
    when(() => mockTaskCubit.readTasksByStatus(TaskStatus.todo))
        .thenAnswer((_) => Future.value());

    // Render the widget with a MaterialApp
    await tester.pumpWidget(
      Materializer(
        mockGoRouter: mockGoRouter,
        mockCubits: [mockTaskCubit],
        child: const Scaffold(
          body: BottomNav(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Perform your tests
    final titleFinder = find.byKey(const Key('Add Task'));
    expect(titleFinder, findsOneWidget);
    await tester.tap(titleFinder);
    verify(() => mockGoRouter.go('/add_task')).called(1);
  });
}
