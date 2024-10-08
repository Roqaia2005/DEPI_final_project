import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';

class EventDetailsScreen extends StatefulWidget {
  EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  double timerSize = 35;
  FontWeight timerWeight = FontWeight.w900;
  Color timerColor = Colors.purple;

  final dateTimeNow = DateTime.now();

  Color c = Colors.purple;

  List<String> notifications = [
    "Before 1 week",
    "Before 1 month",
    "Before 2 week"
  ];

  bool wantNotify = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countown Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
          //title and date
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Basmola's Birthday",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("June 5 2025 - 04:00 PM",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                              fontSize: 15)),
                      const Icon(Icons.edit_rounded,
                          size: 20, color: Colors.purple),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 5),

          //countdown
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(20)),
              child: RawSlideCountdown(
                  streamDuration: StreamDuration(
                    config: StreamDurationConfig(
                      countDownConfig: CountDownConfig(
                          duration: Duration(
                              days: 28 - dateTimeNow.day,
                              hours: 2,
                              minutes: 30)),
                    ),
                  ),
                  builder: (context, duration, countUp) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //day
                        _buildTimer(
                            first: RawDigitItem(
                              duration: duration,
                              timeUnit: TimeUnit.days,
                              digitType: DigitType.first,
                              countUp: countUp,
                              style: TextStyle(
                                  fontSize: timerSize,
                                  fontWeight: timerWeight,
                                  color: timerColor),
                            ),
                            second: RawDigitItem(
                              duration: duration,
                              timeUnit: TimeUnit.days,
                              digitType: DigitType.second,
                              countUp: countUp,
                              style: TextStyle(
                                  fontSize: timerSize,
                                  fontWeight: timerWeight,
                                  color: timerColor),
                            ),
                            title: 'Days'),

                        //hours
                        _buildTimer(
                            first: RawDigitItem(
                              duration: duration,
                              timeUnit: TimeUnit.hours,
                              digitType: DigitType.first,
                              countUp: countUp,
                              style: TextStyle(
                                  fontSize: timerSize,
                                  fontWeight: timerWeight,
                                  color: timerColor),
                            ),
                            second: RawDigitItem(
                              duration: duration,
                              timeUnit: TimeUnit.hours,
                              digitType: DigitType.second,
                              countUp: countUp,
                              style: TextStyle(
                                  fontSize: timerSize,
                                  fontWeight: timerWeight,
                                  color: timerColor),
                            ),
                            title: 'Hours'),

                        //min
                        _buildTimer(
                            first: RawDigitItem(
                              duration: duration,
                              timeUnit: TimeUnit.minutes,
                              digitType: DigitType.first,
                              countUp: countUp,
                              style: TextStyle(
                                  fontSize: timerSize,
                                  fontWeight: timerWeight,
                                  color: timerColor),
                            ),
                            second: RawDigitItem(
                              duration: duration,
                              timeUnit: TimeUnit.minutes,
                              digitType: DigitType.second,
                              countUp: countUp,
                              style: TextStyle(
                                  fontSize: timerSize,
                                  fontWeight: timerWeight,
                                  color: timerColor),
                            ),
                            title: 'Minutes'),

                        //seconds
                        _buildTimer(
                            first: RawDigitItem(
                              duration: duration,
                              timeUnit: TimeUnit.seconds,
                              digitType: DigitType.first,
                              countUp: countUp,
                              style: TextStyle(
                                  fontSize: timerSize,
                                  fontWeight: timerWeight,
                                  color: timerColor),
                            ),
                            second: RawDigitItem(
                              duration: duration,
                              timeUnit: TimeUnit.seconds,
                              digitType: DigitType.second,
                              countUp: countUp,
                              style: TextStyle(
                                  fontSize: timerSize,
                                  fontWeight: timerWeight,
                                  color: timerColor),
                            ),
                            title: 'Seconds'),
                      ],
                    );
                  }),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    color: Colors.red,
                    width: 500,
                    height: 200,
                    child: Text("kmooiweoined"),
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
                              MaterialStateProperty.resolveWith<Icon?>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return const Icon(Icons.notifications_active);
                            }
                            return null;
                          }))
                    ],
                  ),
                ),

                //notifyList
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return _buildNotification(notifications[index]);
                      }),
                ),

                //add Notification Button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
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
          )
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
        const SizedBox(height: 8),
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
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
    ),
  );
}
