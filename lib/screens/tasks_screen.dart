import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmanager/app_state/task_manager.dart';
import 'package:taskmanager/components/build_task.dart';
import 'package:taskmanager/screens/tasks_item_screen.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Manager',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: buildTasksScreen(context),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            final taskManager = ref.read(taskManagerProvider);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return TasksItemScreen(
                  onCreate: (task) {
                    taskManager.addTask(task);
                    Navigator.pop(context);
                  },
                  onUpdate: (task) {});
            }));
          }),
    );
  }
}
