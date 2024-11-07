import 'package:flutter/services.dart';
import 'package:task_planner_app/data/data_model/task_model.dart';
import 'package:task_planner_app/locator.dart';
import 'package:uuid/uuid.dart';

class TaskDatabaseService {
  init() {}

  Future<List<TaskModel>?> readTaskFromLocal() async {
    var taskList = Locator.hiveService.taskBox?.values.toList();
    taskList?.forEach((element) {
      print(element.toJson());
    });
    return taskList;
  }
}
