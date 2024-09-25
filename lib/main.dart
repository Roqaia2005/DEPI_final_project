import 'package:calendar_app/pages/home_page.dart';
import 'package:calendar_app/provider/event_provider.dart';
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




