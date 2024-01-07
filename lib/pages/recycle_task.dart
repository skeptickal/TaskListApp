import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/resource/bottom_nav.dart';
import 'package:task_list_app/constants/constants.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';

class RecycleTaskScreen extends StatelessWidget {
  const RecycleTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().readTasksByStatus(TaskStatus.recycled);
    return BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
      List<Widget> recycledTasks = state.tasks.map(
        (task) {
          return ListTile(
            key: const Key('recycled_tiles'),
            leading: IconButton(
              key: const Key('recycle_icon'),
              icon: const Icon(Icons.recycling),
              color: Colors.blueGrey,
              onPressed: () {},
            ),
            title: Text(
              task.name,
              style: tilesText,
            ),
            trailing: IconButton(
              key: const Key('red_trash_icon'),
              onPressed: () => _onTapTrashIcon(context, task),
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            ),
          );
        },
      ).toList();

      return Scaffold(
        bottomNavigationBar: const BottomNav(),
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Recycled Tasks',
            style: TextStyle(color: white),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: recycledTasks.length,
          itemBuilder: (context, index) {
            return recycledTasks[index];
          },
        ),
      );
    });
  }

  void _onTapTrashIcon(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        key: const Key('recover_or_delete'),
        surfaceTintColor: bgColor,
        backgroundColor: bgColor,
        title: Text(
          'Recover or Delete Task?',
          style: TextStyle(color: white),
        ),
        actions: [
          TextButton(
            key: const Key('recycle_mark_recover'),
            child: Text(
              'Recover',
              style: TextStyle(color: white),
            ),
            onPressed: () async {
              context
                  .read<TaskCubit>()
                  .updateTask(task: task, newStatus: TaskStatus.todo)
                  .then((result) {
                context
                    .read<TaskCubit>()
                    .readTasksByStatus(TaskStatus.recycled);
                context.pop();
              });
            },
          ),
          TextButton(
            key: const Key('recycle_mark_deleted'),
            child: Text(
              'Delete Permanently',
              style: TextStyle(color: white),
            ),
            onPressed: () async {
              context.read<TaskCubit>().deleteTask(task: task).then((result) {
                context
                    .read<TaskCubit>()
                    .readTasksByStatus(TaskStatus.recycled);
                context.pop();
              });
            },
          )
        ],
      ),
    );
  }
}
