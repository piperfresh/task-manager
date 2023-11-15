import 'package:flutter/material.dart';
import 'package:taskmanager/app_utils/constant/app_spacing.dart';
import 'package:taskmanager/models/task_tile.dart';

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
            final task = taskManager.tasksList[index];
            return TaskTile(
              taskItem: task,
              key: Key(task.id),
            );
          },
          separatorBuilder: (context, index) {
            return AppSpacer.smallVerticalSpacing;
          },
          itemCount: taskManager.tasksList.length),
    );
  }
}
