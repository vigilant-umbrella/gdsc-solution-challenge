import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_solution_challenge/models/event_model.dart';
import 'package:gdsc_solution_challenge/models/user_model.dart';
import 'package:gdsc_solution_challenge/utility/wait_timer.dart';
import 'package:intl/intl.dart';

class UserProvider with ChangeNotifier {
  late User _user;

  User get user {
    return _user;
  }

  Future<void> fetchAndSetUser() async {
    User user;

    // remove this later
    await wait(1);

    final String jsonString =
        await rootBundle.loadString('assets/mocks/user.json');
    final jsonResponse = json.decode(jsonString);
    user = User.fromJson(jsonResponse);

    _user = user;
    notifyListeners();

    return;
  }

  List<Event> get getEventsAttending {
    final List<Event> event = _user.upcomingEvents
        .where((event) => event.organizerId != _user.userId)
        .toList();

    event.sort((a, b) => DateFormat('dd/MM/yyyy')
            .parse(a.date)
            .isBefore(DateFormat('dd/MM/yyyy').parse(b.date))
        ? 1
        : -1);

    return event;
  }

  List<Event> get getEventsOrganising {
    final List<Event> event = _user.upcomingEvents
        .where((event) => event.organizerId == _user.userId)
        .toList();

    event.sort((a, b) => DateFormat('dd/MM/yyyy')
            .parse(a.date)
            .isBefore(DateFormat('dd/MM/yyyy').parse(b.date))
        ? 1
        : -1);

    return event;
  }
}
