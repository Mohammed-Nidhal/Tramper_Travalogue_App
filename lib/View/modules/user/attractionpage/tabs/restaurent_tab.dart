import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/user/attractionpage/restaurenr_detailpage.dart';
import 'package:tramber/ViewModel/firestore.dart';

class Restaurent extends StatelessWidget {
  const Restaurent({super.key, required this.placeID});
  final String placeID;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: width,
      child: Consumer<Firestore>(builder: (context, firestore, child) {
        return FutureBuilder(
            future: firestore.fetchResturentInSelectedPlace(placeID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final list = firestore.restaurentList;

              return list.isEmpty
                  ? Center(
                      child: Text(
                      "Oops!..Restaurent Not Found In This Place",
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
                              builder: (context) => restaurentDetailPage(
                                resId: list[index].restID.toString(),
                                palceId: placeID,
                              ),
                            ));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            width: width,
                            height: height * .23,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            list[index].restaurentName
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
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: list.length);
            });
      }),
    );
  }
}
