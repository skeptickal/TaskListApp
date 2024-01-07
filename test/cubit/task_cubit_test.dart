import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';
import '../mocks.dart';

main() {
  Task task = const Task(name: 'example task', status: TaskStatus.todo);
  Task newTask = const Task(name: 'New Task', status: TaskStatus.todo);
  Task completedTask =
      const Task(name: 'example task', status: TaskStatus.completed);
  Task recycledTask =
      const Task(name: 'example task', status: TaskStatus.recycled);
  Task deletedTask =
      const Task(name: 'example task', status: TaskStatus.deleted);

  group('Cubit Tests', () {
    late TaskCubit taskCubit;
    late MockTaskService mockTaskService;

    setUp(() {
      mockTaskService = MockTaskService();
      taskCubit = TaskCubit(taskService: mockTaskService);
    });

    blocTest('Adding, Completing, Recovering, Recycling, Deleting',
        setUp: () {
          when(() => mockTaskService.addTask(task: task)).thenAnswer(
            (_) async => Future.value(),
          );
          when(() => mockTaskService.completeTask(task: task)).thenAnswer(
            (_) async => Future.value(),
          );
          when(() => mockTaskService.recoverTask(task: task)).thenAnswer(
            (_) async => Future.value(),
          );
          when(() => mockTaskService.recycleTask(task: task)).thenAnswer(
            (_) async => Future.value(),
          );
          when(() => mockTaskService.deleteTask(task: task)).thenAnswer(
            (_) async => Future.value(),
          );
        },
        build: () => taskCubit,
        act: (cubit) async {
          await cubit.addTask(task: task).then((_) async {
            await cubit.completeTask(task: task);
            await cubit.recoverTask(task: task);
            await cubit.recycleTask(task: task);
            await cubit.deleteTask(task: task);
          });
        },
        skip: 0,
        expect: () => [
              TaskState(tasks: [task]),
              TaskState(tasks: [completedTask]),
              TaskState(tasks: [task]),
              TaskState(tasks: [recycledTask]),
              TaskState(tasks: [deletedTask])
            ]);

    blocTest(
      'readTasks updates state with the existing task list',
      setUp: () {
        when(() => mockTaskService.readTasks()).thenAnswer(
          (_) async => Future.value([task]),
        );
      },
      build: () => taskCubit,
      act: (cubit) => cubit.readTasks(),
      expect: () => <TaskState>[
        TaskState(tasks: [task])
      ],
    );

    blocTest(
      'readTasksByStatus updates state with the existing task list',
      setUp: () {
        when(() => mockTaskService.readTasksByStatus(TaskStatus.todo))
            .thenAnswer(
          (_) async => Future.value([task]),
        );
      },
      build: () => taskCubit,
      act: (cubit) => cubit.readTasksByStatus(TaskStatus.todo),
      expect: () => <TaskState>[
        TaskState(tasks: [task])
      ],
    );

    blocTest(
      'editTasks updates state with the new task',
      setUp: () {
        when(() => mockTaskService.addTask(task: task)).thenAnswer(
          (_) async => Future.value(),
        );
        when(() => mockTaskService.editTask(task: newTask)).thenAnswer(
          (_) async => Future.value(),
        );
      },
      build: () => taskCubit,
      act: (cubit) async {
        await cubit.addTask(task: task).then((_) async {
          print('First State: ${cubit.state}');
          await cubit.updateTask(updatedTask: newTask);
          print('Second State: ${cubit.state}');
        });
      },
      skip: 0,
      expect: () => <TaskState>[
        TaskState(tasks: [task]),
        TaskState(tasks: [newTask]),
      ],
    );
  });
}
