import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task_planner_app/data/data_model/task_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TaskNotificationManagementService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late List<TaskModel> scheduledTasks = [];
  Timer? taskCheckerTimer;

  TaskNotificationManagementService() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    init();
  }

  Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'task_reminder_channel',
      'Task Reminders',
      description: 'Reminders for your tasks.',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        print('Notification payload: ${response.payload}');
      },
    );

    
    startDueTaskChecker();
  }

  Future<void> scheduleTaskReminder(TaskModel task) async {
    var notificationStatus = await Permission.notification.request();

    if (notificationStatus.isGranted) {
      scheduledTasks.add(task);
    } else {
      print('Notification permission was denied. Please enable it in settings.');
      openAppSettings();
    }
  }

 
  void startDueTaskChecker() {
    taskCheckerTimer = Timer.periodic(Duration(minutes: 1), (Timer timer) {
      _checkDueTasks();
    });
  }

  void _checkDueTasks() {
    final now = tz.TZDateTime.now(tz.local);
    List<TaskModel> dueTasks = [];

    for (var task in scheduledTasks) {
      if (task.reminderDate == null) continue;

      final reminderDate = tz.TZDateTime.from(task.reminderDate!, tz.local);

      if (reminderDate.isBefore(now)) {
        _showNotification(task);
        dueTasks.add(task); 
      }
    }

    scheduledTasks.removeWhere((task) => dueTasks.contains(task));
  }

  Future<void> _showNotification(TaskModel task) async {
    int uniqueId = DateTime.now().millisecondsSinceEpoch.remainder(2147483647);
   
    await flutterLocalNotificationsPlugin.show(
      uniqueId,
      'Task Reminder: ${task.taskField}',
      'Your task "${task.taskField}" is due on ${task.reminderDate?.toLocal().toString()}.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_reminder_channel',
          'Task Reminders',
          channelDescription: 'Reminders for your tasks.',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      
    );
    print('Notification shown successfully.');
  }

 
  void dispose() {
    taskCheckerTimer?.cancel();
  }
}
