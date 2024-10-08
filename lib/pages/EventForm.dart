import 'package:finalproject/models/event.dart';
import 'package:finalproject/provider/event_provider.dart';
import 'package:finalproject/widgets/AddNotification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/EventProvider.dart';

class EventForm extends StatefulWidget {
  EventForm({super.key});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();

  final dateTimeNow = DateTime.now();

  Color c = Colors.purple;

  List<String> notifications = [
    "Before 1 week",
    "Before 1 month",
    "Before 2 week"
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Color rangeColor = Colors.white;
  bool wantNotify = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          boxShadow: [
            BoxShadow(color: Colors.purple, spreadRadius: 2, blurRadius: 5)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  const Text(
                    "Add Event",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            Event event = Event(
                                title: _titleController.text,
                                details: _descriptionController.text);
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context);
                              Provider.of<EventProvider>(context, listen: false)
                                  .addEvent(event);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Event is added successfully')));
                            }
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.purple)),
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              //title
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _titleController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field can't be Empty!";
                                }
                                else if(!Provider.of<EventProvider>(context , listen:false).checkTitle(value)){
                                  return "Title must be Unique!";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Title",
                                helperText:
                                    "${_titleController.text.length}/32",
                                helperStyle: TextStyle(
                                    color: _titleController.text.length < 32
                                        ? Colors.white
                                        : Colors.red),
                                focusColor: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //countdown
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.date_range)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.timer_outlined)),
                                ],
                              )),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("June 5 2025 - 04:00 PM",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[400],
                                          fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //description
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Details",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              controller: _descriptionController,
                              maxLines: 8,
                              decoration: const InputDecoration(
                                hintText: "Write Event Details",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    //notification
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //notification and icon
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Set Notification",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Switch(
                                    value: (wantNotify),
                                    onChanged: (value) {
                                      setState(() {
                                        wantNotify = value;
                                      });
                                    },
                                    activeColor: c,
                                    thumbIcon:
                                        MaterialStateProperty.resolveWith<
                                            Icon?>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return const Icon(
                                            Icons.notifications_active);
                                      }
                                      return null;
                                    }))
                              ],
                            ),
                          ),

                          //notifyList
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: notifications.length,
                                itemBuilder: (context, index) {
                                  return _buildNotification(
                                      notifications[index]);
                                }),
                          ),

                          //add Notification Button
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AddNotificationDialog());
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.purple)),
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  "Add Notification",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15),
                                ),
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTitle(String title) {
  return (Text(
    title,
    style: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.grey[400], fontSize: 10),
  ));
}

Widget _buildTimer(
    {required Widget first, required Widget second, required String title}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white54, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [first, second],
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildTitle(title),
      ],
    ),
  );
}

Widget _buildNotification(String time) {
  return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              time,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.cancel,
              color: Colors.white,
              size: 25,
            ),
          ),
        ]),
      ));
}
