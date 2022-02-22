import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_solution_challenge/models/event_model.dart';

class Events with ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events {
    return [..._events];
  }

  Future<void> fetchAndSetEvents() async {
    List<Event> events = [];
    final String jsonString =
        await rootBundle.loadString('assets/mocks/events.json');
    final jsonResponse = json.decode(jsonString);
    for (var event in jsonResponse) {
      events.add(Event.fromJson(event));
    }
    _events = events;
    notifyListeners();

    return;
  }
}
