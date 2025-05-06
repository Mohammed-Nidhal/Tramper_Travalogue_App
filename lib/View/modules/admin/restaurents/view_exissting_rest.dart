import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/ViewModel/firestore.dart';

class ViewResaturentFromSelectedPlace extends StatelessWidget {
  String Place;
  String placeId;
  ViewResaturentFromSelectedPlace(
      {super.key, required this.Place, required this.placeId});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restaurents in $Place",
          style: GoogleFonts.poppins(fontSize: 26),
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Consumer<Firestore>(builder: (context, firestore, child) {
          return FutureBuilder(
              future: firestore.fetchAllRestaurentFromSelectedPlace(placeId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final list = firestore.restaurentList;
                return list.isEmpty
                    ? Center(
                        child: Text("No restaurent"),
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
                                  "Name:${list[index].restaurentName}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Description:${list[index].description}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                )
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
