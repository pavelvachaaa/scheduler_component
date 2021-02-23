import 'package:flutter/material.dart';

class VerticalEvent extends StatelessWidget {
  final double startHour;
  final double endHour;
  final double startMinute;
  final double endMinute;
  final String label;
  final String type;
  final Color background;
  final Color textColor;

  VerticalEvent(
      {this.startHour,
      this.endHour,
      this.startMinute,
      this.endMinute,
      this.label,
      this.type,
      this.textColor,
      this.background});

  /// start hours
  double _calculateTopMargin({scaleFactor = 1}) {
    return (60 * this.startHour + this.startMinute) *
        scaleFactor.toDouble().abs();
  }

  /// end hours
  double _calculateHeight({scaleFactor = 1}) {
    return ((this.endHour - this.startHour).abs() * 60 +
        (this.endMinute - this.startMinute));
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 30,
      top: _calculateTopMargin(),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(10)),
              color: this.background),
          width: 157,
          height: _calculateHeight(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(fontSize: 15, color: this.textColor),
            ),
          )),
    );
  }
}
