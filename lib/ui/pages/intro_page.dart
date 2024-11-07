// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_page.dart';


class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 53, 203, 226),
      body:Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Icon(Icons.task,size:50,color:Colors.white)),
            const SizedBox(height: 25,),
            Text("Streamline Your Workflow",textAlign: TextAlign.center,style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 30)),
            const SizedBox(height: 25,),
           Padding(
             padding: const EdgeInsets.all(25.0),
             child: Text("Organize Your Day,Simplify Your Life-->From To-Do List to Done List",textAlign: TextAlign.center,style:TextStyle(color:Colors.white,)),
           ),
        
           GestureDetector(
            onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())),
             child: Container(
        decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(10)),
        
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector( onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())),child: Text("Let's Gooo!!",style:TextStyle(color:const Color.fromARGB(255, 53, 203, 226),))),
        ),),
           )
          ],
        ),
      )
    );
  }
}