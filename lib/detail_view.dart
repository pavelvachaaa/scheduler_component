import 'package:flutter/material.dart';
import 'package:scheduler_app/horizontal_timeline/Event.dart';
import 'package:scheduler_app/vertical_timeline/Event.dart';
import 'package:scheduler_app/vertical_timeline/Timeline.dart';

class DetailView extends StatelessWidget {
  final Event event;
  DetailView(this.event);
  @override
  Widget build(BuildContext context) {
    var timeDilation = 5.0; // 1.0 means normal animation speed.
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(
                      Icons.clear_outlined,
                      color: textTheme.caption.color,
                      size: 26,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        color: textTheme.caption.color,
                        size: 26,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.more_vert,
                        color: textTheme.caption.color,
                        size: 26,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: event.tag,
                    child: Container(
                      padding: const EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                          color: event.color,
                          borderRadius: BorderRadius.circular(4)),
                      width: 18,
                      height: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Denní směna",
                        style: textTheme.headline5,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Text("Dnes"),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Icon(Icons.circle, size: 5),
                          ),
                          Text("17:30 - 19:30"),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              /// Vlastnosti eventu
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Icon(
                      Icons.notifications_none,
                      color: textTheme.caption.color,
                      size: 26,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "30 minut předem",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(
                      Icons.short_text,
                      color: textTheme.caption.color,
                      size: 26,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Toto je velice smysluplný popisek eventu, který dává smysl",
                            style: TextStyle(fontSize: 16)),
                      ),
                    )
                  ]),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Časová osa",
                    style: textTheme.headline6,
                  ),
                  Text("Pro pátek 23. 02. 2021", style: textTheme.caption)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              VerticalTimeline(
                events: [
                  VerticalEvent(
                    background: Colors.purple,
                    textColor: Colors.white,
                    startHour: 0,
                    startMinute: 0,
                    endHour: 4,
                    endMinute: 0,
                    label: "Noční směna 00:00 - 04:00",
                    type: "N",
                  ),
                  VerticalEvent(
                    background: Colors.yellow,
                    textColor: Colors.black,
                    startHour: 7,
                    startMinute: 30,
                    endHour: 16,
                    endMinute: 0,
                    label: "Denní směna 7:30 - 16:00",
                    type: "N",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
