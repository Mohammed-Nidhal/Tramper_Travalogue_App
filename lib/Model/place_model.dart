class PlaceModel {
  String? placeID;
  String category;
  String description;
  String image;
  double latitude;
  double longitude;
  String location;
  String isLiked;
  PlaceModel({
    this.placeID,
    required this.isLiked,
    required this.category,
    required this.description,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.location,
  });
  Map<String, dynamic> toJson(id) => {
        "placeID": id,
        "isLiked":isLiked,
        "category": category,
        "description": description,
        "image": image,
        "latitude": latitude,
        "longitude": longitude,
        "location": location,
      };
  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
      placeID: json["placeID"],
      isLiked:json["isLiked"],
      category: json["category"],
      description: json["description"],
      image: json["image"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      location: json["location"]);
}
