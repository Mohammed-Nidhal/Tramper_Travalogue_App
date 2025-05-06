import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/admin/hotel/add_hotel_page.dart';
import 'package:tramber/View/modules/admin/popularplace/add_popular.dart';
import 'package:tramber/View/modules/admin/restaurents/add_restaurents.dart';
import 'package:tramber/ViewModel/firestore.dart';

class PlaceListPage extends StatelessWidget {
  const PlaceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider.of<Firestore>(context, listen: false).fetchAllPlaces();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Places",
          style: GoogleFonts.poppins(fontSize: 26),
        ),
      ),
      body: Consumer<Firestore>(builder: (context, firestore, child) {
        return FutureBuilder(
            future: firestore.fetchAllPlaces(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final list = firestore.placeList;
              return list.isEmpty
                  ? Center(
                      child: Text("No Places"),
                    )
                  : SizedBox(
                      width: width,
                      height: height,
                      child: ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                                color: Colors.black,
                              ),
                          // gridDelegate:
                          //     const SliverGridDelegateWithFixedCrossAxisCount(
                          //         crossAxisCount: 2,
                          //         childAspectRatio: .65,
                          //         mainAxisSpacing: 15,
                          //         crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        child: Column(
                                          children: [
                                            Text(
                                              list[index].location,
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            const Divider(),
                                            SizedBox(
                                                height: height * .1,
                                                width: width * .35,
                                                child: Image.network(
                                                  list[index].image,
                                                  fit: BoxFit.fill,
                                                )),
                                            SizedBox(
                                                width: width * .35,
                                                child: Text(
                                                  list[index].description,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width / 2,
                                            child: ListTile(
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddHotelsPage(
                                                                    locationName:
                                                                        list[index]
                                                                            .location,
                                                                    placeId:
                                                                        "${list[index].placeID}")));
                                                  },
                                                  icon: const Icon(Icons
                                                      .add_circle_rounded)),
                                              title: const Text(
                                                "Hotels",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 1),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 2,
                                            child: ListTile(
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddRestaurentsPage(
                                                                    locationName:
                                                                        list[index]
                                                                            .location,
                                                                    placeId:
                                                                        "${list[index].placeID}")));
                                                  },
                                                  icon: const Icon(Icons
                                                      .add_circle_rounded)),
                                              title: const Text(
                                                "Restaurents",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.grey,
                                                    letterSpacing: 1),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 2,
                                            child: ListTile(
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddNewPopularPlacePage(
                                                                  selectedlocationName:
                                                                      list[index]
                                                                          .location,
                                                                  selectedlocationid:
                                                                      list[index]
                                                                          .placeID!,
                                                                )));
                                                  },
                                                  icon: const Icon(Icons
                                                      .add_circle_rounded)),
                                              title: const Text(
                                                "Popular Place",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.grey,
                                                    letterSpacing: 1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: SizedBox(
                                      width: width / 2,
                                      child: ListTile(
                                          trailing: IconButton(
                                            onPressed: () {
                                              firestore
                                                  .deletePlacefromFirestore(
                                                      list[index].placeID);
                                            },
                                            icon: const Icon(
                                              Icons.delete_outline_rounded,
                                              color: Color.fromARGB(
                                                  212, 181, 0, 0),
                                            ),
                                          ),
                                          title: Container(
                                            alignment: Alignment.center,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      212, 181, 0, 0),
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: list.length),
                    );
            });
      }),
    );
  }
}
