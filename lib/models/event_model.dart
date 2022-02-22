import 'package:gdsc_solution_challenge/models/location_model.dart';

/// Sample Event
/// {
///    "event_title": "Waste Recycling",
///    "date": "3/3/2022",
///    "starts_at": "10:00",
///    "venue": "Colva Beach, Goa",
///    "type": "Cleanup Drive",
///    "tags": ["Waste Managament", "Beach", "Goa"],
///    "description": "The people of Goa would like to launch a clean-up drive of the trash that has accumulated in our lovely Colva Beach. Come help us in our efforts to keep Goa clean!",
///    "image": "https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
///    "organizerId": "o1",
///    "organizerName": "Sandy",
///    "eventId": "e1",
///    "location": {
///      "lat": 15.2993,
///      "lng": 74.124
///    }
/// }

class Event {
  late String eventId;
  late String eventTitle;
  late String date;
  late String startsAt;
  late String venue;
  late String type;
  late List<String> tags;
  late String description;
  late String image;
  late String organizerId;
  late String organizerName;
  late Location location;

  Event({
    required this.eventId,
    required this.eventTitle,
    required this.date,
    required this.startsAt,
    required this.venue,
    required this.type,
    required this.tags,
    required this.description,
    required this.image,
    required this.organizerId,
    required this.organizerName,
    required this.location,
  });

  Event.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventTitle = json['eventTitle'];
    date = json['date'];
    startsAt = json['startsAt'];
    venue = json['venue'];
    type = json['type'];
    tags = json['tags'].cast<String>();
    description = json['description'];
    image = json['image'];
    organizerId = json['organizerId'];
    organizerName = json['organizerName'];
    location = (json['location'] != null
        ? Location.fromJson(json['location'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventId'] = eventId;
    data['eventTitle'] = eventTitle;
    data['date'] = date;
    data['startsAt'] = startsAt;
    data['venue'] = venue;
    data['type'] = type;
    data['tags'] = tags;
    data['description'] = description;
    data['image'] = image;
    data['organizerId'] = organizerId;
    data['organizerName'] = organizerName;
    data['location'] = location.toJson();
    return data;
  }
}
