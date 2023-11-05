import 'package:flutter/material.dart';

import '../models/task_data.dart';

class TaskManager extends ChangeNotifier{
  final List<TaskData> _tasksList = [];

  List<TaskData> get tasksList => List.unmodifiable(_tasksList);

  void addTask(TaskData taskData){
    _tasksList.add(taskData);
    notifyListeners();
  }

  void removeTask(int index){
    _tasksList.removeAt(index);
    notifyListeners();
  }

  void updateTask(int index, TaskData taskData){
    _tasksList[index] = taskData;
    notifyListeners();
  }

  void completeTask(int index, bool isChanged){
  final taskData = _tasksList[index];
  _tasksList[index] = taskData.copyWith(isCompleted: isChanged);
  notifyListeners();
  }
}