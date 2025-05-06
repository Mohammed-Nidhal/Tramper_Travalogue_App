
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/user/attractionpage/placepage.dart';
import 'package:tramber/ViewModel/firestore.dart';

class Destinations extends StatefulWidget {
  const Destinations({super.key, required});

  @override
  State<Destinations> createState() => _DestinationsState();
}

class _DestinationsState extends State<Destinations> {
  // List<Map<String, dynamic>> categoryItems = [
  //   {
  //     "Place": "BEACHES",
  //     "Image": "asset/beaches.jpeg",
  //     "Description":
  //         "Beaches are popular destinations for relaxation, water activities, and natural beauty. Coastline with a range of beautiful beaches are Goa, Kovalam, Kanyakumari, Marina beach and so on.",
  //     "nav": const Beaches()
  //   },
  //   {
  //     "Place": "MOUNTAINs",
  //     "Image": "asset/mountain.jpeg",
  //     "Description":
  //         "Mountains, these towering giants of the Earth, embody nature's grandeur and timelessness. Their rugged peaks, cloaked in blankets of snow or shrouded in ancient forests, stand as stoic sentinels that have witnessed the passage of countless seasons. Each mountain range tells a unique story, etching its own character on the landscape.",
  //     "nav": const Mountains()
  //   }
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Firestore>(builder: (context, firestore, child) {
        // final allPlaces = firestore.allPlaces;

        return FutureBuilder(
            future: firestore.fetchDestination(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final family = firestore.familyDestinationList;
              final topCatergory = firestore.topCategoryList;
              final adventureList = firestore.adventuresList;
              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("CATEGORY",style: GoogleFonts.niramit(fontWeight: FontWeight.w700,fontSize: 18),),
                      // ),
                      // SizedBox(
                      //   height: 350,
                      //   child: ListView.builder(

                      //       scrollDirection: Axis.horizontal,

                      //       itemBuilder: (context,index){
                      //         return Padding(
                      //           padding: const EdgeInsets.all(4.0),
                      //           child: Stack(
                      //             children: [
                      //               Container(
                      //                 height: 140,
                      //                 width: 250,
                      //                 decoration: BoxDecoration(
                      //                     color: Colors.cyan,
                      //                     borderRadius: BorderRadius.only(topLeft: Radius.circular(22),topRight: Radius.circular(22))
                      //                 ),

                      //               ),
                      //               Padding(
                      //                 padding: const EdgeInsets.only(top: 120),
                      //                 child: Container(
                      //                   height: 200,
                      //                   width: 250,
                      //                   decoration: BoxDecoration(
                      //                       color: Colors.white,
                      //                       borderRadius: BorderRadius.circular(22),
                      //                       border: Border.all(color: Colors.black)
                      //                   ),
                      //                   child: Column(
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     children: [
                      //                       Padding(
                      //                         padding: const EdgeInsets.only(left: 10,top: 10),
                      //                         child: Text("RAJAtSTHAN",style: GoogleFonts.marcellusSc(fontSize: 16,fontWeight: FontWeight.w400,),),
                      //                       ),
                      //                       Padding(
                      //                         padding: const EdgeInsets.only(left: 5),
                      //                         child: Text("""Rajasthan, located in northwestern India, is a land of majestic palaces, historic forts,and vibrant culture. Visitors are drawn to iconic attractions like the Amber Fort in Jaipur, the intricate carvings of Ranakpur Jain Temple, and the desert city of Jaisalmer with its golden-hued architecture. """,
                      //                           style: GoogleFonts.niramit(fontSize: 12),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding: const EdgeInsets.only(top: 280,left: 140),
                      //                 child: Container(
                      //                   alignment: Alignment.center,
                      //                   height: 30,
                      //                   width: 100,
                      //                   decoration: BoxDecoration(
                      //                       color: Colors.blue,
                      //                       borderRadius: BorderRadius.circular(100)
                      //                   ),
                      //                   child: Text("Explore Now",style: GoogleFonts.niramit(color: Colors.white),),
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         );
                      //       }),
                      // ),
                      family.isEmpty
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "FAMILY DESTINATIONS",
                                style: GoogleFonts.niramit(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                      family.isEmpty
                          ? SizedBox()
                          : SizedBox(
                              height: 350,
                              child: ListView.builder(
                                  itemCount: family.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 140,
                                            width: 250,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        family[index].image)),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(22),
                                                        topRight:
                                                            Radius.circular(
                                                                22))),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 120),
                                            child: Container(
                                              height: 200,
                                              width: 250,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 10),
                                                    child: Text(
                                                      family[index].location,
                                                      style: GoogleFonts
                                                          .marcellusSc(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                      family[index].description,
                                                      style:
                                                          GoogleFonts.niramit(
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 280, left: 140),
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PlaceMainPage(
                                                                  Place: family[
                                                                          index]
                                                                      .location,
                                                                  placeId:
                                                                      "${family[index].placeID}",
                                                                  image:
                                                                      family[index].image,
                                                                  description: family[
                                                                          index]
                                                                      .description,
                                                                  lat: family[
                                                                          index]
                                                                      .latitude,
                                                                  lon: family[
                                                                          index]
                                                                      .longitude,
                                                                )));
                                                  },
                                                  child: Text(
                                                    "Explore Now",
                                                    style: GoogleFonts.niramit(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                      topCatergory.isEmpty
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "TOP CATEGORY",
                                style: GoogleFonts.niramit(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                      topCatergory.isEmpty
                          ? SizedBox()
                          : SizedBox(
                              height: 350,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: topCatergory.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 140,
                                            width: 250,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        topCatergory[index]
                                                            .image)),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(22),
                                                        topRight:
                                                            Radius.circular(
                                                                22))),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 120),
                                            child: Container(
                                              height: 200,
                                              width: 250,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 10),
                                                    child: Text(
                                                      topCatergory[index]
                                                          .location,
                                                      style: GoogleFonts
                                                          .marcellusSc(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                      topCatergory[index]
                                                          .description,
                                                      style:
                                                          GoogleFonts.niramit(
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 280, left: 140),
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => PlaceMainPage(
                                                                placeId:
                                                                    topCatergory[
                                                                            index]
                                                                        .placeID
                                                                        .toString(),
                                                                Place:
                                                                    topCatergory[
                                                                            index]
                                                                        .location,
                                                                image:
                                                                    topCatergory[
                                                                            index]
                                                                        .image,
                                                                lat: topCatergory[
                                                                        index]
                                                                    .latitude,
                                                                lon: topCatergory[
                                                                        index]
                                                                    .longitude,
                                                                description:
                                                                    topCatergory[
                                                                            index]
                                                                        .description)
                                                            // topCatergory[index]["nav"]
                                                            //  PlaceMainPage(
                                                            //     description:
                                                            //         topCatergory[index]
                                                            //             .description,
                                                            //     Place: topCatergory[index]
                                                            //         .location,
                                                            //     placeId:
                                                            //         "${topCatergory[index].placeID}",
                                                            //     image:
                                                            //         "${topCatergory[index].image}")
                                                            // DeCategory(
                                                            //   image:
                                                            //       "assets/noImage.png",
                                                            //   about: "ghfvhgdvhvmsjh",
                                                            //   name: "jvdjhvjkdh",
                                                            //   place: "gvdkvhdfj",
                                                            //   star: 3,
                                                            // )
                                                            ));
                                                  },
                                                  child: Text(
                                                    "Explore Now",
                                                    style: GoogleFonts.niramit(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                      adventureList.isEmpty
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "ADVENTURES",
                                style: GoogleFonts.niramit(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ),
                      adventureList.isEmpty
                          ? SizedBox()
                          : SizedBox(
                              height: 350,
                              child: ListView.builder(
                                  itemCount: adventureList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 140,
                                            width: 250,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        adventureList[index]
                                                            .image)),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(22),
                                                        topRight:
                                                            Radius.circular(
                                                                22))),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 120),
                                            child: Container(
                                              height: 200,
                                              width: 250,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 10),
                                                    child: Text(
                                                      adventureList[index]
                                                          .location,
                                                      style: GoogleFonts
                                                          .marcellusSc(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                      adventureList[index]
                                                          .description,
                                                      style:
                                                          GoogleFonts.niramit(
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 280, left: 140),
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => PlaceMainPage(
                                                          placeId:
                                                              adventureList[index]
                                                                  .placeID
                                                                  .toString(),
                                                          Place: adventureList[
                                                                  index]
                                                              .location,
                                                          image: adventureList[
                                                                  index]
                                                              .image,
                                                          lat:
                                                              adventureList[index]
                                                                  .latitude,
                                                          lon:
                                                              adventureList[index]
                                                                  .longitude,
                                                          description:
                                                              adventureList[index]
                                                                  .description)));
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             // PlaceMainPage(
                                                  //             //   description:
                                                  //             //       adventureList[index]
                                                  //             //           .description,
                                                  //             //   Place: adventureList[index]
                                                  //             //       .location,
                                                  //             //   placeId:
                                                  //             //       "${adventureList[index].placeID}",
                                                  //             //   image:
                                                  //             //       "${adventureList[index].image}",
                                                  //             // )
                                                  //             adventureList[index]["nav"]));
                                                },
                                                child: Text(
                                                  "Explore Now",
                                                  style: GoogleFonts.niramit(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
