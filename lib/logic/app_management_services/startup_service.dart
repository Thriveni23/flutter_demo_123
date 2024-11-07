import 'package:task_planner_app/locator.dart';

class StartupService {

  init() async{
     await Locator.hiveService.init();
     await setupApplicationData();
await Locator.taskManagementService.init();
  }

  setupApplicationData() async {
   
      if (Locator.hiveService.taskBox!.isNotEmpty) {
        var taskList =
            await Locator.taskDatabaseService.readTaskFromLocal();
        Locator.taskManagementService.taskList.value = taskList!;
      }
      
    }
  
}