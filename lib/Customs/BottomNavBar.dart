import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finalproject/pages/EventForm.dart';
import 'package:finalproject/pages/EventScreen.dart';
import 'package:finalproject/widgets/Add_widget.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIdx = 0; // Moved outside the build method for state management

  @override
  Widget build(BuildContext context) {
    Color bgc = Colors.blueGrey;

    List<Widget> screens = [
      const EventScreen(),
      const AddWidget(),
    ];

    return CurvedNavigationBar(
      backgroundColor: Colors.black,
      buttonBackgroundColor: Colors.purple,
      color: bgc,
      height: 60,
      onTap: (value) {
        setState(() {
          selectedIdx = value;
        });

        if (value != 1) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => screens[selectedIdx]));
        } else {
          showModalBottomSheet(context: context, builder: (context)=>AddWidget());
        }
      },
      items: [
        _buildNavIcons(Icons.event, "Events",
            selectedIdx==0),

        _buildNavIcons(
            Icons.add, "Add",selectedIdx==1),

        _buildNavIcons(Icons.checklist, "Todo",
            selectedIdx==2),
      ],
    );
  }
}

Widget _buildNavIcons(IconData icon, String label, bool isSelected) {
  Color c = Colors.grey[400]!;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: c,
          size: isSelected ? 30 : 24,
        ),
        const SizedBox(height: 4),
        if (!isSelected)
          Text(
            label,
            style: TextStyle(
              color: c,
              fontSize: 12,
            ),
          ),
      ],
    ),
  );
}
