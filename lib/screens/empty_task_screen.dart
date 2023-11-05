import 'package:flutter/material.dart';
import 'package:taskmanager/app_utils/constant/app_spacing.dart';

class EmptyTaskScreen extends StatelessWidget {
  const EmptyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              child: AspectRatio(
                aspectRatio: 19 / 9,
                child: Image(
                  image: AssetImage('images/empty_task.png'),
                ),
              ),
            ),
            AppSpacer.largeVerticalSpacing,
            Text(
              'No Task Yet',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            AppSpacer.largeVerticalSpacing,
            Text(
              'Tap the + button to add new task',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
