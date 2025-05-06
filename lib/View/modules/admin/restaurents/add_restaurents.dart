import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/Model/restaurent_model.dart';
import 'package:tramber/View/modules/admin/restaurents/view_exissting_rest.dart';
import 'package:tramber/ViewModel/controll_provider.dart';
import 'package:tramber/ViewModel/pick_image.dart';
import 'package:tramber/utils/variables.dart';

class AddRestaurentsPage extends StatelessWidget {
  String placeId;
  String locationName;
  AddRestaurentsPage(
      {super.key, required this.placeId, required this.locationName});

  void cleardata() {
    image = null;
    description.clear();
    location.clear();
    resaturentNmae.clear();
  }

  String? image;
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController resaturentNmae = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Restaurent",
            style: GoogleFonts.poppins(fontSize: 26),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewResaturentFromSelectedPlace(
                          Place: locationName,
                          placeId: placeId,
                        ),
                      ));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text(
                  "View Existing Restaurents",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Consumer<Controller>(builder: (context, controller, child) {
          return SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                height: height,
                width: width,
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .07,
                          width: MediaQuery.of(context).size.width * .5,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return " Restaurent Name is required";
                              } else {
                                return null;
                              }
                            },
                            maxLines: 1,
                            controller: resaturentNmae,
                            decoration: const InputDecoration(
                              hintText: "Add Restaurent Name",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(5, 92, 157, 0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 4.8,
                        // width: MediaQuery.of(context).size.width / 1.13,
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
                            await addRestaurentImage().then((value) {
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
                        height: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4.8,
                        // width: MediaQuery.of(context).size.width / 1.13,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "write somthing about this Restaurent ";
                            } else {
                              return null;
                            }
                          },
                          maxLines: 7,
                          controller: description,
                          decoration: const InputDecoration(
                            hintText: "Tell us something about this Restaurent",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(5, 92, 157, 0)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .07,
                          width: MediaQuery.of(context).size.width * .5,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "location is requiered ";
                              } else {
                                return null;
                              }
                            },
                            maxLines: 1,
                            controller: location,
                            decoration: const InputDecoration(
                              hintText: "Add Location",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(5, 92, 157, 0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: SizedBox(
                      //     height: MediaQuery.of(context).size.height * .07,
                      //     width: MediaQuery.of(context).size.width * .5,
                      //     child: TextFormField(
                      //       validator: (value) {
                      //         if (value!.isEmpty) {
                      //           return "Price is required ";
                      //         } else {
                      //           return null;
                      //         }
                      //       },
                      //       maxLines: 1,
                      //       controller: price,
                      //       decoration: const InputDecoration(
                      //         hintText: "Price",
                      //         border: OutlineInputBorder(
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(10)),
                      //           borderSide: BorderSide(
                      //               color: Color.fromRGBO(5, 92, 157, 0)),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (image == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Pick Image ")));
                              } else {
                                storenstence.addRestaurent(
                                    placeId,
                                    RestaurentModel(
                                        category: "Restaurent",
                                        description: description.text,
                                        image: image!,
                                        location: location.text,
                                        restaurentName: resaturentNmae.text));

                                await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor: const Color.fromARGB(
                                              171, 0, 0, 0),
                                          title: const Text(
                                            "Restaurent added Successfully",
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
                                                            ViewResaturentFromSelectedPlace(
                                                          Place: locationName,
                                                          placeId: placeId,
                                                        ),
                                                      ));
                                                },
                                                child: const Text(
                                                  "OK",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ))
                                          ],
                                        ));
                              }

                              print("object");
                            }

                            // storenstence.addHotels(placeId, HotelModel(category: category, description: description, image: image, latitude: latitude, longitude: longitude, location: location, price: price))
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          child: const Text(
                            "Add Restaurent",
                            style: TextStyle(color: Colors.white),
                          ))
                    ]))),
          );
        }));
  }
}
