import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_solution_challenge/models/user_model.dart';
import 'package:gdsc_solution_challenge/utility/wait_timer.dart';

class Users with ChangeNotifier {
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
}
