import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'event.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Eventt> appointments) {
    this.appointments = appointments;
  }
  Eventt getEvent(int index) => appointments![index] as Eventt;

  @override
  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title;

  @override
  Color getColor(int index) => getEvent(index).backgroundColor;
  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;
}
