import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/app_utils/constant/app_spacing.dart';
import 'package:taskmanager/models/task_data.dart';

class TasksItemScreen extends StatefulWidget {
  final Function(TaskData) onCreate;
  final Function(TaskData) onUpdate;
  final bool isUpdating;
  final TaskData? originalTask;

  const TasksItemScreen(
      {super.key,
      required this.onCreate,
      required this.onUpdate,
      this.originalTask})
      : isUpdating = (originalTask != null);

  @override
  State<TasksItemScreen> createState() => _TasksItemScreenState();
}

class _TasksItemScreenState extends State<TasksItemScreen> {
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
      _dueDate = date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _importance = originalTask.importance;
      _titleController.text = originalTask.title;
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
          controller: _titleController,
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

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
