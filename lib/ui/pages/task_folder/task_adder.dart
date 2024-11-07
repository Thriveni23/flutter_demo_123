import 'package:flutter/material.dart';
import 'package:task_planner_app/data/data_model/task_model.dart';
import 'package:task_planner_app/locator.dart';
import 'package:intl/intl.dart';

class TaskAdder extends StatefulWidget {
  const TaskAdder({super.key});

  @override
  State<TaskAdder> createState() => _TaskAdderState();
}

class _TaskAdderState extends State<TaskAdder> {
  final TextEditingController taskController = TextEditingController();
  DateTime? reminderDate;

  void addTask() {
    final taskField = taskController.text;

    TaskModel task = TaskModel(
      documentId: '',
      taskField: taskField,
      isCompleted: false,
      createdOn: DateTime.now(),
      reminderDate: reminderDate,
    );

    Locator.taskManagementService.createLocal(task);
    Navigator.of(context).pop();
  }

  void _selectDateAndTime(BuildContext context) async {
    // Select Date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      // Select Time
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 12, minute: 0), // Set default time to 12:00 PM
      );

      if (pickedTime != null) {
        setState(() {
          // Combine selected date and time
          reminderDate = pickedDate.add(Duration(hours: pickedTime.hour, minutes: pickedTime.minute));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 163, 216, 240),
      title: Text('Add a Task :)'),
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(labelText: 'Enter Task'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectDateAndTime(context), // Call the updated method
              child: Text(reminderDate != null 
                ? 'Reminder: ${DateFormat.yMd().add_jm().format(reminderDate!)}'
                : 'Select Reminder Date'
              ),
            ),
            SizedBox(height: 8),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: addTask,
              child: Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
