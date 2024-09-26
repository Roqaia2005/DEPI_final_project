
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/event.dart';
import '../provider/event_provider.dart';
import '../utils.dart';
import 'home_page.dart';




// class EventEditingPage extends StatefulWidget {
//   EventEditingPage({super.key, this.event});
//   final Event? event;

//   @override
//   State<EventEditingPage> createState() => _EventEditingPageState();
// }

// class _EventEditingPageState extends State<EventEditingPage> {
//   final _formKey = GlobalKey<FormState>();
//   final titleController = TextEditingController();
//   late DateTime fromDate;
//   late DateTime toDate;

//   @override
//   void initState() {
//     super.initState();
//     fromDate = widget.event?.from ?? DateTime.now();
//     toDate = widget.event?.to ?? fromDate.add(const Duration(hours: 2));
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: CloseButton(),
//         actions: buildEditingActions(),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(12),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[buildTitle()],
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> buildEditingActions() {
//     return [
//       ElevatedButton.icon(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//         ),
//         onPressed: saveForm,
//         label: Text("SAVE"),
//         icon: Icon(Icons.done),
//       )
//     ];
//   }

//   Widget buildTitle() {
//     return TextFormField(
//       style: TextStyle(fontSize: 24),
//       decoration: InputDecoration(
//         border: UnderlineInputBorder(),
//         hintText: "Add title",
//       ),
//       onFieldSubmitted: (_) {
//         saveForm();
//       },
//       validator: (title) =>
//           title != null && title.isEmpty ? "Title cannot be empty" : null,
//       controller: titleController,
//     );
//   }

//   Widget buildDateTimePicker() {
//     return Column(
//       children: [buildFrom(), buildTo()],
//     );
//   }

//   Widget buildFrom() {
//     return buildHeader(
//       header: "From",
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: buildDropDownField(
//                 text: Utils.toDate(fromDate),
//                 onClicked: () => pickFromDataTime(pickDate: true)),
//           ),
//           Expanded(
//             child: buildDropDownField(
//                 text: Utils.toDate(fromDate),
//                 onClicked: () => pickFromDataTime(pickDate: false)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildTo() {
//     return buildHeader(
//       header: "To",
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: buildDropDownField(
//                 text: Utils.toDate(toDate),
//                 onClicked: () => pickToDataTime(pickDate: true)),
//           ),
//           Expanded(
//             child: buildDropDownField(
//                 text: Utils.toTime(toDate),
//                 onClicked: () => pickToDataTime(pickDate: true)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDropDownField(
//           {required String text, required VoidCallback onClicked}) =>
//       ListTile(
//         title: Text(text),
//         trailing: Icon(Icons.arrow_drop_down),
//         onTap: onClicked,
//       );

//   Widget buildHeader({required String header, required Widget child}) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             header,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           child
//         ],
//       );

//   Future saveForm() async {
//     final isValid = _formKey.currentState!.validate();
//     if (isValid) {
//       final event = Event(
//           title: titleController.text,
//           from: fromDate,
//           to: toDate,
//           description: "Description",
//           isAllDay: false);
//       final provider = Provider.of<EventProvider>(
//         context,
//       );
//       provider.addEvent(event);
//       Navigator.of(context).pop();
//     }
//   }

//   Future pickFromDataTime({required bool pickDate}) async {
//     final date = await pickDateTime(fromDate, pickDate: pickDate);
//     if (date == null) {
//       return;
//     }
//     if (date.isAfter(toDate)) {
//       toDate =
//           DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
//     }
//     setState(() {
//       fromDate = date;
//     });
//   }

//   Future pickToDataTime({required bool pickDate}) async {
//     final date = await pickDateTime(toDate,
//         pickDate: pickDate, firstDate: pickDate ? fromDate : null);
//     if (date == null) {
//       return;
//     }

//     setState(() {
//       toDate = date;
//     });
//   }

//   Future<DateTime?> pickDateTime(DateTime initialDate,
//       {required bool pickDate, required, DateTime? firstDate}) async {
//     if (pickDate) {
//       final date = await showDatePicker(
//           context: context,
//           initialDate: initialDate,
//           firstDate: firstDate ?? DateTime(2015, 8),
//           lastDate: DateTime(2101));
//       if (date == null) {
//         return null;
//       }
//       final time =
//           Duration(hours: initialDate.hour, minutes: initialDate.minute);
//       return date.add(time);
//     } else {
//       final timeOfDay = await showTimePicker(
//           context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
//       if (timeOfDay == null) {
//         return null;
//       }
//       final date =
//           DateTime(initialDate.year, initialDate.month, initialDate.day);
//       final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

//       return date.add(time);
//     }
//   }
// }
class EventEditingPage extends StatefulWidget {
  EventEditingPage({super.key, this.event});
  final Event? event;

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();
    fromDate = widget.event?.from ?? DateTime.now();
    toDate = widget.event?.to ?? fromDate.add(const Duration(hours: 2));

    // Initialize controllers if event exists
    if (widget.event != null) {
      titleController.text = widget.event!.title;
      descriptionController.text = widget.event!.description;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8E2DE2), // Purple
              Color(0xFF4A00E0), // Darker Purple
              Color(0xFF00C6FF), // Light Blue
            ],
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildEditingActions(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildTitle(),
                buildDateTimePicker(),
                buildDescription(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildEditingActions() {
    return [
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: saveForm,
        label: Text("SAVE"),
        icon: Icon(Icons.done),
      )
    ];
  }

  Widget buildTitle() {
    return TextFormField(
      style: TextStyle(fontSize: 24),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: "Add title",
      ),
      validator: (title) =>
          title?.isEmpty ?? true ? "Title cannot be empty" : null,
      controller: titleController,
    );
  }

  Widget buildDescription() {
    return TextFormField(
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: "Add description",
      ),
      controller: descriptionController,
    );
  }

  Widget buildDateTimePicker() {
    return Column(
      children: [buildFrom(), buildTo()],
    );
  }

  Widget buildFrom() {
    return buildHeader(
      header: "From",
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: buildDropDownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true)),
          ),
          Expanded(
            child: buildDropDownField(
                text: Utils.toTime(fromDate),
                onClicked: () => pickFromDateTime(pickDate: false)),
          ),
        ],
      ),
    );
  }

  Widget buildTo() {
    return buildHeader(
      header: "To",
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: buildDropDownField(
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true)),
          ),
          Expanded(
            child: buildDropDownField(
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false)),
          ),
        ],
      ),
    );
  }

  Widget buildDropDownField(
          {required String text, required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Widget buildHeader({required String header, required Widget child}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          child
        ],
      );

  // Future saveForm() async {
  //   final isValid = _formKey.currentState!.validate();
  //   if (!isValid) return;

  //   final event = Event(
  //     title: titleController.text,
  //     from: fromDate,
  //     to: toDate,
  //     description: descriptionController.text,
  //     isAllDay: false,
  //   );

  //   final isEditing = widget.event != null;

  //   final provider = Provider.of<EventProvider>(context, listen: false);
  //   if (isEditing) {
  //     provider.editEvent(event, widget.event!);
  //   } else {
  //     provider.addEvent(event);
  //   }

  //   Navigator.of(context).pop();
  // }
Future saveForm() async {
  final isValid = _formKey.currentState!.validate();
  if (isValid) {
    // Create the updated event
    final newEvent = Event(
      title: titleController.text,
      from: fromDate,
      to: toDate,
      description: descriptionController.text,  // Change as needed
      isAllDay: false,
    );

    final provider = Provider.of<EventProvider>(context, listen: false);

    // Check if editing an existing event or adding a new one
    if (widget.event != null) {
      // Edit the existing event
      provider.editEvent(newEvent, widget.event!);
    } else {
      // Add new event
      provider.addEvent(newEvent);
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
  }
}



  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() {
      fromDate = date;
    });
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate,
        pickDate: pickDate, firstDate: pickDate ? fromDate : null);
    if (date == null) return;

    setState(() {
      toDate = date;
    });
  }

  Future<DateTime?> pickDateTime(DateTime initialDate,
      {required bool pickDate, DateTime? firstDate}) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }
}
