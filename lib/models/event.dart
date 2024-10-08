import 'package:flutter/material.dart';

class Eventt {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  const Eventt(
      {required this.title,
      required this.description,
      required this.from,
      required this.to,
      this.backgroundColor = Colors.lightBlue,
      this.isAllDay = false});
}

class Event {
  final String title;
  final String details;
  //late List<Notify> notification;

  Event({
    required this.title,
    required this.details,
  });
}
