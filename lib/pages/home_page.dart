// import 'package:calendar_app/pages/event_editing_page.dart';
// import 'package:calendar_app/widgets/calendar_widget.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Calendar"),
//         centerTitle: true,
//       ),
//       body: CalendarWidget(),
//       floatingActionButton: FloatingActionButton(
//           child: Icon(
//             Icons.add,
//             color: Colors.white,
//           ),
//           backgroundColor: Colors.cyan,
//           onPressed: () => Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => EventEditingPage()),
//               )),
//     );
//   }
// }
<<<<<<< HEAD
import 'package:calendar_app/pages/event_editing_page.dart';
import 'package:calendar_app/widgets/calendar_widget.dart';
import 'package:flutter/material.dart';

=======

import 'package:flutter/material.dart';

import '../widgets/calendar_widget.dart';
import 'event_editing_page.dart';

>>>>>>> 416b7fbcac06d38f4b4c41c7e42fd0eedcd617f2
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
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
        child: CalendarWidget(), // Your calendar widget
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.cyan,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EventEditingPage()),
        ),
      ),
    );
  }
}
