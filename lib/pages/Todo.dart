import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Customs/BottomNavBar.dart';
import '../Customs/MyAppBar.dart';


class NotesViewBody extends StatefulWidget {
  const NotesViewBody({super.key});

  @override
  _NotesViewBodyState createState() => _NotesViewBodyState();
}

class _NotesViewBodyState extends State<NotesViewBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> activeNotes = [
    {
      'title': 'Meeting Notes',
      'subtitle': 'Discuss project timeline',
      'time': DateTime.now(),
      'completed': false,
    },
    {
      'title': 'Grocery List',
      'subtitle': 'Milk, Bread, Eggs',
      'time': DateTime.now(),
      'completed': false,
    },
  ];

  List<Map<String, dynamic>> historyNotes = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _deleteNoteAt(int index) {
    setState(() {
      // Mark the note as completed and add it to history before removing it
      activeNotes[index]['completed'] = true;
      activeNotes[index]['subtitle'] += "   Not yet"; // Keep this as is
      historyNotes.add(activeNotes[index]);
      activeNotes.removeAt(index);
    });

    // Optionally, show a SnackBar or Toast to inform the user of the successful deletion
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note deleted successfully.')),
    );
  }

  ///with cofimation
// void _deleteNoteAt(int index) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text('Confirm Deletion'),
//         content: const Text('Are you sure you want to delete this note?'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 activeNotes[index]['completed'] = true;
//                 activeNotes[index]['subtitle'] += "   Not yet"; // Keep this as is
//                 historyNotes.add(activeNotes[index]);
//                 activeNotes.removeAt(index);
//               });
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: const Text('Delete'),
//           ),
//         ],
//       );
//     },
//   );
// }

  void _createNote() {
    if (_titleController.text.isNotEmpty &&
        _subtitleController.text.isNotEmpty &&
        selectedDateTime != null) {
      setState(() {
        activeNotes.add({
          'title': _titleController.text,
          'subtitle': _subtitleController.text,
          'time': selectedDateTime!,
          'completed': false,
        });
        _titleController.clear();
        _subtitleController.clear();
        selectedDateTime = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  Future<void> _pickDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark(),
            child: child!,
          );
        },
      );

      if (time != null) {
        setState(() {
          selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _editNoteAt(int index) {
    _titleController.text = activeNotes[index]['title'];
    _subtitleController.text = activeNotes[index]['subtitle'];
    selectedDateTime = activeNotes[index]['time'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C1C),
          title: const Text('Edit Note', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                cursorColor: Colors.blue,
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              TextField(
                cursorColor: Colors.blue,
                controller: _subtitleController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Subtitle',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  selectedDateTime != null
                      ? DateFormat('yyyy-MM-dd – HH:mm')
                      .format(selectedDateTime!)
                      : 'Select Date & Time',
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.white),
                  onPressed: _pickDateTime,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:
              const Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  activeNotes[index] = {
                    'title': _titleController.text,
                    'subtitle': _subtitleController.text,
                    'time': selectedDateTime ?? activeNotes[index]['time'],
                    'completed': activeNotes[index]['completed'],
                  };
                  _titleController.clear();
                  _subtitleController.clear();
                  selectedDateTime = null;
                });
                Navigator.pop(context);
              },
              child: const Text('Update', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  void _toggleCompletion(int index) {
    setState(() {
      if (!activeNotes[index]['completed']) {
        activeNotes[index]['subtitle'] += "   Done"; // Keep this as is

        historyNotes.add(activeNotes[index]);
        activeNotes.removeAt(index);
      } else {
        // When marked as completed, the subtitle remains unchanged
        activeNotes[index]['subtitle'] += "   Done"; // Keep this as is

        historyNotes.add(activeNotes[index]);
        activeNotes.removeAt(index);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(' Move to history')),
    );
  }

  void _restoreNoteAt(int index) {
    setState(() {
      // Create a copy of the note to modify it before adding to activeNotes
      var noteToRestore = historyNotes[index];

      // Remove "Not yet" and "Done" from the subtitle if they exist
      noteToRestore['subtitle'] = noteToRestore['subtitle']
          .replaceAll("Not yet", "")
          .replaceAll("Done", "")
          .trim();

      // Add the modified note back to activeNotes
      activeNotes.add(noteToRestore);

      // Remove the note from historyNotes
      historyNotes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color.fromARGB(255, 70, 69, 69),
      appBar: getAppBar(title: "Your Events", tabBar: TabBar(
      controller: _tabController,
      tabs: const [
        Tab(text: "Active Tasks"),
        Tab(text: "History"),
      ],
    ), context: context,),

    //bottomNavigationBar:BottomNavBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active Tasks Tab
          ListView.builder(
            itemCount: activeNotes.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(activeNotes[index]['title']),
                onDismissed: (direction) {
                  _deleteNoteAt(index);
                },
                child: GestureDetector(
                  onDoubleTap: () => _editNoteAt(index),
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 123, 176, 180),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Color.fromARGB(255, 123, 176, 180)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius:
                          25, // Reduced radius from 50 to 25 for a smaller avatar
                          backgroundColor: Color.fromARGB(255, 123, 147, 180),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('HH:mm')
                                    .format(activeNotes[index]['time']),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10, // Reduced font size for time
                                ),
                              ),
                              Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(activeNotes[index]['time']),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 8, // Reduced font size for date
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Text(
                          activeNotes[index]['title'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          activeNotes[index]['subtitle'],
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.check,
                            color: Color.fromARGB(255, 249, 250, 249),
                          ),
                          onPressed: () => _toggleCompletion(index),
                        ),
                      )),
                ),
              );
            },
          ),

          // History Tab
          ListView.builder(
            itemCount: historyNotes.length,
            itemBuilder: (context, index) {
              return Container(
                  margin:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 180, 180, 180),
                    borderRadius: BorderRadius.circular(8),
                    border:
                    Border.all(color: Color.fromARGB(255, 180, 180, 180)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: // Inside the active notes ListView.builder
                  ListTile(
                    leading: CircleAvatar(
                      radius:
                      25, // Reduced radius for a smaller avatar (from 30 to 25)
                      backgroundColor: Color.fromARGB(255, 123, 147, 180),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('HH:mm')
                                .format(historyNotes[index]['time']),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10, // Reduced font size for time
                            ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd')
                                .format(historyNotes[index]['time']),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 8, // Reduced font size for date
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      historyNotes[index]['title'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.white70),
                        children: [
                          TextSpan(
                            text: historyNotes[index]['subtitle']
                                .split(RegExp(r"   (Not yet|Done)"))[0],
                          ),
                          if (historyNotes[index]['subtitle']
                              .contains("Not yet"))
                            TextSpan(
                              text: "   Not yet",
                              style: const TextStyle(
                                  color: Colors.red), // Color for "Not yet"
                            )
                          else if (historyNotes[index]['subtitle']
                              .contains("Done"))
                            TextSpan(
                              text: "   Done",
                              style: const TextStyle(
                                  color: Color.fromARGB(
                                      255, 2, 248, 10)), // Color for "Done"
                            ),
                        ],
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.restore,
                        color: Color.fromARGB(255, 249, 250, 249),
                      ),
                      onPressed: () => _restoreNoteAt(index),
                    ),
                  ));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: const Color(0xFF1C1C1C),
                title: const Text('Create Note',
                    style: TextStyle(color: Colors.white)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      cursorColor: Colors.blue,
                      controller: _titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    TextField(
                      cursorColor: Colors.blue,
                      controller: _subtitleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Subtitle',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        selectedDateTime != null
                            ? DateFormat('yyyy-MM-dd – HH:mm')
                            .format(selectedDateTime!)
                            : 'Select Date & Time',
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.calendar_today,
                            color: Colors.white),
                        onPressed: _pickDateTime,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () {
                      _createNote();
                      Navigator.pop(context);
                    },
                    child: const Text('Create',
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}