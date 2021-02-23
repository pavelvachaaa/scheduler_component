import 'package:flutter/material.dart';
import 'package:scheduler_app/vertical_timeline/Event.dart';

class VerticalTimeline extends StatelessWidget {
  final List<VerticalEvent> events;
  VerticalTimeline({this.events});

  Widget _buildDividers() {
    const List list = [
      "00:00",
      "01:00",
      "02:00",
      "03:00",
      "04:00",
      "05:00",
      "06:00",
      "07:00",
      "08:00",
      "09:00",
      "10:00",
      "11:00",
      "12:00",
      "13:00",
      "14:00",
      "15:00",
      "16:00",
      "17:00",
      "18:00",
      "19:00",
      "20:00",
      "21:00",
      "22:00",
      "23:00",
      "24:00"
    ];
    return Column(children: list.map((time) => divider(time)).toList());
  }

  Widget divider(time) {
    return SizedBox(
        width: 200,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Divider(
              height: 1,
            ),
            Text(
              time,
              style: const TextStyle(fontSize: 10.0),
            ),
          ],
        ));
  }

  Widget _buildTimeLine() {
    return SizedBox(
      width: 200,
      height: 1500,
      child: Stack(children: this.events.toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_buildDividers(), _buildTimeLine()],
    );
  }
}
