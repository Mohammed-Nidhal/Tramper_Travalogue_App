
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/Model/user_model.dart';
import 'package:tramber/ViewModel/firestore.dart';
import 'package:tramber/ViewModel/pick_image.dart';
import 'package:tramber/utils/variables.dart';

class UpdateProfile extends StatefulWidget {
  Firestore obj;
  UpdateProfile({super.key, required this.obj});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String selectedGender = 'MALE';
  List<String> options = ['MALE', "FEMALE"];
  String? selectedUserType = "USER";
  List<String> userOptions = [
    'USER',
    "HOSTER",
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var fullname = TextEditingController(text: widget.obj.userModel?.username);

    var phoneNumber =
        TextEditingController(text: "${widget.obj.userModel?.phonenumber}");

    var hosting =
        TextEditingController(text: "${widget.obj.userModel?.gender}");
    var age = TextEditingController(text: "${widget.obj.userModel?.age}");
    var address =
        TextEditingController(text: "${widget.obj.userModel?.address}");
    var message =
        TextEditingController(text: "${widget.obj.userModel?.message}");
    var area = TextEditingController(text: "${widget.obj.userModel?.area}");
    var city = TextEditingController(text: "${widget.obj.userModel?.city}");
    var piccode =
        TextEditingController(text: "${widget.obj.userModel?.pincode}");
    var state = TextEditingController(text: "${widget.obj.userModel?.state}");
    var about = TextEditingController(text: "${widget.obj.userModel?.about}");
    var lebal = TextEditingController(text: "${widget.obj.userModel?.label}");
    var nickNmae =
        TextEditingController(text: "${widget.obj.userModel?.nickeNmae}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        centerTitle: true,
        title: Text("Edit profile",
            style:
                GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600)),
      ),
      body: Consumer<Firestore>(builder: (context, store, child) {
        return FutureBuilder(
            future: store.fetchCurrentUserType(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              selectedUserType = store.type;
              selectedGender = store.gender!.isEmpty ? "MALE" : store.gender!;
              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.black),
                          ),
                          child: widget.obj.userModel!.profileimage.isNotEmpty
                              ? Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.black),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              widget.obj.userModel!.profileimage),
                                          fit: BoxFit.fill)),
                                )
                              : IconButton(
                                  onPressed: () {
                                    selectImage(context, 1)
                                        .then((_) => setState(() {}));
                                  },
                                  icon: const Icon(Icons.add_a_photo),
                                ),
                        ),
                        DropdownButton<String>(
                          value: selectedUserType,
                          onChanged: (newValue) {
                            setState(() {
                              selectedUserType = newValue!;
                              store.editUserType(newValue);
                            });
                          },
                          items: userOptions
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            height: 50,
                            width: 320,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the field";
                                } else {
                                  return null;
                                }
                              },
                              controller: fullname,
                              decoration: const InputDecoration(
                                labelText: "Full name",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 50,
                            width: 320,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the field";
                                } else {
                                  return null;
                                }
                              },
                              controller: nickNmae,
                              decoration: const InputDecoration(
                                labelText: "Nick name",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 50,
                            width: 320,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the field";
                                } else {
                                  return null;
                                }
                              },
                              controller: lebal,
                              decoration: const InputDecoration(
                                labelText: "Label",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 50,
                            width: 320,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the field";
                                } else {
                                  return null;
                                }
                              },
                              controller: phoneNumber,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Phone number",
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: const Color.fromRGBO(
                                          158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 100, top: 20),
                          child: Row(
                            children: [
                              DropdownButton<String>(
                                value: selectedGender,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedGender = newValue!;
                                    store.editUserGender(newValue);
                                  });
                                },
                                items: options.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                width: 20,
                              ),

                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //     right: 10,
                              //   ),
                              //   child: SizedBox(
                              //     height: 50,
                              //     width: 155,
                              //     child: TextFormField(
                              //       validator: (value) {
                              //         if (value!.isEmpty) {
                              //           return "Enter the field";
                              //         } else {
                              //           return null;
                              //         }
                              //       },
                              //       controller: gender,
                              //       decoration: InputDecoration(
                              //         labelText: "Gender",
                              //         border: OutlineInputBorder(
                              //           borderRadius: const BorderRadius.all(
                              //               Radius.circular(10)),
                              //           borderSide: new BorderSide(
                              //               color: const Color.fromRGBO(
                              //                   158, 158, 158, 1)),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                height: 50,
                                width: 155,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter the field";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: age,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "Age",
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: const Color.fromRGBO(
                                              158, 158, 158, 1)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 110,
                            width: 320,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the field";
                                } else {
                                  return null;
                                }
                              },
                              maxLines: 3,
                              controller: address,
                              decoration: InputDecoration(
                                labelText: "Address",
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: const Color.fromRGBO(
                                          158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 50,
                            width: 320,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the field";
                                } else {
                                  return null;
                                }
                              },
                              controller: message,
                              decoration: InputDecoration(
                                labelText: "Message",
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: const Color.fromRGBO(
                                          158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 50,
                            width: 320,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the field";
                                } else {
                                  return null;
                                }
                              },
                              controller: area,
                              decoration: InputDecoration(
                                labelText: "Area",
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: const Color.fromRGBO(
                                          158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 50,
                            width: 320,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the field";
                                } else {
                                  return null;
                                }
                              },
                              controller: city,
                              decoration: InputDecoration(
                                labelText: "City",
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: const Color.fromRGBO(
                                          158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 50,
                            width: 320,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the field";
                                } else {
                                  return null;
                                }
                              },
                              controller: piccode,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Pincode",
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: const Color.fromRGBO(
                                          158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 50,
                            width: 320,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the field";
                                } else {
                                  return null;
                                }
                              },
                              controller: state,
                              decoration: InputDecoration(
                                labelText: "State",
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: const Color.fromRGBO(
                                          158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              height: 110,
                              width: 320,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          158, 158, 158, 1))),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(right: 70, bottom: 20),
                                    child: Text(
                                      "ID proof (We will not take any credentials )",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 100,
                                    decoration: const BoxDecoration(),
                                    child: store
                                            .userModel!.proofimage.isNotEmpty
                                        ? Container(
                                            height: 50,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${store.userModel?.proofimage}"),
                                                    fit: BoxFit.fill)),
                                          )
                                        : TextButton(
                                            onPressed: () {
                                              selectImage(context, 2)
                                                  .then((_) => setState(() {}));
                                            },
                                            child: const Text(
                                              "ADD IMAGE",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                  ),
                                ],
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 110,
                            width: 320,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the field";
                                } else {
                                  return null;
                                }
                              },
                              maxLines: 3,
                              controller: about,
                              decoration: InputDecoration(
                                hintText: "About",
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: const Color.fromRGBO(
                                          158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            height: 110,
                            width: 320,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the field";
                                } else {
                                  return null;
                                }
                              },
                              maxLines: 3,
                              controller: hosting,
                              decoration: InputDecoration(
                                labelText: "Hosting Details",
                                hintText:
                                    'Tell us about your styles, methods and restrictions',
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: const Color.fromRGBO(
                                          158, 158, 158, 1)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              int phone = int.parse(phoneNumber.text);
                              print(imageFileProof);
                              print(currentUID);

                              await store.updateUSerDAta(
                                  currentUID,
                                  UserModel(
                                      userType: selectedUserType!,
                                      label: lebal.text,
                                      age: age.text,
                                      email: "${store.userModel?.email}",
                                      gender: selectedGender,
                                      password: "",
                                      phonenumber: phone,
                                      profileimage:
                                          store.userModel!.profileimage,
                                      proofimage:
                                          "${store.userModel?.proofimage}",
                                      userID: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      username: fullname.text,
                                      about: about.text,
                                      address: address.text,
                                      area: area.text,
                                      city: city.text,
                                      hostingDetails: hosting.text,
                                      message: message.text,
                                      nickeNmae: nickNmae.text,
                                      pincode: piccode.text,
                                      state: state.text),
                                  context);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 320,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.cyan),
                              child: Text(
                                "SUBMIT",
                                style: GoogleFonts.roboto(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}
