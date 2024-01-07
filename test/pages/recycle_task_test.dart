import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';
import 'package:task_list_app/pages/recycle_task.dart';
import '../materializer.dart';
import '../mocks.dart';

void main() {
  final MockGoRouter mockGoRouter = MockGoRouter();
  Task task = const Task(name: 'example task', status: TaskStatus.recycled);

  group('Recycled Task List', () {
    testWidgets('title is displayed', (WidgetTester tester) async {
      final MockTaskCubit mockTaskCubit = MockTaskCubit();
      when(() => mockTaskCubit.state).thenReturn(
        TaskState(tasks: [task]),
      );
      when(() => mockTaskCubit.readTasksByStatus(TaskStatus.recycled))
          .thenAnswer((_) => Future.value());

      await tester.pumpWidget(Materializer(
        mockCubits: [mockTaskCubit],
        child: const RecycleTaskScreen(),
      ));

      final titleFinder = find.text('Recycled Tasks');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets(
      'List Tiles Present',
      (WidgetTester tester) async {
        final MockTaskCubit mockTaskCubit = MockTaskCubit();
        when(() => mockTaskCubit.state).thenReturn(
          TaskState(tasks: [task]),
        );
        when(() => mockTaskCubit.readTasksByStatus(TaskStatus.recycled))
            .thenAnswer((_) => Future.value());
        await tester.pumpWidget(Materializer(
          mockCubits: [mockTaskCubit],
          mockGoRouter: mockGoRouter,
          child: const RecycleTaskScreen(),
        ));
        await tester.pumpAndSettle();
        final tileFinder = find.byKey(const Key('recycled_tiles'));
        expect(tileFinder, findsOneWidget);
      },
    );

    testWidgets(
      'Pop Up Occurs on Recycle Screen',
      (WidgetTester tester) async {
        final MockTaskCubit mockTaskCubit = MockTaskCubit();
        when(() => mockTaskCubit.state).thenReturn(
          TaskState(tasks: [task]),
        );
        when(() => mockTaskCubit.readTasksByStatus(TaskStatus.recycled))
            .thenAnswer((_) => Future.value());
        when(() => mockTaskCubit.updateTask(
                task: task, newStatus: TaskStatus.todo))
            .thenAnswer((invocation) => Future.value());
        when(() => mockTaskCubit.deleteTask(task: task))
            .thenAnswer((invocation) => Future.value());
        await tester.pumpWidget(Materializer(
          mockCubits: [mockTaskCubit],
          mockGoRouter: mockGoRouter,
          child: const RecycleTaskScreen(),
        ));
        await tester.pumpAndSettle();

        final recycleIconFidner = find.byKey(
          const Key('recycle_icon'),
        );
        expect(recycleIconFidner, findsOneWidget);

        final iconFinder = find.byKey(
          const Key('red_trash_icon'),
        );
        expect(iconFinder, findsOneWidget);
        await tester.tap(iconFinder);
        await tester.pumpAndSettle();

        final popFinder = find.byKey(
          const Key('recover_or_delete'),
        );
        expect(popFinder, findsOneWidget);

        final recoverTextButtonFinder = find.byKey(
          const Key('recycle_mark_recover'),
        );
        expect(recoverTextButtonFinder, findsOneWidget);

        final deleteTextButtonFinder =
            find.byKey(const Key('recycle_mark_deleted'));
        expect(deleteTextButtonFinder, findsOneWidget);
      },
    );
  });
}
