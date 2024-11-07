import 'package:flutter/material.dart';
import 'package:task_planner_app/data/data_model/task_model.dart';
import 'package:task_planner_app/locator.dart';
import 'package:uuid/uuid.dart';

class TaskManagementService {
  var taskList = ValueNotifier<List<TaskModel>>([]);
  var tasksToDisplay = ValueNotifier<List<TaskModel>>([]);
  var taskQuery = ValueNotifier<String>("");
  var taskFilter = ValueNotifier<List<String>>([]);

  init() {
    streamTasks();
    taskQuery.addListener(setTasksToDisplay);
    taskList.addListener(setTasksToDisplay);
  }

  void setTasksToDisplay() {
    if (taskQuery.value.isEmpty) {
      // If there's no query, just get all tasks
      tasksToDisplay.value = Locator.hiveService.taskBox!.values.toList();
    } else {
      // If there's a query, filter and sort tasks
      var filteredTasks = Locator.hiveService.taskBox!.values
          .where((element) =>
              element != null &&
              element.taskField != null &&
              element.taskField!
                  .toLowerCase()
                  .contains(taskQuery.value.toLowerCase()))
          .toList();

      filteredTasks.sort(((a, b) => a.taskField?.toLowerCase() == null ||
              b.taskField?.toLowerCase() == null
          ? 0
          : a.taskField!.toLowerCase().compareTo(b.taskField!.toLowerCase())));
    }
  }

  createLocal(TaskModel task) {
    var uuid = const Uuid();
    task.documentId = uuid.v4();
    Locator.hiveService.taskBox!.put(task.documentId!, task);
    print(task.taskField);
    print(task.createdOn);
    print("created");
    taskList.value = [...taskList.value, task];
  }

  void deleteTask(TaskModel task) {
    taskList.value =
        taskList.value.where((p) => p.documentId != task.documentId).toList();
    Locator.hiveService.taskBox!.delete(task.documentId);
    setTasksToDisplay();
  }

    Future<void> updateTask(TaskModel task) async {
    var taskBox = Locator.hiveService.taskBox;
    if (taskBox != null && taskBox.length > 0) {
      try {
       
        await taskBox.put(task.documentId!, task);
        
       
        int index = taskList.value.indexWhere((t) => t.documentId == task.documentId);

        if (index != -1) {
         
          taskList.value[index] = task;

          
          setTasksToDisplay();

          print('Task updated successfully');
        } else {
          print('Task not found in the taskList');
        }
      } catch (e) {
        print('Error updating task: $e');
      }
    }
  }

  streamTasks() {
    taskList.value = Locator.hiveService.taskBox!.values.toList();
    var taskStream = Locator.hiveService.taskBox!.watch();
    taskStream.listen((event) {
      taskList.value = Locator.hiveService.taskBox!.values.toList();
    });
    tasksToDisplay.value = taskList.value;

    // setBrandList();
  }
}
