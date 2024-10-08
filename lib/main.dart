
import 'package:finalproject/pages/EventScreen.dart';
import 'package:finalproject/pages/home_page.dart';
import 'package:finalproject/provider/EventProvider.dart';
import 'package:finalproject/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Customs/BottomNavBar.dart';

void main() {
  runApp(const CalendarApp());
}

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => EventtProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.transparent,
          hintColor: Colors.white,
        ),
        home: BottomNavBar(),
      ));
}
