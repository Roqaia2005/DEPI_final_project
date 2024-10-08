import 'package:finalproject/pages/EventForm.dart';
import 'package:flutter/material.dart';

import '../pages/Todo.dart';

class AddWidget extends StatelessWidget {
  const AddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Choose an option",style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                showModalBottomSheet(context: context, isScrollControlled: true, builder: (context)=>EventForm());
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.black)),
              child: const Text("Add Event")),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                //showDialog(context: context, builder: (context)=>NotesViewBody.AddTaskWidget());
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                  backgroundColor:
                  MaterialStateProperty.all(Colors.black)),
              child: const Text("Add Task"))
        ],
      ),
    );
  }
}
