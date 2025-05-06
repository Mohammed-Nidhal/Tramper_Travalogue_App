
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/user/drop_menu/bucket_list.dart';
import 'package:tramber/View/modules/user/profile/profile.dart';
import 'package:tramber/ViewModel/firestore.dart';
import 'package:tramber/ViewModel/get_locatiion.dart';
import 'package:tramber/utils/image.dart';

class restaurentDetailPage extends StatelessWidget {
  String palceId;
  String resId;
  restaurentDetailPage({super.key, required this.palceId, required this.resId});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<Firestore>(builder: (context, firestore, _) {
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
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const HomePage()));
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => HomePage()));
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
          title: Consumer<LocationPrvider>(builder: (context, locpro, child) {
            return SizedBox(
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
            );
          }),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profile()));
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: firestore.userModel?.profileimage == ""
                            ? imageNotFound
                            : NetworkImage(
                                "${firestore.userModel?.profileimage}"))),
              ),
            )
          ],
        ),
        body: Consumer<Firestore>(builder: (context, firestoree, child) {
          return FutureBuilder(
              future: firestoree.fetchSelectedRestaurentDetails(palceId, resId),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final restaurent = firestoree.selectedRestaurent;
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: width,
                          height: height * .3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(restaurent!.image),
                                fit: BoxFit.fill),
                          )),
                      SizedBox(
                        height: height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            restaurent.restaurentName.toUpperCase() ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 22),
                          ),
                          // Row(
                          //   children: [
                          //     // Text(
                          //     //   restaurent.price.toUpperCase(),
                          //     //   style: const TextStyle(
                          //     //       fontSize: 17,
                          //     //       fontWeight: FontWeight.w900,
                          //     //       color: Color.fromRGBO(79, 39, 255, 0.622)),
                          //     // ),
                          //     const Text(
                          //       "/night",
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.w600,
                          //           fontSize: 17,
                          //           color: Colors.grey),
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: Color.fromRGBO(72, 31, 255, 0.62),
                              ),
                              Text(
                                restaurent.location.characters.first
                                            .toUpperCase() +
                                        restaurent.location.substring(1) ??
                                    "",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              width: width / 3.4,
                              height: 30,
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () async {
                                    await MapsLauncher.launchQuery(
                                        restaurent.location ?? "");
                                  },
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "Location",
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ],
                                  )),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      SizedBox(
                        child: Text(
                          restaurent.description ?? "",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Align(
                        child: const Text(
                          "Similar Restaurent",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      FutureBuilder(
                          future: firestore
                              .fetchAllRestaurentFromSelectedPlace(palceId),
                          builder: (context, snap) {
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final list = firestore.restaurentList;
                            return Expanded(
                                child: ListView.separated(
                              itemCount: list.length,
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 120,
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            offset: Offset.fromDirection(1),
                                            color: Color.fromARGB(44, 0, 0, 0),
                                            spreadRadius: 1)
                                      ]),
                                  child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(5),
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      list[index].image))),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  list[index]
                                                      .restaurentName
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_pin,
                                                  color: Color.fromARGB(
                                                      255, 63, 93, 212),
                                                ),
                                                Text(
                                                  list[index].location,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ]),
                                );
                              },
                            ));
                          })
                    ],
                  ),
                );
              });
        }),
      );
    });
  }
}
