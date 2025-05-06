
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/Model/popularplacemodel.dart';
import 'package:tramber/View/modules/admin/popularplace/popularlist.dart';
import 'package:tramber/ViewModel/controll_provider.dart';
import 'package:tramber/ViewModel/pick_image.dart';
import 'package:tramber/utils/variables.dart';

class AddNewPopularPlacePage extends StatelessWidget {
  AddNewPopularPlacePage(
      {super.key,
      required this.selectedlocationName,
      required this.selectedlocationid});
  String selectedlocationid;
  String selectedlocationName;
  String? image;
  var namecontrller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Popularplace",
          style: GoogleFonts.poppins(fontSize: 26),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewPopularPlaceFromSelectedPlace(
                              place: selectedlocationName,
                              placeid: selectedlocationid,
                            )));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text(
                "View Existing places",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Consumer<Controller>(builder: (context, controller, _) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "field is required";
                    } else {
                      return null;
                    }
                  },
                  controller: namecontrller,
                  decoration: const InputDecoration(
                      hintText: "Place Name",
                      enabledBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(),
                      disabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 4.8,
                  width: MediaQuery.of(context).size.width / 1.13,
                  decoration: BoxDecoration(
                    color: image == null
                        ? const Color.fromRGBO(104, 187, 227, 0.5)
                        : Colors.transparent,
                    image: DecorationImage(
                        image: image != null
                            ? FileImage(imageFilePopular!)
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
                      await addPopularPlaceImage().then((value) {
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
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        if (image == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Pick Image ")));
                        } else {
                          storenstence.addPopularPlace(
                              selectedlocationid,
                              AddPopularPlace(
                                  image: image!,
                                  placeName: namecontrller.text));

                          await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor:
                                        const Color.fromARGB(171, 0, 0, 0),
                                    title: const Text(
                                      "Hotel added Successfully",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              167, 255, 255, 255)),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            cleardata();
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewPopularPlaceFromSelectedPlace(
                                                          place:
                                                              selectedlocationName,
                                                          placeid:
                                                              selectedlocationid,
                                                        )));
                                          },
                                          child: const Text(
                                            "OK",
                                            style: TextStyle(color: Colors.red),
                                          ))
                                    ],
                                  ));
                        }
                      }
                      // storenstence.addHotels(placeId, HotelModel(category: category, description: description, image: image, latitude: latitude, longitude: longitude, location: location, price: price))
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text(
                      "Add Place",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }

  void cleardata() {
    image = null;
    imageFilePopular = null;

    namecontrller.clear();
  }
}
