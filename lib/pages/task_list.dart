import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/constants/constants.dart';
import 'package:task_list_app/cubit/task_cubit.dart';
import 'package:task_list_app/models/task.dart';
import 'package:task_list_app/pages/edit_task.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    context.read<TaskCubit>().readTasks();
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        List<Widget> tasks = state.taskNames.map(
          (taskName) {
            return ListTile(
              key: const Key('task tiles'),
              leading: GestureDetector(
                onTap: () => _showEditPanel(context, taskName),
                child: Icon(
                  Icons.edit,
                  color: iconColor,
                ),
              ),
              title: Text(
                taskName.name,
                style: tilesText,
              ),
              trailing: GestureDetector(
                  onTap: () => _onTapCompleteIcon(taskName),
                  child: Icon(Icons.remove_circle, color: iconColor)),
            );
          },
        ).toList();
        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            iconTheme: IconThemeData(color: iconColor),
            title: const Text(
              'Task List',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          drawer: Drawer(
              key: const Key('Drawer'),
              backgroundColor: bgColor,
              child: ListView(
                children: [
                  const UserAccountsDrawerHeader(
                    margin: EdgeInsets.all(4),
                    accountName:
                        Text('Task Manager', style: TextStyle(fontSize: 18)),
                    accountEmail:
                        Text('Options', style: TextStyle(fontSize: 18)),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 129, 128, 128)),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    arrowColor: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 6, 4, 4),
                    child: Card(
                      color: const Color.fromARGB(255, 85, 84, 84),
                      child: GestureDetector(
                        key: const Key('CompletedTasksButton'),
                        onTap: () => context.go('/completed_tasks'),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: ListTile(
                            leading: Icon(Icons.task_alt, color: Colors.white),
                            title: Text('View Completed Tasks',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          body: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return tasks[index];
            },
          ),
          floatingActionButton: FloatingActionButton(
            key: const Key('taskAdderFloatingButton'),
            onPressed: () {
              context.go('/addtask');
            },
            backgroundColor: Colors.black,
            child: Icon(Icons.add, color: iconColor),
          ),
        );
      },
    );
  }

  void _showEditPanel(BuildContext context, Task taskName) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            color: bgColor,
            child: EditTask(
                taskName: taskName,
                onTaskUpdated: (updatedTask) {
                  context
                      .read<TaskCubit>()
                      .updateTask(updatedTask: updatedTask);
                }),
          );
        });
  }

  void _onTapCompleteIcon(Task taskName) {
    context.read<TaskCubit>().completeTask(taskName: taskName);
  }
}
