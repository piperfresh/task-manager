import 'package:flutter/material.dart';
import 'package:taskmanager/app_utils/constant/app_spacing.dart';
import 'package:taskmanager/models/task_tile.dart';
import 'package:taskmanager/screens/tasks_item_screen.dart';

import '../app_state/task_manager.dart';

class TaskListScreen extends StatelessWidget {
  final TaskManager taskManager;

  const TaskListScreen({super.key, required this.taskManager});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
          itemBuilder: (context, index) {
            final task = taskManager
                .tasksList[(taskManager.tasksList.length - 1) - index];
            print('3rd id : ${task.id}');
            print('This is key: ${Key(task.id)}');
            print(task);
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TasksItemScreen(
                    originalTask: task,
                      onCreate: (item) {},
                      onUpdate: (item) {
                        taskManager.updateTask(index, item);
                        Navigator.pop(context);
                      });
                }));
              },
              child: TaskTile(
                taskItem: task,
                key: Key(task.id),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return AppSpacer.smallVerticalSpacing;
          },
          itemCount: taskManager.tasksList.length),
    );
  }
}
