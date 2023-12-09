import 'package:bloc_test/bloc_test.dart';
//import 'package:mocktail/mocktail.dart';
import 'package:task_list_app/cubit/task_cubit.dart';

main() {
  blocTest(
    'Add Task adds to the Incompleted Tasks Array',
    //setUp: () => when(()), <- for when communicating with an API
    build: () => TaskCubit(),
    act: (cubit) => cubit.addTask(taskName: 'example task'),
    expect: () => <TaskState>[
      const TaskState(taskNames: ['example task'], completedTasks: [])
    ],
  );
  blocTest(
    'Remove Task adds to the Completed Tasks Array',
    build: () => TaskCubit(),
    act: (cubit) {
      cubit.addTask(taskName: 'example task');
      cubit.completeTask(taskName: 'example task');
      cubit.removeTask(taskName: 'example task');
      cubit.deleteTask(taskName: 'example task');
    },
    skip: 1,
    expect: () => <TaskState>[
      const TaskState(
          taskNames: ['example task'], completedTasks: ['example task']),
      const TaskState(taskNames: [], completedTasks: ['example task']),
      const TaskState(taskNames: [], completedTasks: []),
    ],
  );
}
