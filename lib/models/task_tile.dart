import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/app_state/task_state.dart';
import 'package:taskmanager/models/task_data.dart';

// class TaskTile extends ConsumerWidget {
//   final TaskData taskItem;
//   final Function(bool?)? onComplete;
//   final TextDecoration textDecoration;
//   WidgetRef? ref;
//
//   TaskTile({
//     super.key,
//     required this.taskItem,
//     this.onComplete,
//   }) : textDecoration = taskItem.isCompleted
//             ? TextDecoration.lineThrough
//             : TextDecoration.none;
//
//   Widget buildImportance() {
//     if (taskItem.importance == Importance.low) {
//       return Text(
//         'low',
//         style: GoogleFonts.openSans(
//           color: Colors.grey,
//           fontSize: 20,
//           decoration: textDecoration,
//           fontWeight: FontWeight.w500,
//         ),
//       );
//     } else if (taskItem.importance == Importance.medium) {
//       return Text(
//         'medium',
//         style: GoogleFonts.openSans(
//             color: Colors.black,
//             fontSize: 20,
//             decoration: textDecoration,
//             fontWeight: FontWeight.w700),
//       );
//     } else {
//       return Text(
//         'high',
//         style: GoogleFonts.openSans(
//             color: Colors.red,
//             fontSize: 20,
//             decoration: textDecoration,
//             fontWeight: FontWeight.bold),
//       );
//     }
//   }
//
//   Widget buildDate() {
//     final dateFormatter = DateFormat('dd MMMM h:mm a');
//     final dateString = dateFormatter.format(taskItem.dateTime);
//     return Text(
//       dateString,
//       style: TextStyle(decoration: textDecoration),
//     );
//   }
//   Widget buildCheckBox() {
//     return Checkbox(
//         value: taskItem.isCompleted,
//
//       onChanged: (value){
//           onComplete!(taskItem.isCompleted = value!);
//       },
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//
//     bool isChecked = false;
//     return Container(
//       padding: const EdgeInsets.all(8),
//       height: 115,
//       color: Colors.white,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 taskItem.title,
//                 style: GoogleFonts.openSans(
//                   fontSize: 21,
//                   decoration: textDecoration,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 taskItem.subTitle,
//                 style: GoogleFonts.openSans(
//                     fontSize: 18,
//                     decoration: textDecoration,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black),
//               ),
//               buildDate(),
//               buildImportance(),
//             ],
//           ),
//           buildCheckBox(),
//           // Checkbox(value: widget.taskItem.isCompleted , onChanged: (value){
//           //   setState(() {
//           //     widget.taskItem.isCompleted = value ?? false;
//           //   });
//           // })
//         ],
//       ),
//     );
//   }
// }

class TaskTile extends ConsumerStatefulWidget {
  final TaskData taskItem;

  const TaskTile({
    super.key,
    required this.taskItem,
  });

  @override
  ConsumerState<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends ConsumerState<TaskTile> {
  @override
  Widget build(BuildContext context) {
    final update = ref.watch(taskDataProvider);
    Widget buildImportance() {
      if (widget.taskItem.importance == Importance.low) {
        return Text(
          'low',
          style: GoogleFonts.openSans(
            color: Colors.grey,
            fontSize: 20,
            decoration:  update.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            fontWeight: FontWeight.w500,
          ),
        );
      } else if (widget.taskItem.importance == Importance.medium) {
        return Text(
          'medium',
          style: GoogleFonts.openSans(
              color: Colors.black,
              fontSize: 20,
              decoration:  update.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
              fontWeight: FontWeight.w700),
        );
      } else {
        return Text(
          'high',
          style: GoogleFonts.openSans(
              color: Colors.red,
              fontSize: 20,
              decoration: update.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
              fontWeight: FontWeight.bold),
        );
      }
    }

    Widget buildDate() {
      final dateFormatter = DateFormat('dd MMMM h:mm a');
      final dateString = dateFormatter.format(widget.taskItem.dateTime);
      return Text(
        dateString,
        style: TextStyle(decoration:update.isCompleted ? TextDecoration.lineThrough : TextDecoration.none),
      );
    }
    return Container(
      padding: const EdgeInsets.all(8),
      height: 115,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.taskItem.title,
                style: GoogleFonts.openSans(
                  fontSize: 21,
                  decoration: update.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.taskItem.subTitle,
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    decoration: update.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              buildDate(),
              buildImportance(),
            ],
          ),
          Checkbox(
            value: update.isCompleted,
            onChanged: (value) {
              ref.read(taskDataProvider.notifier).toggleCompleted();

              print('What am i: ${widget.taskItem.isCompleted}');
            },
          ),
        ],
      ),
    );
  }
}
