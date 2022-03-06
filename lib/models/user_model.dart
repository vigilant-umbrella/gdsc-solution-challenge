/// Sample User
/// {
///    "userId": "u1",
///    "userName": "John Doe",
///    "interests": ["Waste Managament", "Beach", "Goa"],
///    "image": "https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
/// }

class User {
  late String userId;
  late String userName;
  late int points;
  late List<String> interests;
  late String image;

  User({
    required this.userId,
    required this.userName,
    required this.points,
    required this.interests,
    required this.image,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    points = json['points'];
    interests = json['interests'].cast<String>();
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['points'] = points;
    data['interests'] = interests;
    data['image'] = image;

    return data;
  }
}
