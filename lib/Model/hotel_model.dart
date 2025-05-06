class HotelModel {
  String? hotelID;
  String category;
  String description;
  String image;
  String hotelName;
  List previewimage;
  // int latitude;
  // String longitude;
  String location;
  String price;
  HotelModel(
      {this.hotelID,
      required this.previewimage,
      required this.category,
      required this.description,
      required this.image,
      required this.hotelName,
      // required this.latitude,
      // required this.longitude,
      required this.location,
      required this.price});
  Map<String, dynamic> toJson(id) => {
        "hotelID": id,
        "previewimage": previewimage.map((e) => e),
        "hotelName": hotelName,
        "category": category,
        "description": description,
        "image": image,
        // "latitude": latitude,
        // "longitude": longitude,
        "location": location,
        "price": price,
      };
  factory HotelModel.fromJson(Map<String, dynamic> json) {
    final list = json["previewimage"] as List;

    return HotelModel(
        hotelID: json["hotelID"],
        previewimage: list,
        hotelName: json["hotelName"],
        category: json["category"],
        description: json["description"],
        image: json["image"],
        // latitude: json["latitude"],
        // longitude: json["longitude"],
        location: json["location"],
        price: json["price"]);
  }
}
