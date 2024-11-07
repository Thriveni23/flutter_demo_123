import 'package:flutter/material.dart';
import 'package:task_planner_app/data/data_model/task_model.dart';
import 'package:task_planner_app/locator.dart';

class EditTask extends StatefulWidget {
  final TaskModel task;
  const EditTask({super.key, required this.task});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final TextEditingController taskController = TextEditingController();
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    taskController.text = widget.task.taskField!;
    isCompleted = widget.task.isCompleted;
  }

  void updateTask() {
    final taskField = taskController.text;

    TaskModel updatedTask = TaskModel(
      documentId: widget.task.documentId!,
      taskField: taskField,
      isCompleted: isCompleted,
    );
    
    
    Locator.taskManagementService.updateTask(updatedTask);
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 163, 216, 240),
      title: Text('Edit Task'),
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(labelText: 'Update Task'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Completed:'),
                Checkbox(
                  value: isCompleted,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null) {
                        isCompleted = value;
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: updateTask,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}