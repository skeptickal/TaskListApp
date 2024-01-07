import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';
import 'package:task_list_app/pages/add_task.dart';
import '../materializer.dart';
import '../mocks.dart';

void main() {
  final MockGoRouter mockGoRouter = MockGoRouter();

  group('Add Task Screen', () {
    Task task = const Task(name: 'example task', status: TaskStatus.todo);
    // Non-`go_router` test
    testWidgets('Add Task title is displayed', (WidgetTester tester) async {
      // Set up mock cubit(s) - This can be done in the setUp() if it's common to a group() of tests
      final MockTaskCubit mockTaskCubit = MockTaskCubit();
      when(() => mockTaskCubit.state).thenReturn(
        const TaskState(tasks: []),
      );
      when(() => mockTaskCubit.readTasks()).thenAnswer((_) => Future.value());

      // Render the widget in the file name
      await tester.pumpWidget(Materializer(
        mockCubits: [mockTaskCubit],
        child: const AddTaskScreen(),
      ));

      final titleFinder = find.text('Add a Task');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets(
      'Text Field Present',
      (WidgetTester tester) async {
        final MockTaskCubit mockTaskCubit = MockTaskCubit();
        when(() => mockTaskCubit.state).thenReturn(
          const TaskState(tasks: []),
        );
        when(() => mockTaskCubit.readTasks()).thenAnswer((_) => Future.value());
        await tester.pumpWidget(Materializer(
          mockCubits: [mockTaskCubit],
          mockGoRouter: mockGoRouter,
          child: const AddTaskScreen(),
        ));
        await tester.pumpAndSettle();
        final tileFinder = find.byKey(const Key('Add a task text field'));
        expect(tileFinder, findsOneWidget);
      },
    );

    testWidgets(
      'Fully add task button is present',
      (WidgetTester tester) async {
        final MockTaskCubit mockTaskCubit = MockTaskCubit();
        when(() => mockTaskCubit.state).thenReturn(
          const TaskState(
              tasks: [Task(name: 'example', status: TaskStatus.todo)]),
        );
        when(() => mockTaskCubit.readTasks())
            .thenAnswer((_) => Future.value([task]));

        // Render the widget in the file name
        await tester.pumpWidget(Materializer(
          mockCubits: [mockTaskCubit],
          mockGoRouter: mockGoRouter,
          child: const AddTaskScreen(),
        ));

        // Do everything you need to make the app navigate
        final titleFinder = find.byKey(const Key('Add Task Button'));
        expect(titleFinder, findsOneWidget);
      },
    );
  });
}
