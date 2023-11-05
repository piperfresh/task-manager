enum Importance {
  low,
  medium,
  high,
}

class TaskData {
  final String id;
  final String title;
  final String subTitle;
  final bool isCompleted;
  final Importance importance;
  final DateTime dateTime;

  TaskData({
    required this.importance,
    required this.dateTime,
    required this.id,
    required this.title,
    required this.subTitle,
    this.isCompleted = false,
  });

  TaskData copyWith(
      {String? id,
      String? title,
      String? subTitle,
      bool? isCompleted,
      Importance? importance,
      DateTime? dateTime}) {
    return TaskData(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      isCompleted: isCompleted ?? this.isCompleted,
      importance: importance ?? this.importance,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}

