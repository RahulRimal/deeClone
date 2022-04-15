import 'dart:async';

import 'package:event_counter/helpers/date_time_helper.dart';
import 'package:event_counter/models/event.dart';
import 'package:event_counter/providers/events.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);
  static const String routeName = '/event-screen';

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // DateTime _eventTimer = DateTime.now();
  late DateTime _eventTimer;

  bool _first = true;

  void _decreaseTimer() {
    setState(() {
      _eventTimer = DateTimeHelper.decreaseTime(_eventTimer);
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventToShow = ModalRoute.of(context)!.settings.arguments as Event;

    if (_first) {
      _eventTimer = eventToShow.deadline ?? DateTime.now();
      _first = false;
      Provider.of<Events>(context, listen: false)
          .updateEventDateline(_eventTimer, eventToShow.id);
      Timer.periodic(Duration(seconds: 1), (Timer timer) => _decreaseTimer());
    }

    print(eventToShow.deadline);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          // child: Text('Birthday'),
          child: Text(eventToShow.name as String),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Center(
          //   child: Hero(
          //     tag: 'eventName',
          //     child: Text('Event'),
          //   ),
          // ),

          Center(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
              child: Text(
                eventToShow.description != null
                    ? eventToShow.description as String
                    : 'No description available',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),

          Text(
            DateTimeHelper.getDate(eventToShow.deadline as DateTime),
            style: TextStyle(
              fontSize: 40.0,
            ),
          ),
          Text(
            DateTimeHelper.getRemainingTime(
              eventToShow.deadline as DateTime,
            ),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: 75.0,
          ),
          Text(
            // DateTimeHelper.getTimeCounter(eventToShow.deadline as DateTime),
            DateTimeHelper.getTimeCounter(_eventTimer),
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
