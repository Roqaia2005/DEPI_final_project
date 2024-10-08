import 'package:flutter/material.dart';

import '../models/event.dart';

class EventProvider extends ChangeNotifier{
  List<Event> events=[];
  List<String> eventsTitle=[];

  bool addEvent(Event newEvent){
    bool response=false;
    if(!eventsTitle.contains(newEvent.title)){
      events.add(newEvent);
      eventsTitle.add(newEvent.title);
      response=true;
      notifyListeners();
    }

   return response;
  }

  removeEvent(Event event){
    events.remove(event);
    notifyListeners();
  }

  bool checkTitle(String title){
    return !eventsTitle.contains(title);
  }
}