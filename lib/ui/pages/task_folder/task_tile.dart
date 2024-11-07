import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_planner_app/data/data_model/task_model.dart';
import 'package:task_planner_app/locator.dart';
import 'package:task_planner_app/ui/pages/task_folder/task_editor.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);

  final TaskModel task;

  void _showPopup(BuildContext context, task) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditTask(task: task);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMd().format(task.createdOn!);
    String remindOn=DateFormat.yMd().format(task.reminderDate!);
    
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Adjust this value for roundness
      ),
      elevation: 2.0, // Adjust this value for shadow depth
      child: Container(
        height: 150, // Adjust this value for tile height
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero, // Remove default padding
              tileColor: const Color.fromARGB(255, 172, 227, 255), // Make background transparent
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (bool? value) {
                  if (value != null) {
                    task.isCompleted = value;
                    Locator.taskManagementService.updateTask(task);
                  }
                },
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      task.taskField!,
                      style: TextStyle(
                        fontSize: 20,
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Locator.taskManagementService.deleteTask(task);
                    },
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showPopup(context, task);
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
                  ),
                ),
                const SizedBox(width:320),
                Padding(padding: const EdgeInsets.all(4.0),
                child:Text(
                    remindOn,
                    style:Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12,color: Colors.red),
                )
                )

              ],
            ),
             Center(
        child: ElevatedButton(
          onPressed: () {
            Locator.taskNotificationManagementService.scheduleTaskReminder(task);
          },
          child: Text("Set Task Reminder"),
        ),
      ),
          ],
        ),
      ),
    );
  }
}
