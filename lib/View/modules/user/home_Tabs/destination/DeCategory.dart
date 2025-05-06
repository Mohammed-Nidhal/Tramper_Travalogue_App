// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:google_fonts/google_fonts.dart';

// class DeCategory extends StatefulWidget {
//   DeCategory(
//       {super.key,
//       required this.image,
//       required this.name,
//       required this.place,
//       required this.about,
//       required this.star});
//   var image, name, place, about, star;

//   @override
//   State<DeCategory> createState() => _DeCategoryState();
// }

// class _DeCategoryState extends State<DeCategory> {
//   @override
//   Widget build(BuildContext context) {
//     print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 fit: BoxFit.fill, image: AssetImage(widget.image))),
//         child: Padding(
//           padding: EdgeInsets.only(
//             top: MediaQuery.of(context).size.height / 1.6,
//             left: MediaQuery.of(context).size.height / 40,
//             right: MediaQuery.of(context).size.height / 40,
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width / 2,
//                       child: Text(
//                         widget.name,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: GoogleFonts.poppins(
//                             fontSize: MediaQuery.of(context).size.height / 30,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.place_outlined,
//                           size: MediaQuery.of(context).size.height / 80,
//                           color: Colors.white,
//                         ),
//                         Text(
//                           widget.place,
//                           style: GoogleFonts.urbanist(
//                               fontSize: MediaQuery.of(context).size.height / 80,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   widget.about,
//                   style: GoogleFonts.urbanist(
//                       fontSize: MediaQuery.of(context).size.height / 40,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w400),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height / 20,
//                   ),
//                   child: RatingBar.builder(
//                       itemSize: MediaQuery.of(context).size.height / 40,
//                       initialRating: widget.star.toDouble(),
//                       allowHalfRating: true,
//                       // glowColor: Colors.yellowAccent,
//                       itemBuilder: (context, _) {
//                         return Icon(
//                           Icons.star,
//                           color: Colors.yellowAccent,
//                         );
//                       },
//                       onRatingUpdate: (newRating) {
//                         widget.star = newRating.toDouble();
//                       }),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
