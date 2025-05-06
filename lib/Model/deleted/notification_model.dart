// class NotificationModel {
//   String notificationID;
//   String userID;
//   String date;
//   String message;
//   NotificationModel(
//       {required this.date,
//       required this.notificationID,
//       required this.message,
//       required this.userID});
//   Map<String, dynamic> toJson(id) => {
//         "userID": userID,
//         "notificationID": notificationID,
//         "date": date,
//         "message": message,
//       };
//   factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
//       date: json["date"],
//       notificationID: json["notificationID"],
//       message: json["message"],
//       userID: json["userID"]);
// }
