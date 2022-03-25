import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_solution_challenge/models/event_model.dart';
import 'package:gdsc_solution_challenge/utility/wait_timer.dart';

class Events with ChangeNotifier {
  List<Event> _events = [];
  List<Event> _favoriteEvents = [];

  List<Event> get events {
    return [..._events];
  }

  List<Event> get favoriteEvents {
    return [..._favoriteEvents];
  }

  Future<void> fetchAndSetEvents() async {
    List<Event> events = [];

    // remove this later
    await wait(1);

    final String jsonString =
        await rootBundle.loadString('assets/mocks/events.json');
    final jsonResponse = json.decode(jsonString);
    for (var event in jsonResponse) {
      events.add(Event.fromJson(event));
    }

    // remove shuffle later
    events.shuffle();

    _events = events;
    notifyListeners();

    return;
  }

  Future<void> fetchAndSetFavoriteEvents() async {
    List<Event> events = [];

    // remove this later
    await wait(1);

    final String jsonString =
        await rootBundle.loadString('assets/mocks/events.json');
    final jsonResponse = json.decode(jsonString);
    for (var event in jsonResponse) {
      events.add(Event.fromJson(event));
    }

    // remove shuffle later
    events.shuffle();

    _favoriteEvents = events;
    notifyListeners();

    return;
  }

  Future<void> fetchAndSetAllEvents() async {
    await fetchAndSetEvents();
    await fetchAndSetFavoriteEvents();
    notifyListeners();

    return;
  }

  Future<Event> getEventById(String id) async {
    await wait(1);
    final event = _events.firstWhere((event) => event.eventId == id);
    return event;
  }
}
