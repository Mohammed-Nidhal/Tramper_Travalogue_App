import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/ViewModel/firestore.dart';

class ViewPopularPlaceFromSelectedPlace extends StatelessWidget {
  String place;
  String placeid;
  ViewPopularPlaceFromSelectedPlace(
      {super.key, required this.place, required this.placeid});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Popular Places in $place",
          style: GoogleFonts.poppins(fontSize: 26),
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Consumer<Firestore>(builder: (context, firestore, child) {
          return FutureBuilder(
              future: firestore.fetchAllpopPlacesFromSelectedPlace(placeid),
              builder: (context, snaps) {
                if (snaps.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final list = firestore.popularList;
                return list.isEmpty
                    ? const Center(
                        child: Text("No popular place in this location"),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(20),
                            width: width,
                            height: height * .3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width,
                                  height: height * .2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image:
                                              NetworkImage(list[index].image))),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Name:${list[index].placeName}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: list.length);
              });
        }),
      ),
    );
  }
}
