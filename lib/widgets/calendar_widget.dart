<<<<<<< HEAD
import 'package:calendar_app/models/event_data_source.dart';
import 'package:calendar_app/provider/event_provider.dart';
import 'package:calendar_app/widgets/tasks_widget.dart';
=======

import 'package:finalproject/widgets/tasks_widget.dart';
>>>>>>> 416b7fbcac06d38f4b4c41c7e42fd0eedcd617f2
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

<<<<<<< HEAD
=======
import '../models/event_data_source.dart';
import '../provider/event_provider.dart';

>>>>>>> 416b7fbcac06d38f4b4c41c7e42fd0eedcd617f2
class CalendarWidget extends StatelessWidget {
  CalendarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return SfCalendar(
        view: CalendarView.month,
        dataSource: EventDataSource(events),
        initialSelectedDate: DateTime.now(),
        cellBorderColor: Colors.transparent,
        onLongPress: (details) {
          final provider = Provider.of<EventProvider>(context, listen: false);
          provider.setDate(details.date!);
          showModalBottomSheet(
            context: context,
            builder: (context) => TasksWidget(),
          );
        });
  }
}
