import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_take_media/LOGIN_SCREEN/LoginScreen.dart';
import 'package:one_take_media/SPLASH_SCREEN/splash_screen.dart';

class footer extends StatelessWidget{
 const footer({super.key});-
 @override
  Widget build(BuildContext content){
   return BottomNavigationBar(
       selectedItemColor: Colors.white,
       unselectedItemColor: Colors.blueAccent,
       items:const [
         BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home",activeIcon: AnimatedSize(duration: Duration(seconds: 2))),
         BottomNavigationBarItem(icon: Icon(Icons.eighteen_up_rating),label: "Acount"),
         BottomNavigationBarItem(icon: Icon(Icons.two_mp_rounded),label: "manager"),
         BottomNavigationBarItem(icon: Icon(Icons.wb_twilight_sharp),label: "Heekee"),
       ],
       onTap: (index){
         switch(index){
           case 0:
             Navigator.pop(content);
             break;
           case 1:
             Navigator.push(content,MaterialPageRoute(builder: (_)=>LoginScreen()));
             break;
           case 2:
             Navigator.push(content, MaterialPageRoute(builder: (_)=>SplashScreen()));
           case 3:
             Navigator.push(content, MaterialPageRoute(builder: (_)=>LoginScreen()));
         }
   },
   );
 }
}
