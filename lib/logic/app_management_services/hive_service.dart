import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_planner_app/data/data_model/task_model.dart';

class HiveService {
    Box<TaskModel>? taskBox;

     init() async{
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    taskBox=await Hive.openBox<TaskModel>("taskBox");
   
}


clearAllBox(){
  taskBox?.clear();
}
}