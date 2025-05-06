import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/user/attractionpage/hotel_deailpage.dart';
import 'package:tramber/ViewModel/firestore.dart';

class Hotels extends StatelessWidget {
  const Hotels({super.key, required this.plceId});
  final String? plceId;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: height,
        width: width,
        child: Consumer<Firestore>(builder: (context, firestore, child) {
          return FutureBuilder(
            future: firestore.fetchHotelsInSelectedPlace(plceId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final list = firestore.hotelsList;
              return list.isEmpty
                  ? Center(
                      child: Text(
                      "Oops!..Hotels Not Found In This Place",
                      style: GoogleFonts.marcellus(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HotelDetailPage(
                                placeId: plceId!,
                                hotelId: list[index].hotelID.toString(),
                              ),
                            ));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            width: width,
                            height: height * .23,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(list[index].image))),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    // color: Colors.amber,
                                    height: height * .06,
                                    width: width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                list[index].hotelName
                                                    .toUpperCase(),
                                                style: GoogleFonts.abel(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              // Text(
                                              //   "Description:${list[index].description}",
                                              //   style: GoogleFonts.abel(
                                              //       fontWeight: FontWeight.bold,
                                              //       color: Colors.white),
                                              // )
                                            ],
                                          ),
                                          Text(
                                            "₹ ${list[index].price}",
                                            style: GoogleFonts.abel(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: list.length);
            },
          );
        }));
  }
}
