import 'package:event_counter/models/event.dart';
import 'package:flutter/material.dart';

class Events with ChangeNotifier {
  List<Event> _events = [
    Event(
        id: 1,
        name: 'Birthday',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        deadline: new DateTime(2022, 5, 20, 12, 20)),
    Event(id: 2, name: 'Anniversary', deadline: new DateTime(2022, 5, 12)),
    Event(id: 3, name: 'Wedding', deadline: new DateTime(2023, 1, 12)),
  ];

  List<Event> get events {
    return [..._events];
  }

  updateEventDateline(DateTime newDateTime, int eventId) {
    final event = _events.firstWhere((event) => event.id == eventId);
    event.deadline = newDateTime;
    // notifyListeners();
  }

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }

  void deleteEvent(Event event) {
    _events.remove(event);
    notifyListeners();
  }

  void updateEvent(Event newInformation) {
    Event oldInformation = getEventById(newInformation.id);

    // oldInformation = newInformation;
    // if (newInformation.name != null) {
    //   oldInformation.name = newInformation.name;
    // }
    // if (newInformation.description != null) {
    //   oldInformation.description = newInformation.description;
    // }
    // if (newInformation.deadline != null) {
    //   oldInformation.deadline = newInformation.deadline;
    // }

    int index = _events.indexOf(oldInformation);
    _events[index] = newInformation;

    notifyListeners();
  }

  void updateEvents(List<Event> events) {
    _events = events;
    notifyListeners();
  }

  Event getEventById(int id) {
    return _events.firstWhere((event) => event.id == id);
  }
}
