import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../models/event_data_source.dart';
import '../pages/event_viewing_page.dart';
import '../provider/event_provider.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context, listen: false);
    final selectedEvents = provider.eventsOfSelectedDate;
    if (selectedEvents.isEmpty) {
      return Center(
        child: Text(
          "No Events",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      );
    }

    return SfCalendarTheme(
        data: SfCalendarThemeData(
            timeTextStyle: TextStyle(fontSize: 16, color: Colors.white)),
        child: SfCalendar(
          view: CalendarView.timelineDay,
          dataSource: EventDataSource(provider.events),
          headerHeight: 0,
          todayHighlightColor: Colors.white,
          initialDisplayDate: provider.selectedDate,
          appointmentBuilder: appointmentBuilder,
          selectionDecoration: BoxDecoration(
              color: const Color.fromARGB(255, 56, 9, 149).withOpacity(0.3)),
          onTap: (details) {
            if (details.appointments == null) return;
            final event = details.appointments!.first;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EventViewingPage(event: event)));
          },
        ));
  }

  Widget appointmentBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final event = details.appointments.first;
    return Container(
      decoration: BoxDecoration(
          color: event.backgroundColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12)),
      width: details.bounds.width,
      height: details.bounds.height,
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
//test editing 