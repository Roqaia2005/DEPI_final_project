<<<<<<< HEAD
import 'package:calendar_app/pages/home_page.dart';
import 'package:calendar_app/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calendar_app/models/event.dart';

import 'event_editing_page.dart';
=======

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';
import '../provider/event_provider.dart';
import 'event_editing_page.dart';
import 'home_page.dart';
>>>>>>> 416b7fbcac06d38f4b4c41c7e42fd0eedcd617f2

class EventViewingPage extends StatefulWidget {
  final Event event;

  const EventViewingPage({super.key, required this.event});

  @override
  State<EventViewingPage> createState() => _EventViewingPageState();
}

class _EventViewingPageState extends State<EventViewingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF8E2DE2),
            Color(0xFF4A00E0),
            Color(0xFF00C6FF),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.event.title),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EventEditingPage(event: widget.event),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteEvent(context);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Event Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text("Title: ${widget.event.title}"),
              Text("From: ${widget.event.from}"),
              Text("To: ${widget.event.to}"),
              Text("Description: ${widget.event.description}"),
            ],
          ),
        ),
      ),
    );
  }

  void deleteEvent(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Event"),
        content: Text("Are you sure you want to delete this event?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: Text("Delete"),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (shouldDelete == true && widget.event != null) {
      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.deleteEvent(widget.event!);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
