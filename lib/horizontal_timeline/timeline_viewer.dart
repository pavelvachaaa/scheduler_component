import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scheduler_app/horizontal_timeline/Event.dart';

class TimelineViewer extends StatefulWidget {
  @override
  _TimelineViewerState createState() => _TimelineViewerState();
}

class _TimelineViewerState extends State<TimelineViewer> {
  /// Vertikální šířka mezi jednou hodinou
  double margin_size = 60;

  /// Posunutí oproti labelům
  double moved_from_left = 60;

  /// Jednotliv dny
  double horizontalMargin = 60;
  /** TOHLE BY PAK MĚLO DĚLAT  KOLIZE CHECKING
   * 
   * final startTime = DateTime(2018, 6, 23, 10, 30);
final endTime = DateTime(2018, 6, 23, 13, 00);

final currentTime = DateTime.now();
      
if(currentTime.isAfter(startTime) && currentTime.isBefore(endTime)) {
  // do something
}
   */
  List<Widget> createDividers(int numberOfDividers) {
    return List<Widget>.generate(numberOfDividers, (index) {
      if (index % 2 == 0) {
        return Container(
          color: Colors.grey[300],
          width: .5,
          margin: EdgeInsets.only(right: margin_size - .5),
        );
      } else {
        return Container(
          color: Colors.grey[400],
          width: .5,
          margin: EdgeInsets.only(right: margin_size - .5),
        );
      }
    }).toList();
  }

  List<Widget> createHorizontalDividers(int numberOfDividers) {
    return List<Widget>.generate(
        numberOfDividers,
        (index) => Container(
              color: Colors.grey[300],
              height: .5,
              margin: EdgeInsets.only(top: horizontalMargin),
            ));
  }

  /// Velikost buňěk

  /// start hours
  double _calculateLeftMargin(hour, minute, {scaleFactor = 1}) {
    print("$hour:$minute");
    return (((minute * (margin_size / 60) + (hour * margin_size)) *
                scaleFactor) +
            moved_from_left)
        .toDouble()
        .abs();
  }

  /// end hours atd.
  double _calculateRightMargin(hour, minute, {scaleFactor = 1}) {
    print("$hour:$minute");

    return (24 * margin_size -
            (((hour * margin_size) + minute * (margin_size / 60)) *
                scaleFactor))
        .toDouble()
        .abs();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey[400]))),
            child: Container(
              margin: EdgeInsets.only(left: moved_from_left),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: List.generate(
                    24,
                    (index) => Container(
                        width: margin_size,
                        child: Text(
                          "$index",
                          style: TextStyle(color: Colors.grey[300]),
                        ))),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 5,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: 1800,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(
                          24,
                          (index) => Container(
                              margin: EdgeInsets.only(left: 5),
                              height: horizontalMargin,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Pondělí",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    Text(
                                      "${++index}. 2.",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ))),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: moved_from_left),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: createDividers(24)),
                    ),
                    Container(
                        width: 1500,
                        child: Column(children: createHorizontalDividers(24))),
                    Event(
                      left: _calculateLeftMargin(2, 0),
                      right: _calculateRightMargin(3, 30),
                      top: 1,
                      height: 28,
                      tag: "event1",
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                    Event(
                      left: _calculateLeftMargin(2, 0),
                      right: _calculateRightMargin(3, 30),
                      top: 1,
                      tag: "event2",
                      height: 28,
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                    Event(
                      left: _calculateLeftMargin(2, 30),
                      right: _calculateRightMargin(4, 45),
                      top: (8.0 * horizontalMargin) +
                          1 +
                          .5 * 8.0, //.5*8,0 = jednotlivé linky mají šířku .5
                      tag: "event3",
                      height: 30,
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                    Event(
                      left: _calculateLeftMargin(5, 0),
                      right: _calculateRightMargin(8, 0),
                      top: 61,
                      tag: "event4",
                      height: 58,
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                    Event(
                      left: _calculateLeftMargin(2, 0),
                      right: _calculateRightMargin(8, 0),
                      top: 120,
                      tag: "event5",
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      height: 28,
                    ),
                    Event(
                      left: _calculateLeftMargin(0, 30),
                      right: _calculateRightMargin(3, 0),
                      top: 150,
                      tag: "event6",
                      height: 28,
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
