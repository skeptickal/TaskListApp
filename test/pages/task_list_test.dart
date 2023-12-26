import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';
import 'package:task_list_app/pages/task_list.dart';
import '../materializer.dart';
import '../mocks.dart';

void main() {
  final MockGoRouter mockGoRouter = MockGoRouter();

  group('Task List', () {
    // Non-`go_router` test
    testWidgets('title is displayed', (WidgetTester tester) async {
      // Set up mock cubit(s) - This can be done in the setUp() if it's common to a group() of tests
      final MockTaskCubit mockTaskCubit = MockTaskCubit();
      when(() => mockTaskCubit.state).thenReturn(
        const TaskState(taskNames: [], completedTasks: []),
      );
      when(() => mockTaskCubit.readTasks()).thenAnswer((_) => Future.value());

      // Render the widget in the file name
      await tester.pumpWidget(Materializer(
        mockCubits: [mockTaskCubit],
        child: const TaskList(),
      ));

      // Do your test stuff
      final titleFinder = find.text('Task List');
      expect(titleFinder, findsOneWidget);
    });

    // `go_router` test example
    testWidgets(
      'add task button is present AND navigates',
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
          mockGoRouter: mockGoRouter,
          child: const TaskList(),
        ));

        // Do everything you need to make the app navigate
        final titleFinder = find.byKey(const Key('taskAdderFloatingButton'));
        expect(titleFinder, findsOneWidget);
        await tester.tap(titleFinder);

        // Verify the app navigated (this means you can't use context.push())
        verify(() => mockGoRouter.go('/addtask')).called(1);
      },
    );
    testWidgets(
      'Drawer Exists, Completed Task Button Navigates',
      (WidgetTester tester) async {
        final MockTaskCubit mockTaskCubit = MockTaskCubit();
        when(() => mockTaskCubit.state).thenReturn(
          const TaskState(taskNames: [], completedTasks: []),
        );
        when(() => mockTaskCubit.readTasks()).thenAnswer((_) => Future.value());
        await tester.pumpWidget(Materializer(
          mockCubits: [mockTaskCubit],
          mockGoRouter: mockGoRouter,
          child: const TaskList(),
        ));
        await tester.dragFrom(
            tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
        await tester.pumpAndSettle();
        final navFinder = find.byKey(const Key('CompletedTasksButton'));
        await tester.tap(navFinder);
        // Verify the app navigated (this means you can't use context.push())
        verify(() => mockGoRouter.go('/completed_tasks')).called(1);
      },
    );
    testWidgets(
      'List Tiles Present',
      (WidgetTester tester) async {
        final MockTaskCubit mockTaskCubit = MockTaskCubit();
        when(() => mockTaskCubit.state).thenReturn(
          const TaskState(
              taskNames: [Task(name: 'Task 1', id: '1')], completedTasks: []),
        );
        when(() => mockTaskCubit.readTasks()).thenAnswer((_) => Future.value());
        await tester.pumpWidget(Materializer(
          mockCubits: [mockTaskCubit],
          mockGoRouter: mockGoRouter,
          child: const TaskList(),
        ));
        await tester.pumpAndSettle();
        final tileFinder = find.byKey(const Key('task tiles'));
        expect(tileFinder, findsOneWidget);
      },
    );
  });
}
