import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scheduler_app/horizontal_timeline/Event.dart';
import 'package:scheduler_app/horizontal_timeline/models/Event.dart';
import 'package:scheduler_app/horizontal_timeline/test_data.dart';

import 'Event.dart';

class TimelineViewer extends StatefulWidget {
  // Velikost jedné hodiny
  double hourSize = 60;

  /// Odsazení od levého sloupce
  double movedFromLeft = 60;

  /// Scale factor - při gestu zvětšení či zmenšení se mění
  double scaleFactor = 1;

  /// Barvičky gridu
  Color evenDividerColor = Colors.grey[300];
  Color dividerColor = Colors.grey[400];

  /// Data, co příjdou ze streamu, jedná se už o jednotlivé bloky
  List<EventData> eventData = [];

  TimelineViewer(
      {this.hourSize = 60,
      this.eventData,
      this.movedFromLeft,
      this.scaleFactor,
      this.dividerColor,
      this.evenDividerColor});
  @override
  _TimelineViewerState createState() => _TimelineViewerState();
}

class _TimelineViewerState extends State<TimelineViewer> {
  /// Jednotliv dny
  double horizontalMargin = 60;

  /* 
   * TOHLE BY PAK MĚLO DĚLAT  KOLIZE CHECKING
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
          margin: EdgeInsets.only(right: this.widget.hourSize - .5),
        );
      } else {
        return Container(
          color: Colors.grey[400],
          width: .5,
          margin: EdgeInsets.only(right: this.widget.hourSize - .5),
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
    print("$hour:$minute ${this.widget.hourSize} ${this.widget.movedFromLeft}");
    return (((minute * (this.widget.hourSize / 60) +
                    (hour * this.widget.hourSize)) *
                scaleFactor) +
            this.widget.movedFromLeft)
        .toDouble()
        .abs();
  }

  /// end hours atd.
  double _calculateRightMargin(hour, minute, {scaleFactor = 1}) {
    print("$hour:$minute");

    return (24 * this.widget.hourSize -
            (((hour * this.widget.hourSize) +
                    minute * (this.widget.hourSize / 60)) *
                scaleFactor))
        .toDouble()
        .abs();
  }

  /// Zařazení do správného řádku
  double _caculateTopMargin(rowNumber, {scaleFactor = 1}) {
    return (8.0 * horizontalMargin) + 1 + .5 * rowNumber * scaleFactor;
  }

  List<Event> events = [];
  @override
  void initState() {
    jsonData.forEach((json) {
      EventData event = EventData.fromMap(json);
      print(event.toString());
      return events.add(Event(
          tag: event.id,
          top: _caculateTopMargin(event.rowNumber),
          left: _calculateLeftMargin(event.start.hour, event.start.minute),
          color: Colors.red,
          right: _calculateRightMargin(event.end.hour, event.end.minute),
          eventData: event));
    });
    super.initState();
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
              margin: EdgeInsets.only(left: this.widget.movedFromLeft),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: List.generate(
                    24,
                    (index) => Container(
                        width: this.widget.hourSize,
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
                      margin: EdgeInsets.only(left: this.widget.movedFromLeft),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: createDividers(24)),
                    ),
                    Container(
                        width: 1500,
                        child: Column(children: createHorizontalDividers(24))),

                        Column(children: events,)

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
