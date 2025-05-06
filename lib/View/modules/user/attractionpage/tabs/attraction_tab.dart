import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'package:provider/provider.dart';
import 'package:tramber/Model/bucketlist_model.dart';
import 'package:tramber/View/modules/user/hosting/HosterProfile.dart';
import 'package:tramber/ViewModel/controll_provider.dart';
import 'package:tramber/ViewModel/firestore.dart';
import 'package:tramber/utils/image.dart';
import 'package:tramber/utils/variables.dart';

class Attraction extends StatelessWidget {
  String image;
  String description;
  String place;
  String placeID;
  double lat;
  double lon;
  Attraction(
      {super.key,
      required this.image,
      required this.description,
      required this.place,
      required this.lat,
      required this.lon,
      required this.placeID});

  List<Map<String, dynamic>> placesData = [
    {"name": "Amber Fort", "Image": "asset/one.png"},
    {"name": "Mehrangar Fort", "Image": "asset/two.png"},
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .27,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: height * .18,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          image: DecorationImage(
                              fit: BoxFit.fill, image: NetworkImage(image))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                place,
                                style: GoogleFonts.marcellus(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Consumer2<Controller, Firestore>(builder:
                                (context, controller, firestore, child) {
                              return FutureBuilder(
                                  future: firestore
                                      .checkThePlaceisInTheBucketList(placeID),
                                  builder: (context, snap) {
                                    if (snap.connectionState ==
                                        ConnectionState.waiting) {
                                      return SizedBox();
                                    }
                                    return IconButton(
                                        onPressed: () async {
                                          // controller.isplaceSvae();
                                          if (firestore.isLiked == false) {
                                            await storenstence
                                                .addtoBucketList(
                                                    currentUID,
                                                    BucketListModel(
                                                      placeID: placeID,
                                                      image: image,
                                                      location: place,
                                                    ),
                                                    placeID)
                                                .then((value) {
                                              firestore.getTheNewvalue();
                                            });
                                          }
                                          if (firestore.isLiked == true) {
                                            await firestore
                                                .removeFromBucketList(
                                                    currentUID, placeID);
                                          }
                                        },
                                        icon: firestore.isLiked!
                                            ? const Icon(
                                                CupertinoIcons.bookmark_fill,
                                                color: Colors.white,

                                                // size: 18,
                                              )
                                            : const Icon(
                                                CupertinoIcons.bookmark,
                                                color: Colors.black,

                                                // size: 18,
                                              ));
                                  });
                            })
                          ],
                        ),
                      ),
                    ),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                              await MapsLauncher.launchCoordinates(lat, lon);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Popular Places",
                  style: GoogleFonts.poppins(fontSize: 20),
                ),
              ),
              Consumer<Firestore>(builder: (context, firestore, _) {
                return FutureBuilder(
                    future:
                        firestore.fetchAllpopPlacesFromSelectedPlace(placeID),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final list = firestore.popularList;
                      return SizedBox(
                        height: height * .25,
                        width: width,
                        // color: Colors.red,
                        child: list.isEmpty
                            ? Center(
                                child: Text(
                                  "Popular place not found in this place...",
                                  style: GoogleFonts.poppins(fontSize: 20),
                                ),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 15,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: list.length,
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image:
                                              NetworkImage(list[index].image)),
                                      borderRadius: BorderRadius.circular(30)),
                                  width: width * .45,
                                  height: 230,
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    list[index].placeName.toUpperCase(),
                                    style: GoogleFonts.marcellus(
                                        color: const Color.fromARGB(
                                            255, 99, 99, 99),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                      );
                    });
              }),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Hosts",
                  style: GoogleFonts.poppins(fontSize: 20),
                ),
              ),
              Consumer<Firestore>(builder: (context, firestore, child) {
                return FutureBuilder(
                    future: firestore.fetchSelectedPlaceHosters(place),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SizedBox(
                          height: height * .25,
                          width: width,
                          child: firestore.selctedPlaceHosterList.isEmpty
                              ? Center(
                                  child: Text(
                                    "Hosters not found in this place...",
                                    style: GoogleFonts.poppins(fontSize: 20),
                                  ),
                                )
                              : ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return HosterProfile(
                                              hosterId: firestore
                                                  .selctedPlaceHosterList[index]
                                                  .userID,
                                            );
                                          },
                                        ));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(10),
                                        // height: MediaQuery.of(context).size.height / 3.5,
                                        // width: MediaQuery.of(context).size.width / 2,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                99, 255, 255, 255),
                                            // color: Colors.green,
                                            // border: Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      17,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      8,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    image: DecorationImage(
                                                        image: firestore
                                                                    .selctedPlaceHosterList[
                                                                        index]
                                                                    .profileimage ==
                                                                ""
                                                            ? imageNotFound
                                                            : NetworkImage(firestore
                                                                .selctedPlaceHosterList[
                                                                    index]
                                                                .profileimage),
                                                        fit: BoxFit.fill),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .26,
                                                        child: Text(
                                                          firestore
                                                              .selctedPlaceHosterList[
                                                                  index]
                                                              .username,
                                                          style: GoogleFonts
                                                              .niramit(
                                                                  fontSize: 17),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      const Row(
                                                        children: [
                                                          Icon(LineIcons.phone),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5,
                                                                    right: 5),
                                                            child: Icon(LineIcons
                                                                .alternateComment),
                                                          ),
                                                          Icon(Icons
                                                              .mail_outline_outlined),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              firestore
                                                          .selctedPlaceHosterList[
                                                              index]
                                                          .gender ==
                                                      ""
                                                  ? "..."
                                                  : firestore
                                                      .selctedPlaceHosterList[
                                                          index]
                                                      .gender,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              firestore
                                                          .selctedPlaceHosterList[
                                                              index]
                                                          .hostingDetails ==
                                                      ""
                                                  ? "..."
                                                  : firestore
                                                      .selctedPlaceHosterList[
                                                          index]
                                                      .hostingDetails,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              firestore
                                                          .selctedPlaceHosterList[
                                                              index]
                                                          .city ==
                                                      ""
                                                  ? "..."
                                                  : firestore
                                                      .selctedPlaceHosterList[
                                                          index]
                                                      .city,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              firestore
                                                          .selctedPlaceHosterList[
                                                              index]
                                                          .about ==
                                                      ""
                                                  ? "..."
                                                  : firestore
                                                      .selctedPlaceHosterList[
                                                          index]
                                                      .about,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 11),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 20,
                                      ),
                                  itemCount:
                                      firestore.selctedPlaceHosterList.length));
                    });
              }),
              //   return Text(firestore.selctedPlaceHosterList[1].gender) ??
              //       Text("bnod");
              // }),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

// void openGoogleMaps(double latitude, double longitude) async {
//     // Construct the Google Maps URL with the specified coordinates
//     Uri url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

//     // Check if the URL can be launched
//     if (await canLaunchUrl(url)) {
//       // Launch the URL
//       await launchUrl(url);
//     } else {
//       // Handle the case where the URL cannot be launched
//       print('Could not launch $url');
//     }
//   }
}
