<<<<<<< HEAD
import 'package:calendar_app/pages/home_page.dart';
import 'package:calendar_app/provider/event_provider.dart';
=======
import 'package:finalproject/pages/home_page.dart';
import 'package:finalproject/provider/event_provider.dart';
>>>>>>> 416b7fbcac06d38f4b4c41c7e42fd0eedcd617f2
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CalendarApp());
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>ChangeNotifierProvider(
    create:(context)=>EventProvider(),
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        hintColor:Colors.white,
        
        
      ),
      
      home: HomePage(),
    ));
  }




