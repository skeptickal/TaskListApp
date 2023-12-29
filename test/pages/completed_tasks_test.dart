import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';
import 'package:task_list_app/pages/completed_tasks.dart';
import '../materializer.dart';
import '../mocks.dart';

void main() {
  final MockGoRouter mockGoRouter = MockGoRouter();

  group('Completed Task List', () {
    // Non-`go_router` test
    testWidgets('completed tasks title is displayed',
        (WidgetTester tester) async {
      // Set up mock cubit(s) - This can be done in the setUp() if it's common to a group() of tests
      final MockTaskCubit mockTaskCubit = MockTaskCubit();
      when(() => mockTaskCubit.state).thenReturn(
        const TaskState(taskNames: [], completedTasks: []),
      );
      when(() => mockTaskCubit.readTasks()).thenAnswer((_) => Future.value());

      // Render the widget in the file name
      await tester.pumpWidget(Materializer(
        mockCubits: [mockTaskCubit],
        child: const CompletedTaskScreen(),
      ));

      // Do your test stuff
      final titleFinder = find.text('Completed Tasks');
      expect(titleFinder, findsOneWidget);
    });
    testWidgets(
      'List Tiles Present',
      (WidgetTester tester) async {
        final MockTaskCubit mockTaskCubit = MockTaskCubit();
        when(() => mockTaskCubit.state).thenReturn(
          const TaskState(
              taskNames: [], completedTasks: [Task(name: 'Task 1', id: '1')]),
        );
        when(() => mockTaskCubit.readTasks()).thenAnswer((_) => Future.value());
        await tester.pumpWidget(Materializer(
          mockCubits: [mockTaskCubit],
          mockGoRouter: mockGoRouter,
          child: const CompletedTaskScreen(),
        ));
        await tester.pumpAndSettle();
        final tileFinder = find.byKey(const Key('completed tiles'));
        expect(tileFinder, findsOneWidget);
      },
    );
  });
}
