class ReviewFeedbackModel {
  String? reviFeedID;
  // String hosterId;
  String userID;
  String date;
  String message;
  ReviewFeedbackModel(
      {required this.date,
      // required this.hosterId,
      this.reviFeedID,
      required this.message,
      required this.userID});
  Map<String, dynamic> toJson(id) => {
        "userID": userID,
        // "hosterId":hosterId,
        "reviFeedID": id,

        "date": date,
        "message": message,
      };
  factory ReviewFeedbackModel.fromJson(Map<String, dynamic> json) =>
      ReviewFeedbackModel(
        // hosterId:json["hosterId"],
          date: json["date"],
          reviFeedID: json["reviFeedID"],
          message: json["message"],
          userID: json["userID"]);
}
