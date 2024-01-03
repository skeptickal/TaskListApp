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

    blocTest('Complete Task adds to the Completed Tasks Array',
        setUp: () {
          when(() => mockTaskService.addTask(taskName: task)).thenAnswer(
            (_) async => Future.value(),
          );
          when(() => mockTaskService.completeTask(taskName: task)).thenAnswer(
            (_) async => Future.value(),
          );
        },
        build: () => taskCubit,
        act: (cubit) async {
          await cubit.addTask(taskName: task).then((_) async {
            print('First State: ${cubit.state}');
            await cubit.completeTask(taskName: task);
            print('Second State: ${cubit.state}');
          });
        },
        skip: 1,
        expect: () => [
              TaskState(taskNames: const [], completedTasks: [task]),
            ]);
    blocTest('Delete Task removes from the Completed Tasks Array',
        setUp: () {
          when(() => mockTaskService.addTask(taskName: task)).thenAnswer(
            (_) async => Future.value(),
          );
          when(() => mockTaskService.completeTask(taskName: task)).thenAnswer(
            (_) async => Future.value(),
          );
          when(() => mockTaskService.deleteTask(taskName: task)).thenAnswer(
            (_) async => Future.value(),
          );
        },
        build: () => taskCubit,
        act: (cubit) async {
          await cubit.addTask(taskName: task).then((_) async {
            print('First State: ${cubit.state}');
            await cubit.completeTask(taskName: task);
            print('Second State: ${cubit.state}');
            await cubit.deleteTask(taskName: task);
            print('Third State: ${cubit.state}');
          });
        },
        skip: 1,
        expect: () => [
              const TaskState(taskNames: [], completedTasks: []),
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
        TaskState(taskNames: [task], completedTasks: const []),
      ],
    );

    blocTest(
      'editTasks updates state with the new task',
      setUp: () {
        when(() => mockTaskService.addTask(taskName: task)).thenAnswer(
            (_) async => Future.value(),
          );
        when(() => mockTaskService.editTask(task: newTask)).thenAnswer(
          (_) async => Future.value([newTask]),
        );
      },
      build: () => taskCubit,
      act: (cubit) async {
        await cubit.addTask(taskName: task).then((_) async {
          print('First State: ${cubit.state}');
          await cubit.updateTask(updatedTask: newTask);
          print('Second State: ${cubit.state}');
        });
      },
      skip: 1,
      expect: () => <TaskState>[
        TaskState(taskNames: [newTask], completedTasks: []),
      ],
    );

    //   blocTest('Complete Task and Delete Task adds to the Completed Tasks Array',
    //       setUp: () {
    //         when(() => mockTaskService.addTask(taskName: task)).thenAnswer(
    //           (_) async => Future.value(),
    //         );
    //         when(() => mockTaskService.completeTask(taskName: task)).thenAnswer(
    //           (_) async => Future.value(),
    //         );
    //         when(() => mockTaskService.deleteTask(taskName: task)).thenAnswer(
    //           (_) async => Future.value(),
    //         );
    //       },
    //       build: () => taskCubit,
    //       act: (cubit) async {
    //         await cubit.addTask(taskName: task).then((_) async {
    //           print('First State: ${cubit.state}');
    //           await cubit.completeTask(taskName: task);
    //           print('Second State: ${cubit.state}');
    //           await cubit.deleteTask(taskName: task);
    //           print('Third State: ${cubit.state}');
    //         });
    //       },
    //       skip: 1,
    //       expect: () => [
    //             TaskState(taskNames: [task], completedTasks: []),
    //             TaskState(taskNames: const [], completedTasks: [task]),
    //             const TaskState(taskNames: [], completedTasks: []),
    //           ]);
  });
}
