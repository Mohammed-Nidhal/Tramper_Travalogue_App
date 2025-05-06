class RestaurentModel {
  String? restID;
  String category;
  String description;
  String image;
  String restaurentName;
  // int latitude;
  // String longitude;
  String location;
  RestaurentModel({
    this.restID,
    required this.restaurentName,
    required this.category,
    required this.description,
    required this.image,
    // required this.latitude,
    // required this.longitude,
    required this.location,
  });
  Map<String, dynamic> toJson(id) => {
        "restID": id,
        "restaurentName": restaurentName,
        "category": category,
        "description": description,
        "image": image,
        // "latitude": latitude,
        // "longitude": longitude,
        "location": location,
      };
  factory RestaurentModel.fromJson(Map<String, dynamic> json) =>
      RestaurentModel(
          restaurentName: json["restaurentName"],
          restID: json["restID"],
          category: json["category"],
          description: json["description"],
          image: json["image"],
          // latitude: json["latitude"],
          // longitude: json["longitude"],
          location: json["location"]);
}
