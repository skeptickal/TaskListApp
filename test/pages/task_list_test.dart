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
  Task task = const Task(name: 'example task', status: TaskStatus.todo);

  group('Task List', () {
    // Non-`go_router` test
    testWidgets('title is displayed', (WidgetTester tester) async {
      // Set up mock cubit(s) - This can be done in the setUp() if it's common to a group() of tests
      final MockTaskCubit mockTaskCubit = MockTaskCubit();
      when(() => mockTaskCubit.state).thenReturn(
        TaskState(tasks: [task]),
      );
      when(() => mockTaskCubit.readTasksByStatus(TaskStatus.todo))
          .thenAnswer((_) => Future.value());

      // Render the widget in the file name
      await tester.pumpWidget(Materializer(
        mockCubits: [mockTaskCubit],
        child: const TaskList(),
      ));

      // Do your test stuff
      final titleFinder = find.text('Task List');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets(
      'List Tiles Present',
      (WidgetTester tester) async {
        final MockTaskCubit mockTaskCubit = MockTaskCubit();
        when(() => mockTaskCubit.state).thenReturn(
          TaskState(tasks: [task]),
        );
        when(() => mockTaskCubit.readTasksByStatus(TaskStatus.todo))
            .thenAnswer((_) => Future.value());
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

    testWidgets(
      'Pop Up Occurs on Main Screen',
      (WidgetTester tester) async {
        final MockTaskCubit mockTaskCubit = MockTaskCubit();
        when(() => mockTaskCubit.state).thenReturn(
          TaskState(tasks: [task]),
        );
        when(() => mockTaskCubit.readTasksByStatus(TaskStatus.todo))
            .thenAnswer((_) => Future.value());
        when(() => mockTaskCubit.recycleTask(task: task))
            .thenAnswer((invocation) => Future.value());
        when(() => mockTaskCubit.completeTask(task: task))
            .thenAnswer((invocation) => Future.value());
        await tester.pumpWidget(Materializer(
          mockCubits: [mockTaskCubit],
          mockGoRouter: mockGoRouter,
          child: const TaskList(),
        ));
        await tester.pumpAndSettle();

        final recycleFinder = find.byKey(
          const Key('go_to_recycle_bin'),
        );
        expect(recycleFinder, findsOneWidget);
        await tester.tap(recycleFinder);
        await tester.pumpAndSettle();
        verify(() => mockGoRouter.go('/recycle')).called(1);

        final iconFinder = find.byKey(
          const Key('move_task_icon'),
        );
        expect(iconFinder, findsOneWidget);
        await tester.tap(iconFinder);
        await tester.pumpAndSettle();

        final popFinder = find.byKey(
          const Key('complete_or_recycle'),
        );
        expect(popFinder, findsOneWidget);

        final completeTextButtonFinder = find.byKey(
          const Key('incomplete_mark_complete'),
        );
        expect(completeTextButtonFinder, findsOneWidget);

        final recycleTextButtonFinder =
            find.byKey(const Key('incomplete_mark_recycled'));
        expect(recycleTextButtonFinder, findsOneWidget);
      },
    );

    testWidgets(
      'Edit View Occurs on Main Screen',
      (WidgetTester tester) async {
        final MockTaskCubit mockTaskCubit = MockTaskCubit();
        when(() => mockTaskCubit.state).thenReturn(
          TaskState(tasks: [task]),
        );
        when(() => mockTaskCubit.readTasksByStatus(TaskStatus.todo))
            .thenAnswer((_) => Future.value());
        when(() => mockTaskCubit.recycleTask(task: task))
            .thenAnswer((invocation) => Future.value());
        when(() => mockTaskCubit.completeTask(task: task))
            .thenAnswer((invocation) => Future.value());
        await tester.pumpWidget(Materializer(
          mockCubits: [mockTaskCubit],
          mockGoRouter: mockGoRouter,
          child: const TaskList(),
        ));
        await tester.pumpAndSettle();

        final editIconFinder = find.byKey(const Key('edit_icon'));
        expect(editIconFinder, findsOneWidget);
        await tester.tap(editIconFinder);
        await tester.pumpAndSettle();

        final editContainerFinder = find.byKey(const Key('edit_container'));
        expect(editContainerFinder, findsOneWidget);
        await tester.pumpAndSettle();
      },
    );
  });
}
