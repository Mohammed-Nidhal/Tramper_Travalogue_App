class AddPopularPlace {
  String ?popId;
  String placeName;
  String image;

  AddPopularPlace(
      {required this.image, required this.placeName,  this.popId});
  Map<String, dynamic> toJson(id) =>
      {"popId": id, "placeName": placeName, "image": image};

  factory AddPopularPlace.fromjson(Map<String, dynamic> json) {
    return AddPopularPlace(
        image: json["image"],
        placeName: json["placeName"],
        popId: json["popId"]);
  }
}
