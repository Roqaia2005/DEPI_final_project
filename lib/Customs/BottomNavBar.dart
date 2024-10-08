import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finalproject/pages/EventScreen.dart';
import 'package:finalproject/widgets/Add_widget.dart';
import 'package:flutter/material.dart';

import '../pages/Todo.dart';
import '../pages/home_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIdx=1;
  int changeIdx=0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const EventScreen(),
      const AddWidget(),
      const NotesViewBody(),
    ];
    return Scaffold(
      body: screens[changeIdx],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black,
        buttonBackgroundColor: Colors.purple,
        color: Colors.blueGrey,
        height: 60,
        index: 1,
        onTap: (value) {
          setState(() {
            if(value==1){
              selectedIdx=value;
              showModalBottomSheet(
                  context: context, builder: (context) => const AddWidget());
            }
            else {
              selectedIdx = value;
              changeIdx=value;
            }
          });

        },
        items: [
          _buildNavIcons(Icons.event, "Events", selectedIdx == 0),
          _buildNavIcons(Icons.add, "Add", selectedIdx == 1),
          _buildNavIcons(Icons.checklist, "Todo", selectedIdx == 2),
        ],
      ),
    );  }
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
