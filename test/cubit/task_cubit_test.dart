import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';
import '../mocks.dart';

main() {
  Task task = const Task(id: null, name: 'example task');
  Task newTask = const Task(name: 'New Task');

  group('Cubit Tests', () {
    late TaskCubit taskCubit;
    late MockTaskService mockTaskService;

    setUp(() {
      mockTaskService = MockTaskService();
      taskCubit = TaskCubit(taskService: mockTaskService);
    });

    blocTest(
      'Add Task adds to the Incompleted Tasks Array',
      setUp: () {
        when(() => mockTaskService.addTask(task: task)).thenAnswer(
          (_) async => Future.value(),
        );
      },
      build: () => taskCubit,
      act: (TaskCubit cubit) => cubit.addTask(task: task),
      expect: () => <TaskState>[
        TaskState(tasks: [task])
      ],
    );

    blocTest('Complete Task adds to the Completed Tasks Array',
        setUp: () {
          when(() => mockTaskService.addTask(task: task)).thenAnswer(
            (_) async => Future.value(),
          );
          when(() => mockTaskService.completeTask(task: task)).thenAnswer(
            (_) async => Future.value(),
          );
        },
        build: () => taskCubit,
        act: (cubit) async {
          await cubit.addTask(task: task).then((_) async {
            print('First State: ${cubit.state}');
            await cubit.completeTask(task: task);
            print('Second State: ${cubit.state}');
          });
        },
        skip: 0,
        expect: () => [
              TaskState(tasks: [task]),
            ]);
    blocTest('Delete Task removes from the Completed Tasks Array',
        setUp: () {
          when(() => mockTaskService.addTask(task: task)).thenAnswer(
            (_) async => Future.value(),
          );
          when(() => mockTaskService.completeTask(task: task)).thenAnswer(
            (_) async => Future.value(),
          );
          when(() => mockTaskService.deleteTask(task: task)).thenAnswer(
            (_) async => Future.value(),
          );
        },
        build: () => taskCubit,
        act: (cubit) async {
          await cubit.addTask(task: task).then((_) async {
            print('First State: ${cubit.state}');
            await cubit.completeTask(task: task);
            print('Second State: ${cubit.state}');
            await cubit.deleteTask(task: task);
            print('Third State: ${cubit.state}');
          });
        },
        skip: 0,
        expect: () => [
              TaskState(tasks: [task]),
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
        TaskState(tasks: [task]),
      ],
    );

    blocTest(
      'editTasks updates state with the new task',
      setUp: () {
        when(() => mockTaskService.addTask(task: task)).thenAnswer(
          (_) async => Future.value(),
        );
        when(() => mockTaskService.editTask(task: newTask)).thenAnswer(
          (_) async => Future.value([newTask]),
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
      skip: 1,
      expect: () => <TaskState>[
        TaskState(tasks: [newTask]),
      ],
    );
  });
}
