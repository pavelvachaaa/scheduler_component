import 'package:flutter/material.dart';
import 'dart:math';

import 'package:scheduler_app/detail_view.dart';

class Event extends StatelessWidget {
  final double left;
  final double right;
  final double top;
  final double height;
  final String tag;
  final Color color;

  Event({this.left, this.right, this.top, this.height, this.tag, this.color});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: this.left,
        right: this.right,
        top: this.top,
        child: Hero(
          tag: this.tag,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(Radius.circular(4)),
                  color: this.color),
              height: this.height ?? 60,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return DetailView(this);
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = Offset(0.0, 1.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Toto je velice zajímavý popisek",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              )),
        ));
  }

  widget({Container child}) {}
}
