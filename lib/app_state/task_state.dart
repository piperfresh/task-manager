import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task_data.dart';

class TaskDataNotifier extends StateNotifier<TaskData> {

  TaskDataNotifier()
      : super(TaskData(
            importance: Importance.low,
            dateTime: DateTime.now(),
            id: 'demo',
            title: '',
            subTitle: ''));

  void toggleCompleted() {
    state = state.copyWith(isCompleted: !state.isCompleted);
    print('Current State: ${state.isCompleted}');
  }
}



