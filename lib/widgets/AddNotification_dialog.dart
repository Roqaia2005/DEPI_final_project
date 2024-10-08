import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNotificationDialog extends StatefulWidget {
  const AddNotificationDialog({super.key});

  @override
  State<AddNotificationDialog> createState() => _AddNotificationDialogState();
}

class _AddNotificationDialogState extends State<AddNotificationDialog> {
  final List<String> _unitList = ["Months", "Weeks", "Days", "Hours"];

  DateTime date = DateTime(2025, DateTime.october);

  String _selectedUnit = "Months";
  late int _selectedTime;

  List<int> _generateTimeList(String unit) {
    int timeDiff = 0;

    final dateNow = DateTime.now();
    switch (unit) {
      case "Months":
        timeDiff = date.month - dateNow.month + 12 * (date.year - dateNow.year);
      case "Weeks":
        timeDiff = date.difference(dateNow).inDays ~/ 7;
      case "Days":
        timeDiff = date.difference(dateNow).inDays;
      case "Hours":
        timeDiff = date.difference(dateNow).inHours;
    }

    return List<int>.generate(timeDiff, (i) => i++);
  }

  DateFormat f = DateFormat('MMM d, y - hh:mm a');
  DateTime notificationDate = DateTime(2025, DateTime.october);

  _calculateNotifyDate() {
    switch (_selectedUnit) {
      case "Months":
        notificationDate = date.subtract(Duration(days: _selectedTime * 30));
      case "Weeks":
        notificationDate = date.subtract(Duration(days: _selectedTime * 7));
      case "Days":
        notificationDate = date.subtract(Duration(days: _selectedTime));
      case "Hours":
        notificationDate = date.subtract(Duration(hours: _selectedTime));
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<int>> notifyDates = {
      "Months": _generateTimeList("Months"),
      "Weeks": _generateTimeList("Weeks"),
      "Days": _generateTimeList("Days"),
      "Hours": _generateTimeList("Hours"),
    };
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15),
              child: Text(
                "Event Date: Oct 15 2024 - 04-00:pm",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                          itemExtent: 50.0,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedTime = index;
                              _calculateNotifyDate();
                            });
                          },
                          children: notifyDates[_selectedUnit]!.map((int time) {
                            return Center(
                              child: Text("$time"),
                            );
                          }).toList()),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                          itemExtent: 50.0,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedUnit = _unitList[index];
                              _calculateNotifyDate();
                            });
                          },
                          children: notifyDates.keys.map((String unit) {
                            return Center(
                              child: Text(unit),
                            );
                          }).toList()),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "Notify on: ${f.format(notificationDate)}",
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    backgroundColor: MaterialStateProperty.all(Colors.purple)),
                icon: const Icon(
                  Icons.check_circle, color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
