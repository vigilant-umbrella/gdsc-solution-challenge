import 'package:gdsc_solution_challenge/models/event_model.dart';

/// Sample User
/// {
///    "userId": "u1",
///    "userName": "John Doe",
///    "interests": ["Waste Managament", "Beach", "Goa"],
///    "image": "https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
///    "events_attended": 5
/// }

class User {
  late String userId;
  late String userName;
  late int points;
  late List<String> interests;
  late String image;
  late int eventsAttended;
  late List<Map> badges;
  late List<Event> upcomingEvents;

  User({
    required this.userId,
    required this.userName,
    required this.points,
    required this.interests,
    required this.image,
    required this.eventsAttended,
    required this.badges,
    required this.upcomingEvents,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    points = json['points'];
    interests = json['interests'].cast<String>();
    image = json['image'];
    eventsAttended = json['eventsAttended'];
    badges = json['badges'].cast<Map>();
    upcomingEvents = (json['upcomingEvents'] as List)
        .map((event) => Event.fromJson(event))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['points'] = points;
    data['interests'] = interests;
    data['image'] = image;
    data['eventsAttended'] = eventsAttended;
    data['badges'] = badges;
    data['upcomingEvents'] =
        upcomingEvents.map((event) => event.toJson()).toList();

    return data;
  }
}
