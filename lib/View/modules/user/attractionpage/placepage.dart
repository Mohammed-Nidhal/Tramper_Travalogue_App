import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/user/attractionpage/tabs/attraction_tab.dart';
import 'package:tramber/View/modules/user/attractionpage/tabs/hotel_tab.dart';
import 'package:tramber/View/modules/user/attractionpage/tabs/restaurent_tab.dart';
import 'package:tramber/View/modules/user/drop_menu/bucket_list.dart';

import 'package:tramber/View/modules/user/profile/profile.dart';

import 'package:tramber/ViewModel/firestore.dart';
import 'package:tramber/ViewModel/get_locatiion.dart';
import 'package:tramber/utils/image.dart';

class PlaceMainPage extends StatefulWidget {
  String Place;
  String placeId;
  String image;
  String description;
  double lat;
  double lon;
  PlaceMainPage(
      {super.key,
      required this.placeId,
      required this.Place,
      required this.image,
      required this.lat,
      required this.lon,
      required this.description});

  @override
  State<PlaceMainPage> createState() => _PlaceMainPageState();
}

class _PlaceMainPageState extends State<PlaceMainPage> {
  int current = 0;

  var are = TextEditingController();
  // List of tab bar items

  List<Map<String, dynamic>> items = [
    {
      'name': 'Attraction',
    },
    {
      'name': 'Restaurent',
    },
    {
      'name': 'Hotels',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs2 = [
      Attraction(
          image: widget.image,
          description: widget.description,
          place: widget.Place,
          placeID: widget.placeId,
          lat: widget.lat,
          lon: widget.lon),
      Restaurent(
        placeID: widget.placeId,
      ),
      Hotels(
        plceId: widget.placeId,
      )
    ];
    // Provider.of<Firestore>(context, listen: false).fetchDatas(currentUID);

    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Consumer<Firestore>(builder: (context, firestore, cild) {
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
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 212, 240, 255),
                Color.fromARGB(255, 175, 211, 231),
                Color.fromARGB(255, 176, 195, 206)
                // Colors.blue
              ])),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // color: Colors.amber,
                height: hight * .3,
                width: width,

                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(widget.image))),
              ),
              Text(
                "LETS TRAMPER ${widget.Place.toUpperCase()}",
                style: GoogleFonts.marcellus(
                    color: Color.fromARGB(255, 181, 94, 68),
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.all(5),
                                height: 35,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: current == index
                                      ? HexColor("#055C9D")
                                      : HexColor("#FFFFFF"),
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: HexColor("#055C9D")),
                                ),
                                duration: Duration(),
                                child: Wrap(
                                  spacing: 25,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        top: 5,
                                      ),
                                      child: Text(
                                        items[index]['name'],
                                        style: GoogleFonts.niramit(
                                            color: HexColor("#68BBE3"),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding:
                                    //       const EdgeInsets.only(top: 4),
                                    //   child: Icon(
                                    //     items[index]['icon'],
                                    //   ),
                                    // )
                                  ],
                                ),
                              )),
                        ],
                      );
                    }),
              ),
              Expanded(
                child: SizedBox(
                  height: hight * .7,
                  width: double.infinity,
                  child: tabs2[current],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
