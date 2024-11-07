import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  String? taskField;

  @HiveField(1)
  String? documentId;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  DateTime? createdOn;

   @HiveField(4)
  DateTime? reminderDate;

  

  TaskModel({
    this.taskField,
    this.documentId,
    this.isCompleted = false,
    this.createdOn,
    this.reminderDate,

  });

  factory TaskModel.fromJson(Map<String, dynamic> json, String documentId) {
    return TaskModel(
      documentId: documentId,
      taskField: (json['taskField'] is String) ? json['taskField'] : '',
      isCompleted: json['isCompleted'] ?? false,
      createdOn: json['createdOn'] != null 
        ? DateTime.parse(json['createdOn'])
        : null,
      reminderDate: json['reminderDate'] != null 
        ? DateTime.parse(json['reminderDate'])
        : null,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'taskField': taskField,
      'isCompleted': isCompleted,
      'createdOn': createdOn?.toIso8601String(),
      'reminderDate': reminderDate?.toIso8601String(),

    };
  }
}