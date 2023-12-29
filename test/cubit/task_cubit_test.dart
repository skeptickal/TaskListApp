import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';
import '../mocks.dart';

main() {
  Task task = const Task(id: null, name: 'example task');

  group('Cubit Tests', () {
    // JACKSON: I think this was the whole issue. 99% of the time, we don't want a mock of the class we are testing. The only other thing that needed fixing was the Mocktail when(). Based on the error, I bet you would have figured that out.
    late TaskCubit taskCubit;
    late MockTaskService mockTaskService;

    setUp(() {
      mockTaskService = MockTaskService();
      taskCubit = TaskCubit(taskService: mockTaskService);
    });

    blocTest(
      'Add Task adds to the Incompleted Tasks Array',
      setUp: () {
        // JACKSON: This bit is needed to hop over the line 15 of TaskCubit
        when(() => mockTaskService.addTask(taskName: task)).thenAnswer(
          (_) async => Future.value(),
        );
      },
      build: () => taskCubit,
      act: (TaskCubit cubit) => cubit.addTask(taskName: task),
      expect: () => <TaskState>[
        TaskState(taskNames: [task], completedTasks: const [])
      ],
    );

    blocTest(
      'Complete Task and Delete Task adds to the Completed Tasks Array',
      setUp: () {
        when(() => mockTaskService.addTask(taskName: task)).thenAnswer(
          (_) async => Future.value(),
        );
      },
      build: () => taskCubit,
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

    blocTest(
      'readTasks updates state with the existing task list',
      setUp: () {
        when(() => mockTaskService.addTask(taskName: task)).thenAnswer(
          (_) async => Future.value(),
        );
        when(() => mockTaskService.readTasks()).thenAnswer(
          (_) async => Future.value([task]),
        );
      },
      build: () => taskCubit,
      act: (cubit) => cubit.readTasks(),
      expect: () => <TaskState>[
        TaskState(taskNames: [task], completedTasks: []),
      ],
    );
  });
}
