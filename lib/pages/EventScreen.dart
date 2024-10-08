import 'package:finalproject/Customs/BottomNavBar.dart';
import 'package:finalproject/Customs/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/EventProvider.dart';
import '../widgets/EventWidget.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen>
    with SingleTickerProviderStateMixin {
  Color bgc = Colors.white;
  Color c = Colors.purple;

  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "Your Events", tabBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: "Upcoming"),
          Tab(text: "History"),
        ],
      ), context: context,),
      //bottomNavigationBar: BottomNavBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Recent Events List
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<EventProvider>(
                builder: (context, eventProvider, child) {
                  if(eventProvider.events.isEmpty){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //lottie
                        Text("You Have No Events Yet", style: TextStyle(color: Colors.grey[500], fontSize: 20, fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Click Add", style: TextStyle(color: Colors.grey[500], fontSize: 20, fontWeight: FontWeight.bold)),
                            Icon(Icons.add, color: Colors.grey[500], size: 25,)
                          ],
                        )

                      ],
                    );
                  }
              return ListView.builder(
                itemCount: eventProvider.events.length,
                itemBuilder: (context, index) {
                  return EventWidget(event: eventProvider.events[index]);
                },
              );
            }),
          ),

          // History Events List
          Text("hello")
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ListView.builder(
          //     itemCount: historyEvents.length,
          //     itemBuilder: (context, index) {
          //       return EventWidget(event: historyEvents[index]);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}


