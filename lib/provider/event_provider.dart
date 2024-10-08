
import 'package:flutter/material.dart';

import '../models/event.dart';




class EventtProvider extends ChangeNotifier {
  final List<Eventt> _events = [];
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  List<Eventt> get eventsOfSelectedDate => _events;

  List<Eventt> get events => _events;

  void addEvent(Eventt event) {
    _events.add(event);

    notifyListeners();
  }

  void deleteEvent(Eventt event) {
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
  void editEvent(Eventt newEvent, Eventt oldEvent) {
    final index = _events
        .indexWhere((event) => event == oldEvent); // Find the exact event
    if (index != -1) {
      _events[index] = newEvent; // Replace the old event with the new one
      notifyListeners(); // Notify listeners about the change
    }
  }
}
