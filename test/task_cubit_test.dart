import 'package:bloc_test/bloc_test.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';

main() {
  Task task = Task(id: null, name: 'example task');
  blocTest(
    'Add Task adds to the Incompleted Tasks Array',
    //setUp: () => when(()), <- for when communicating with an API, use later for Testing
    build: () => TaskCubit(),
    act: (cubit) => cubit.addTask(taskName: task),
    expect: () => <TaskState>[
      TaskState(taskNames: [task], completedTasks: const [])
    ],
  );
  blocTest(
    'Remove Task adds to the Completed Tasks Array',
    build: () => TaskCubit(),
    act: (cubit) {
      cubit.addTask(taskName: task);
      cubit.completeTask(taskName: task);
      cubit.removeTask(taskName: task);
      cubit.deleteTask(taskName: task);
    },
    skip: 1,
    expect: () => <TaskState>[
      TaskState(taskNames: [task], completedTasks: [task]),
      TaskState(taskNames: [], completedTasks: [task]),
      TaskState(taskNames: [], completedTasks: []),
    ],
  );
}
