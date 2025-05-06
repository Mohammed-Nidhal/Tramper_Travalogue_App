// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:tramber/Model/place_model.dart';
import 'package:tramber/View/modules/admin/place/placelist.dart';

import 'package:tramber/ViewModel/button_state.dart';
import 'package:tramber/ViewModel/controll_provider.dart';
import 'package:tramber/ViewModel/firestore.dart';
import 'package:tramber/ViewModel/get_locatiion.dart';
import 'package:tramber/ViewModel/pick_image.dart';
import 'package:tramber/utils/variables.dart';

class AddPlace extends StatelessWidget {
  AddPlace({super.key});

  var description = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List main = ['About', 'Hosting details', 'Contact'];

  List sampleList = [
    // 'CATEGORY',
    'FAMILY DESTINATION',
    'TOP CATEGORY',
    'ADVENTURES',
  ];

  String? image;

  String location = "";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer2<LocationPrvider, Controller>(
        builder: (context, locpro, controller, child) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: SizedBox(
              width: width,
              child: Row(children: [
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
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade100.withOpacity(0.4),
                Colors.blue.shade300
              ],
            )),
            child: SingleChildScrollView(
              child: Column(children: [
                // const SizedBox(
                //   height: 50,
                // ),
                // // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                // PopupMenuButton(
                //   icon: const Icon(CupertinoIcons
                //       .list_dash), //don't specify icon if you want 3 dot menu
                //   color: HexColor("#055C9D"),
                //   itemBuilder: (context) => [
                //     PopupMenuItem<int>(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => const HomePage()));
                //       },
                //       value: 0,
                //       child: Text(
                //         "Home",
                //         style: GoogleFonts.niramit(
                //           color: Colors.white,
                //           fontSize: 16,
                //         ),
                //       ),
                //     ),
                //     PopupMenuItem<int>(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => const HomePage()));
                //       },
                //       value: 1,
                //       child: Row(
                //         children: [
                //           Text(
                //             "Bucket List    ",
                //             style: GoogleFonts.niramit(
                //               color: Colors.white,
                //               fontSize: 16,
                //             ),
                //           ),
                //           const Icon(
                //             CupertinoIcons.bookmark,
                //             color: Colors.white,
                //             size: 18,
                //           )
                //         ],
                //       ),
                //     ),
                //     PopupMenuItem<int>(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => AddPlace()));
                //         },
                //         value: 2,
                //         child: Text(
                //           "Add a Place",
                //           style: GoogleFonts.niramit(
                //             color: Colors.white,
                //             fontSize: 16,
                //           ),
                //         )),
                //     PopupMenuItem<int>(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => const HomePage()));
                //         },
                //         value: 3,
                //         child: Text(
                //           "Help",
                //           style: GoogleFonts.niramit(
                //             color: Colors.white,
                //             fontSize: 16,
                //           ),
                //         )),
                //   ],
                //   onSelected: (item) => {print(item)},
                // ),

                //     InkWell(
                //       onTap: () {
                //         // Navigator.push(context,
                //         //     MaterialPageRoute(builder: (context) => const profile()));
                //       },
                //       child: Container(
                //         margin: const EdgeInsets.only(right: 20),
                //         height: 30,
                //         width: 30,
                //         decoration: BoxDecoration(
                //             border: Border.all(color: Colors.black),
                //             borderRadius: BorderRadius.circular(100),
                //             image: DecorationImage(
                //                 fit: BoxFit.fill,
                //                 image: storenstence.userModel?.profileimage ==
                //                         ""
                //                     ? imageNotFound
                //                     : NetworkImage(
                //                         "${storenstence.userModel?.profileimage}"))),
                //       ),
                //     )
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 30, bottom: 10),
                  child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                                isExpanded: true,
                                isDense: true,
                                value: controller.cetegory,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.brown,
                                ),
                                iconSize: 40,
                                underline: const Divider(),
                                onChanged: (val) {
                                  controller.onchanged(val);
                                },
                                items: sampleList.map((option) {
                                  return DropdownMenuItem(
                                    value: option,
                                    child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.centerLeft,
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1))),
                                        child: Text(
                                          option,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )),
                                  );
                                }).toList(),
                                hint: Text(
                                  "CATEGORY",
                                  style:
                                      GoogleFonts.niramit(color: Colors.grey),
                                ),
                                selectedItemBuilder: (con) {
                                  return sampleList.map((m) {
                                    return Text(
                                      m,
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    );
                                  }).toList();
                                })),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4.8,
                    width: MediaQuery.of(context).size.width / 1.13,
                    decoration: BoxDecoration(
                      color: image == null
                          ? const Color.fromRGBO(104, 187, 227, 0.5)
                          : Colors.transparent,
                      image: DecorationImage(
                          image: image != null
                              ? FileImage(imageFilePlace!)
                              : const AssetImage('asset/images.jpeg')
                                  as ImageProvider<Object>,
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.black, style: BorderStyle.solid),
                    ),
                    child: InkWell(
                      onTap: () async {
                        controller.imageIsLoading(true);
                        await addPlaceImage().then((value) {
                          image = value;
                          controller.imageIsLoading(false);
                        });
                      },
                      child: controller.isImageLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate_outlined),
                                Text("ADD IMAGE"),
                              ],
                            ),
                    ),
                  ),
                ),
                // Container(
                //   height:MediaQuery.of(context).size.height/3.8,
                //   width: MediaQuery.of(context).size.width/1.13,
                //   decoration: BoxDecoration(
                //     color: Colors.cyan,
                //     borderRadius: BorderRadius.circular(12)
                //   ),
                //
                // )
                Form(
                  key: _formKey,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 4.8,
                    width: MediaQuery.of(context).size.width / 1.13,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "write somthing about this space ";
                        } else {
                          return null;
                        }
                      },
                      maxLines: 7,
                      controller: description,
                      decoration: const InputDecoration(
                        hintText: "Tell us something about this place",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(color: Color.fromRGBO(5, 92, 157, 0)),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await locpro.getCurrentLocation().then((value) {
                      location = value!;
                      buttonState = ButtonState.fetched;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Current Location is $value")));
                    });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 190, bottom: 20),
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height / 27,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: HexColor("#0E86D4")),
                      child: Text(
                        _buildButtonText(),
                        style: GoogleFonts.habibi(
                            fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      if (controller.cetegory == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Select Category ")));
                      } else if (!(buttonState == ButtonState.fetched)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Fetch your location")));
                      } else if (image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Pick Image ")));
                      } else {
                        await storenstence.addPlaceDetailsToFirestore(
                            PlaceModel(
                                isLiked: "false",
                                category: controller.cetegory,
                                description: description.text,
                                image: image!,
                                latitude: locpro.lat!,
                                longitude: locpro.lon!,
                                location: location));
                        //     // ignore: use_build_context_synchronously
                        // ignore: use_build_context_synchronously
                        await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  backgroundColor:
                                      const Color.fromARGB(171, 0, 0, 0),
                                  title: const Text(
                                    "Place added Successfully",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(167, 255, 255, 255)),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          description.clear();
                                          buttonState =
                                              ButtonState.defaultvalue;
                                          image = null;

                                          Provider.of<Firestore>(context,
                                                  listen: false)
                                              .fetchAllPlaces();
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PlaceListPage()));
                                        },
                                        child: const Text(
                                          "OK",
                                          style: TextStyle(color: Colors.red),
                                        ))
                                  ],
                                ));
                      }

                      print("object");
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 27,
                    width: MediaQuery.of(context).size.width / 3.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: HexColor("#0E86D4")),
                    child: Text(
                      "ADD",
                      style:
                          GoogleFonts.habibi(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    alignment: Alignment.topLeft,
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100.withOpacity(0.9)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                              "Once again, thank you for your dedication to making our travel experiences more enjoyable and memorable. Your efforts are greatly appreciated, and I look forward to seeing more exciting additions in the future."),
                          Text(
                            "TRAMPER",
                            style: GoogleFonts.niramit(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ));
    });
  }
}

String _buildButtonText() {
  switch (buttonState) {
    case ButtonState.defaultvalue:
      return 'GET CURRENT LOCATION';
    case ButtonState.fetching:
      return 'LOCATION IS FETCHING...';
    case ButtonState.fetched:
      return 'LOCATION IS FETCHED';
  }
}
