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

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../Customs/BottomNavBar.dart';
import '../Customs/MyAppBar.dart';
import '../widgets/calendar_widget.dart';
import 'event_editing_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "TimeVesta", context: context),
      //bottomNavigationBar: const BottomNavBar(),
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
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      //   backgroundColor: Colors.cyan,
      //   onPressed: () => Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => EventEditingPage()),
      //   ),
      // ),
    );
  }
}
