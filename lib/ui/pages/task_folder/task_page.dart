import 'package:flutter/material.dart';
import 'package:task_planner_app/ui/pages/task_folder/task_adder.dart';
import 'package:task_planner_app/ui/pages/task_folder/task_display.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

 void _showPopup(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const TaskAdder();
        },
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Page"),),
      backgroundColor: const Color.fromARGB(255, 53, 203, 226),
     
      body:Center(
        child:Expanded(child: TaskDisplay(),)
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
          onPressed: () {
           _showPopup(context);
          },
          child:const Icon(
            Icons.add,
            size: 30,
            color: Color.fromARGB(255, 53, 203, 226),
          )),
    );
  }
}
