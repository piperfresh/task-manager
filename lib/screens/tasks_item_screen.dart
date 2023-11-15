import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/app_state/task_manager.dart';
import 'package:taskmanager/app_utils/constant/app_spacing.dart';
import 'package:taskmanager/models/task_data.dart';
import 'package:taskmanager/models/task_tile.dart';

import '../app_state/task_state.dart';

class TasksItemScreen extends ConsumerStatefulWidget {
  final Function(TaskData) onCreate;
  final Function(TaskData) onUpdate;
   bool? isUpdating;
  final int index;
  final TaskData? originalTask;

  //
   TasksItemScreen(
      {super.key,
      required this.onCreate,
      required this.onUpdate,
      this.index = -1,
      this.originalTask})
      : isUpdating = (originalTask != null);

  @override
  ConsumerState<TasksItemScreen> createState() => _TasksItemScreenState();
}

class _TasksItemScreenState extends ConsumerState<TasksItemScreen> {
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  String _title = '';
  String _subtitle = '';
  DateTime _dueDate = DateTime.now();
  Importance _importance = Importance.low;
  TimeOfDay _timeOfDay = TimeOfDay.now();


  //? When the originalTask is not null, the user is editing an existing item. In this
  //? case, you must configure the widget to show the item’s values.
  @override
  void initState() {
    final originalTask = widget.originalTask;
    if (originalTask != null) {
      final date = originalTask.dateTime;
      _title = originalTask.title;
      _subtitle = originalTask.subTitle;
      _subtitleController.text = originalTask.subTitle;
      _titleController.text = originalTask.title;
      _dueDate = date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _importance = originalTask.importance;
    }
    //? Adds a listener to listen for text field changes. When the text changes, you set the
    //? _title.
    _titleController.addListener(() {
      setState(() {
        _title = _titleController.text;
        _subtitle = _subtitleController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    _titleController.dispose();
    _subtitleController.dispose();
  }

  Widget buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task Title',
          style: GoogleFonts.openSans(fontSize: 20.0),
        ),
        TextField(
          style: const TextStyle(color: Colors.black),
          controller: _titleController,
          decoration: const InputDecoration(
              hintText: 'Go to gym',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple))),
        )
      ],
    );
  }

  Widget buildSubtitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task Subtitle',
          style: GoogleFonts.openSans(fontSize: 20.0),
        ),
        TextField(
          style: const TextStyle(color: Colors.black),
          controller: _subtitleController,
          decoration: const InputDecoration(
              hintText: 'Get it done',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple))),
        )
      ],
    );
  }

  Widget buildImportance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task Importance',
          style: GoogleFonts.openSans(fontSize: 20.0),
        ),
        Wrap(
          spacing: 10.0,
          children: [
            ChoiceChip(
              backgroundColor: Colors.black.withOpacity(0.7),
              label: const Text(
                'low',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.low,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.low;
                });
              },
            ),
            ChoiceChip(
              backgroundColor: Colors.black.withOpacity(0.7),
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.medium,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.medium;
                });
              },
            ),
            ChoiceChip(
              backgroundColor: Colors.black.withOpacity(0.7),
              label: const Text(
                'high',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.high,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.high;
                });
              },
            ),
          ],
        )
      ],
    );
  }

  Widget buildDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.openSans(fontSize: 20),
            ),
            TextButton(
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
              child: const Text('Select Date'),
            ),
          ],
        ),
        Text(
          DateFormat('dd-MM-yyyy').format(_dueDate),
          style: GoogleFonts.openSans(fontSize: 20),
        ),
      ],
    );
  }

  Widget buildTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time',
              style: GoogleFonts.openSans(fontSize: 20),
            ),
            TextButton(
                onPressed: () async {
                  final currentTime = TimeOfDay.now();
                  final pickedTime = await showTimePicker(
                      context: context, initialTime: currentTime);
                  setState(() {
                    if (pickedTime != null) {
                      _timeOfDay = pickedTime;
                    }
                  });
                },
                child: const Text('Select Time'))
          ],
        ),
        Text(_timeOfDay.format(context)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final update = ref.watch(taskDataProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Item',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildTitleField(),
            AppSpacer.smallVerticalSpacing,
            buildSubtitleField(),
            AppSpacer.smallVerticalSpacing,
            buildImportance(),
            AppSpacer.smallVerticalSpacing,
            buildDate(),
            AppSpacer.smallVerticalSpacing,
            buildTime(),
            AppSpacer.smallVerticalSpacing,
            TaskTile(
                taskItem: TaskData(
                  importance: _importance,
                  dateTime: DateTime(
                    _dueDate.year,
                    _dueDate.month,
                    _dueDate.day,
                    _timeOfDay.hour,
                    _timeOfDay.minute,
                  ),
                  id: 'Demo',
                  title: _title,
                  subTitle: _subtitle,
                  isCompleted: update.state.isCompleted
                ),
            ),
          ],
        ),
      ),
    );
  }
}
