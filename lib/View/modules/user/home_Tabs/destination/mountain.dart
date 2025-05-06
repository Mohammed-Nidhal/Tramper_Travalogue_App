// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:tramber/View/modules/user/home_Tabs/destination/DeCategory.dart';
// import 'package:tramber/View/modules/user/TramModel.dart';

// class Mountains extends StatelessWidget {
//   const Mountains({super.key});

//   @override
//   Widget build(BuildContext context) {
//     print("////////////////////////////////////////////////////");
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 alignment: Alignment.center,
//                 height: MediaQuery.of(context).size.height / 3.3,
//                 decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.1),
//                     image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: AssetImage("asset/mainHill.jpg"))),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 1.0),
//                   child: Container(
//                     decoration: BoxDecoration(),
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 50),
//                       child: Text(
//                         "MOUNTAINS",
//                         style: GoogleFonts.abrilFatface(
//                             fontSize: 32,
//                             fontWeight: FontWeight.w400,
//                             color: HexColor("#68BBE3")),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 5),
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height / 1.45,
//                   child: ListView.builder(
//                       itemCount: mountains.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(
//                               top: 30, left: 40, right: 40, bottom: 20),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => DeCategory(
//                                             image: mountains[index]['image'],
//                                             name: mountains[index]['name'],
//                                             place: mountains[index]['place'],
//                                             about: mountains[index]['about'],
//                                             star: mountains[index]['star'],
//                                           )));
//                             },
//                             child: Container(
//                               alignment: Alignment.bottomLeft,
//                               height: MediaQuery.of(context).size.height / 4.6,
//                               width: MediaQuery.of(context).size.width,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12),
//                                   image: DecorationImage(
//                                       fit: BoxFit.fill,
//                                       image: AssetImage(
//                                           mountains[index]['image']))),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       mountains[index]['name'],
//                                       style: GoogleFonts.poppins(
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                     Row(
//                                       children: [
//                                      const   Icon(
//                                           Icons.place_outlined,
//                                           size: 10,
//                                           color: Colors.white,
//                                         ),
//                                         Text(
//                                           mountains[index]['place'],
//                                           style: GoogleFonts.urbanist(
//                                               color: Colors.white,
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.w400),
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
