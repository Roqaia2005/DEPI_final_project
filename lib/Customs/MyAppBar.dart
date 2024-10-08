import 'package:finalproject/pages/home_page.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget getAppBar(
    {required BuildContext context, required String title, TabBar? tabBar}) {
  Color c = Colors.purple;
  return AppBar(
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    centerTitle: true,
    leading: title!="TimeVesta"? IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      icon: const Icon(Icons.calendar_month),
      color: c,
    ):null,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.person),
        color: c,
      ),
    ],
    bottom: tabBar,
  );
}
