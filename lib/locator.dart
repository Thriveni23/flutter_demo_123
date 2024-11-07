import 'package:get_it/get_it.dart';
import 'package:task_planner_app/data/database_services/task_database_service.dart';
import 'package:task_planner_app/logic/app_management_services/hive_service.dart';
import 'package:task_planner_app/logic/app_management_services/navigation_service.dart';
import 'package:task_planner_app/logic/app_management_services/startup_service.dart';
import 'package:task_planner_app/logic/task_management_service.dart';
import 'package:task_planner_app/logic/task_notification_management_service.dart';

class Locator{
  static void setup(){
    GetIt.instance.registerLazySingleton(() => StartupService());
    GetIt.instance.registerLazySingleton(() => HiveService());
    GetIt.instance.registerLazySingleton(() => NavigationService());
     GetIt.instance.registerLazySingleton(() => TaskDatabaseService());
      GetIt.instance.registerLazySingleton(() => TaskManagementService());
      GetIt.instance.registerLazySingleton(()=>TaskNotificationManagementService());
  }
     static StartupService get startupService => GetIt.I<StartupService>();
  static HiveService get hiveService => GetIt.I<HiveService>();
  
  static NavigationService get navigationService =>
      GetIt.I<NavigationService>();
  static TaskDatabaseService get taskDatabaseService =>
      GetIt.I<TaskDatabaseService>();
  static TaskManagementService get taskManagementService =>
      GetIt.I<TaskManagementService>(); 
  static TaskNotificationManagementService get taskNotificationManagementService=>
      GetIt.I<TaskNotificationManagementService>();
  
}