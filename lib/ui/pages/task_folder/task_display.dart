import 'package:flutter/material.dart';
import 'package:task_planner_app/logic/task_management_service.dart';
import 'package:task_planner_app/ui/pages/task_folder/task_tile.dart';
import 'package:watch_it/watch_it.dart';

class TaskDisplay extends StatelessWidget with WatchItMixin {
  const TaskDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var taskListToDisplay =
        watchValue((TaskManagementService x) => x.tasksToDisplay);
    
    print('TaskDisplay building with ${taskListToDisplay.length} items');
    
    return Padding(
         padding: const EdgeInsets.only(top: 16.0),

      child: SizedBox(
        width: screenWidth,
        child: ListView.builder(
          itemCount: taskListToDisplay.length,
          itemBuilder: (context, index) {
            final task = taskListToDisplay[index];
            print('Building item $index with task: $task');
            return TaskTile(task: task);
          },
        ),
      ),
    );
  }
}