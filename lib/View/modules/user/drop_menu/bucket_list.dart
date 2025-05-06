import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/user/home.dart';
import 'package:tramber/View/modules/user/profile/profile.dart';
import 'package:tramber/ViewModel/controll_provider.dart';
import 'package:tramber/ViewModel/firestore.dart';
import 'package:tramber/ViewModel/get_locatiion.dart';
import 'package:tramber/utils/image.dart';
import 'package:tramber/utils/variables.dart';

class BucketList extends StatefulWidget {
  const BucketList({super.key});

  @override
  State<BucketList> createState() => _BucketListState();
}

class _BucketListState extends State<BucketList> {
  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
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
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
          Consumer<Firestore>(builder: (context, firestore, child) {
            return InkWell(
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
            );
          })
        ],
      ),
      body: Consumer<Firestore>(builder: (context, firestore, child) {
        return FutureBuilder(
            future: firestore.fetchAllBucketList(currentUID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container(
                height: hight,
                width: width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "asset/img_7.png",
                        ),
                        fit: BoxFit.fill)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "BUCKET LIST",
                        style: GoogleFonts.marcellusSc(
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    firestore.bucketList.isEmpty
                        ? Expanded(
                            child: SizedBox(
                            child: Center(
                                child: Text(
                              "Your Bucket List Is Empty!",
                              style: GoogleFonts.marcellus(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                          ))
                        : Expanded(
                            child: GridView.builder(
                                itemCount: firestore.bucketList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(firestore
                                                .bucketList[index].image)),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    // width: width * .45,
                                    // height: 230,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Consumer<Controller>(builder:
                                              (context, controller, child) {
                                            return IconButton(
                                                onPressed: () async {
                                                  await firestore
                                                      .removeFromBucketList(
                                                          currentUID,
                                                          firestore
                                                              .bucketList[index]
                                                              .bucketListId);
                                                  // controller.isplaceSvae();
                                                },
                                                icon: const Icon(
                                                  CupertinoIcons.delete,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),

                                                  // size: 18,
                                                ));
                                          }),
                                        ),
                                        Text(
                                          firestore.bucketList[index].location,
                                          // placesData[index]["name"],
                                          style: GoogleFonts.marcellus(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                  ],
                ),
              );
            });
      }),
    );
  }
}
