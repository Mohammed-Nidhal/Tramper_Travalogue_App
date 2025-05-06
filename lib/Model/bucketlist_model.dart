class BucketListModel {
  String? bucketListId;
  String placeID;

  String image;

  String location;
  BucketListModel({
    this.bucketListId,
    required this.placeID,
    required this.image,
    required this.location,
  });
  Map<String, dynamic> toJson(id) => {
        "bucketListId": id,
        "placeID": placeID,
        "image": image,
        "location": location,
      };
  factory BucketListModel.fromJson(Map<String, dynamic> json) =>
      BucketListModel(
          bucketListId: json["bucketListId"],
          placeID: json["placeID"],
          image: json["image"],
          location: json["location"]);
}
