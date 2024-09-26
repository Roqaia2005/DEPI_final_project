<<<<<<< HEAD
import 'package:calendar_app/models/event.dart';
import 'package:flutter/material.dart';

=======
import 'package:flutter/material.dart';

import '../models/event.dart';

>>>>>>> 416b7fbcac06d38f4b4c41c7e42fd0eedcd617f2
class EventProvider extends ChangeNotifier {
  final List<Event> _events = [];
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  List<Event> get eventsOfSelectedDate => _events;

  List<Event> get events => _events;

  void addEvent(Event event) {
    _events.add(event);

    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }

// void editEvent(Event newEvent, Event oldEvent) {
//   final index = _events.indexOf(oldEvent);
//   if (index != -1) {
//     _events[index] = newEvent;
//     notifyListeners();
//   }
// }
  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events
        .indexWhere((event) => event == oldEvent); // Find the exact event
    if (index != -1) {
      _events[index] = newEvent; // Replace the old event with the new one
      notifyListeners(); // Notify listeners about the change
    }
  }
}
