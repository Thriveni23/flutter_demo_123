import 'package:flutter/material.dart';
import 'package:task_planner_app/locator.dart';
import 'package:task_planner_app/logic/task_notification_management_service.dart';
import 'package:task_planner_app/ui/pages/intro_page.dart';
 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create an instance of your notification management service
  final taskNotificationService = TaskNotificationManagementService();
  await taskNotificationService.init(); // Ensure initialization

  Locator.setup();
  await Locator.startupService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}
