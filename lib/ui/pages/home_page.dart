// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../components/bottom_navigation_bar.dart';
import 'settings_page.dart';
import 'task_folder/task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedindex = 0;

  void navigate(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  final List<Widget> _pages = [const TaskPage(),  SettingsPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 216, 215, 215),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          })),
      drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 93, 98, 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children:[
              //   DrawerHeader(
              //     child: Image.asset(
              //   "lib/images/logo1.jpg",
              //   height: 900,
              // )
              // ),
              ListTile(
                  leading: Icon(Icons.home, color: Colors.white),
                  title: Text(
                    "Tasks",
                    style: TextStyle(color: Colors.white),
                  )),
              ListTile(
                  leading: Icon(Icons.info, color: Colors.white),
                  title: Text("Settings", style: TextStyle(color: Colors.white))),]),
              ListTile(
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text("Logout", style: TextStyle(color: Colors.white))),
            ],
          )),
      
      bottomNavigationBar:
          BottomNavigationPage(onTabChange1: (index) => navigate(index)),
      body: _pages[_selectedindex],
    );
  }
}
