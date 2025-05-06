import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/user/drop_menu/bucket_list.dart';
import 'package:tramber/View/modules/user/home_Tabs/couching/Couching.dart';
import 'package:tramber/View/modules/user/home_Tabs/destination/Destinations.dart';

import 'package:tramber/View/modules/user/profile/profile.dart';

import 'package:tramber/ViewModel/firestore.dart';
import 'package:tramber/ViewModel/get_locatiion.dart';
import 'package:tramber/utils/image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current = 0;

  var are = TextEditingController();
  // List of tab bar items

  List<String> texts = [
    "\tDestinations",
    "Couching",
  ];
  List<Widget> tabs2 = [
    Destinations(),
    const Couching(),
  ];
  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Consumer2<Firestore, LocationPrvider>(
        builder: (context, firestore, locpro, cild) {
      // return FutureBuilder(
      // future: firestore.fetchDatas(FirebaseAuth.instance.currentUser!.uid),
      // builder: (context, snapshot) {
      // if (snapshot.connectionState == ConnectionState.waiting) {
      //   return Container(
      //     color: Colors.white,
      //     height: hight,
      //     width: width,
      //     child: const Center(
      //       child: CircularProgressIndicator(),
      //     ),
      //   );
      // }

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: PopupMenuButton(
            icon: const Icon(CupertinoIcons
                .list_dash), //don't specify icon if you want 3 dot menu
            color: HexColor("#055C9D"),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                value: 0,
                child: Text(
                  "Home",
                  style: GoogleFonts.niramit(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              PopupMenuItem<int>(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BucketList()));
                },
                value: 1,
                child: Row(
                  children: [
                    Text(
                      "Bucket List    ",
                      style: GoogleFonts.niramit(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.bookmark,
                      color: Colors.white,
                      size: 18,
                    )
                  ],
                ),
              ),
              // PopupMenuItem<int>(
              //     onTap: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => AddPlace()));
              //     },
              //     value: 2,
              //     child: Text(
              //       "Add a Place",
              //       style: GoogleFonts.niramit(
              //         color: Colors.white,
              //         fontSize: 16,
              //       ),
              //     )),
              PopupMenuItem<int>(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  value: 3,
                  child: Text(
                    "Help",
                    style: GoogleFonts.niramit(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )),
            ],
            onSelected: (item) => {print(item)},
          ),
          title: InkWell(
            onTap: () async {
              await locpro.getCurrentLocation();
            },
            child: SizedBox(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(
                  CupertinoIcons.placemark,
                  size: 16,
                ),
                Text(
                  locpro.place ?? "",
                  style: GoogleFonts.niramit(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
                const Text("|"),
                Text(
                  locpro.country ?? "",
                  style: GoogleFonts.niramit(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black),
                ),
              ]),
            ),
          ),
          actions: [
            FutureBuilder(
                future: firestore
                    .fetchDatas(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: Colors.white,
                      height: hight,
                      width: width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const profile()));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: firestore.userModel!.profileimage.isEmpty
                                  ? imageNotFound
                                  : NetworkImage(
                                      firestore.userModel!.profileimage))),
                    ),
                  );
                })
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: locpro.isLocationFetched == true
                ? const LinearProgressIndicator()
                : const SizedBox(),
          ),
        ),
        body: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.amber,
                  height: hight * .3,
                  width: width,

                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("asset/homemainimage.png"))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),

                      //   return Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [

                      //     ],
                      //   );
                      // }),
                      TabBar(
                          dividerColor: Colors.transparent,
                          indicatorColor: const Color.fromARGB(255, 4, 82, 147),
                          tabs: [
                            Text(
                              texts[0],
                              style: GoogleFonts.niramit(
                                  fontSize: 18,
                                  color: const Color.fromARGB(255, 4, 82, 147),
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              texts[1],
                              style: GoogleFonts.niramit(
                                  fontSize: 18,
                                  color: const Color.fromARGB(255, 4, 82, 147),
                                  fontWeight: FontWeight.w700),
                            ),

                            //
                          ])
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 100),
                      //   child: SizedBox(
                      //     height: 50,
                      //     width: double.infinity,
                      //     child: ListView.separated(
                      //         separatorBuilder: (context, index) {
                      //           return const SizedBox(
                      //             width: 20,
                      //           );
                      //         },
                      //         itemCount: 2,
                      //         scrollDirection: Axis.horizontal,
                      //         itemBuilder: (context, index) {
                      //           return Column(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               GestureDetector(
                      //                 onTap: () {
                      //                   setState(() {
                      //                     current = index;
                      //                   });
                      //                 },
                      //                 child: Text(
                      //                   texts[index],
                      //                   style: GoogleFonts.niramit(
                      //                       fontSize: 18,
                      //                       color: const Color.fromARGB(
                      //                           255, 4, 82, 147),
                      //                       fontWeight: FontWeight.w700),
                      //                 ),
                      //               ),
                      //               Visibility(
                      //                   visible: current == index,
                      //                   child: Container(
                      //                     height: 1,
                      //                     width: 70,
                      //                     color: Colors.black,
                      //                   )),
                      //             ],
                      //           );
                      //         }),
                      //   ),
                      // ),
                      ,
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.cyan)),
                        child: Center(
                          child: Text(
                            "Where would you like to go?",
                            style: TextStyle(
                                fontSize: 16,
                                color: HexColor("#055C9D"),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: TabBarView(children: tabs2))
                // Expanded(
                //   child: SizedBox(
                //     height: hight * .7,
                //     width: double.infinity,
                //     child: tabs2[current],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    });
    // });
  }
}
