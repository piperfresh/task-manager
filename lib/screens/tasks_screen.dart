import 'package:flutter/material.dart';
import 'package:taskmanager/screens/empty_task_screen.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Manager',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: const EmptyTaskScreen(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {}),
    );
  }
}
