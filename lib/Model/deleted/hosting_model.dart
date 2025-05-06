// class HostingModel {
//   String hostingID;
//   String userID;
//   String hostingDetails;
//   String location;
//   HostingModel(
//       {required this.hostingDetails,
//       required this.hostingID,
//       required this.location,
//       required this.userID});
//   Map<String, dynamic> toJson(id) => {
//         "userID": userID,
//         "hostingID": hostingID,
//         "hostingDetails": hostingDetails,
//         "location": location,
//       };
//   factory HostingModel.fromJson(Map<String, dynamic> json) => HostingModel(
//       hostingDetails: json["hostingDetails"],
//       hostingID: json["hostingID"],
//       location: json["location"],
//       userID: json["userID"]);
// }
