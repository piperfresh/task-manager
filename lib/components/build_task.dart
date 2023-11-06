import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/app_state/task_manager.dart';
import 'package:taskmanager/screens/empty_task_screen.dart';

Widget buildTasksScreen(BuildContext context) {
  return Consumer(builder: (context, ref, child) {
    if (ref.watch(taskManagerProvider).tasksList.isNotEmpty) {
      return Container();
    } else {
      return const EmptyTaskScreen();
    }
  });
}
