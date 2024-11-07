import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigationPage extends StatelessWidget {
  Function(int)? onTabChange1;
   BottomNavigationPage({super.key,required this.onTabChange1});
   

  @override
  Widget build(BuildContext context) {
    return Container(
      child:GNav(tabs: [
       GButton(icon:Icons.home,text:"Tasks"),
       GButton(icon:Icons.shop,text:"Settings")
      ],
      onTabChange: (value)=>onTabChange1!(value),
      
      activeColor: Colors.white,
      mainAxisAlignment: MainAxisAlignment.center,)
    );
  }
} 