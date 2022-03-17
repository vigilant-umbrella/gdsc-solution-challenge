class Location {
  late double lat;
  late double lng;
  String? address;

  Location({
    required this.lat,
    required this.lng,
    this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "address": address,
      };
}
