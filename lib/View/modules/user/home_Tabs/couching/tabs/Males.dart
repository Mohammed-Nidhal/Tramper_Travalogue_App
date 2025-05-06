import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/user/hosting/HosterProfile.dart';
import 'package:tramber/ViewModel/firestore.dart';
import 'package:tramber/utils/image.dart';

class Males extends StatefulWidget {
  const Males({super.key});

  @override
  State<Males> createState() => _MalesState();
}

class _MalesState extends State<Males> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Firestore>(builder: (context, storepro, child) {
      return FutureBuilder(
          future: storepro.fetchMaleHosters(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return storepro.hostMaleList.isEmpty
                ? Center(
                    child: Text("No male hosters"),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.9, crossAxisCount: 2),
                    itemCount: storepro.hostMaleList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HosterProfile(
                                        hosterId:
                                            storepro.hostMaleList[index].userID,
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          // height: MediaQuery.of(context).size.height / 3,
                          // width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            // child: Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Container(
                            //           height: MediaQuery.of(context).size.height / 17,
                            //           width: MediaQuery.of(context).size.width / 8,
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(100),
                            //             image: DecorationImage(
                            //                 image: AssetImage("asset/img_8.png"),
                            //                 fit: BoxFit.fill),
                            //           ),
                            //         ),
                            //         Padding(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: Column(
                            //             children: [
                            //               Text(
                            //                 storepro.maleList[index].username,
                            //                 style: GoogleFonts.niramit(fontSize: 17),
                            //               ),
                            //               Row(
                            //                 children: [
                            //                   Icon(LineIcons.phone),
                            //                   Padding(
                            //                     padding: const EdgeInsets.only(
                            //                         left: 5, right: 5),
                            //                     child: Icon(LineIcons.alternateComment),
                            //                   ),
                            //                   Icon(Icons.mail_outline_outlined),
                            //                 ],
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(top: 5),
                            //       child: Text(
                            //         "Female",
                            //         style: GoogleFonts.roboto(fontSize: 12),
                            //       ),
                            //     ),
                            //     Text(
                            //       "Hosting spinster",
                            //       style: GoogleFonts.roboto(fontSize: 12),
                            //     ),
                            //     Text(
                            //       "Place: Jaipur",
                            //       style: GoogleFonts.roboto(fontSize: 12),
                            //     ),
                            //     Text(
                            //       """My name is Anupriya, and I am pleased to have the opportunity to host.""",
                            //       style: GoogleFonts.roboto(fontSize: 11),
                            //     ),
                            //   ],
                            // ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              17,
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: DecorationImage(
                                            image: storepro.hostMaleList[index]
                                                        .profileimage ==
                                                    ""
                                                ? imageNotFound
                                                : NetworkImage(storepro
                                                    .hostMaleList[index]
                                                    .profileimage),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .26,
                                            child: Text(
                                              storepro
                                                  .hostMaleList[index].username,
                                              style: GoogleFonts.niramit(
                                                  fontSize: 17),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          const Row(
                                            children: [
                                              Icon(LineIcons.phone),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Icon(
                                                    LineIcons.alternateComment),
                                              ),
                                              Icon(Icons.mail_outline_outlined),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  storepro.hostMaleList[index].gender == ""
                                      ? "..."
                                      : storepro.hostMaleList[index].gender,
                                  style: GoogleFonts.roboto(fontSize: 12),
                                ),
                                Text(
                                  storepro.hostMaleList[index].hostingDetails ==
                                          ""
                                      ? "..."
                                      : storepro
                                          .hostMaleList[index].hostingDetails,
                                  style: GoogleFonts.roboto(fontSize: 12),
                                ),
                                Text(
                                  storepro.hostMaleList[index].city == ""
                                      ? "..."
                                      : storepro.hostMaleList[index].city,
                                  style: GoogleFonts.roboto(fontSize: 12),
                                ),
                                Text(
                                  storepro.hostMaleList[index].about == ""
                                      ? "..."
                                      : storepro.hostMaleList[index].about,
                                  style: GoogleFonts.roboto(fontSize: 11),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
          });
    });
  }
}
