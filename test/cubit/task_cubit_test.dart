import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';
import '../mocks.dart';

main() {
  Task task = const Task(id: null, name: 'example task');

  group('Cubit Tests', () {
    late MockTaskCubit mockTaskCubit = MockTaskCubit();
    setUp(() {
      when(() => mockTaskCubit.addTask(taskName: task)).thenAnswer(
        (_) => Future.value(TaskState(taskNames: [task], completedTasks: [])),
      );
    });

    blocTest(
      'Add Task adds to the Incompleted Tasks Array',
      //setUp: () => when(()), <- for when communicating with an API, use later for Testing
      build: () => mockTaskCubit,
      act: (cubit) async => await cubit.addTask(taskName: task),
      expect: () => <TaskState>[
        TaskState(taskNames: [task], completedTasks: const [])
      ],
    );
    blocTest(
      'Remove Task adds to the Completed Tasks Array',
      build: () => mockTaskCubit,
      act: (cubit) => cubit.addTask(taskName: task).then((_) {
        cubit.completeTask(taskName: task);
        cubit.deleteTask(taskName: task);
      }),
      skip: 1,
      expect: () => <TaskState>[
        TaskState(taskNames: [task], completedTasks: [task]),
        TaskState(taskNames: const [], completedTasks: [task]),
        const TaskState(taskNames: [], completedTasks: []),
      ],
    );
  });
}
