import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/models/task_data.dart';

import '../app_utils/constant/app_spacing.dart';

class TaskTile extends ConsumerWidget {
  final TaskData taskItem;
  final Function(bool?)? onComplete;
  final TextDecoration textDecoration;

  TaskTile({
    super.key,
    required this.taskItem,
    this.onComplete,
  }) : textDecoration = taskItem.isCompleted
            ? TextDecoration.lineThrough
            : TextDecoration.none;

  Widget buildImportance() {
    if (taskItem.importance == Importance.low) {
      return Text(
        'low',
        style: GoogleFonts.openSans(
          color: Colors.grey,
          fontSize: 20,
          decoration: textDecoration,
          fontWeight: FontWeight.w500,
        ),
      );
    } else if (taskItem.importance == Importance.medium) {
      return Text(
        'medium',
        style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 20,
            decoration: textDecoration,
            fontWeight: FontWeight.w700),
      );
    } else {
      return Text(
        'high',
        style: GoogleFonts.openSans(
            color: Colors.red,
            fontSize: 20,
            decoration: textDecoration,
            fontWeight: FontWeight.bold),
      );
    }
  }

  Widget buildDate() {
    final dateFormatter = DateFormat('dd MMMM h:mm a');
    final dateString = dateFormatter.format(taskItem.dateTime);
    return Text(
      dateString,
      style: TextStyle(decoration: textDecoration),
    );
  }

  Widget buildCheckBox() {
    return Checkbox(
      value: taskItem.isCompleted,
      onChanged: onComplete,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 150,
      // color: Colors.deepPurple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskItem.title,
                style: GoogleFonts.openSans(
                  fontSize: 21,
                  decoration: textDecoration,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSpacer.smallVerticalSpacing,
              Text(
                taskItem.subTitle,
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    decoration: textDecoration,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              AppSpacer.smallVerticalSpacing,
              buildDate(),
              AppSpacer.smallVerticalSpacing,
              buildImportance(),
            ],
          ),
          buildCheckBox(),
        ],
      ),
    );
  }
}
