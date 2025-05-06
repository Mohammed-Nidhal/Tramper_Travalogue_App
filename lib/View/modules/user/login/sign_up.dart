import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tramber/Model/user_model.dart';
import 'package:tramber/View/modules/user/home.dart';
import 'package:tramber/View/modules/user/login/login.dart';
import 'package:tramber/utils/variables.dart';

class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  TextEditingController emailCtlr = TextEditingController();
  TextEditingController passwordCtlr = TextEditingController();
  TextEditingController conforrmPasswordCtlr = TextEditingController();
  TextEditingController userNameCtlr = TextEditingController();
  TextEditingController numberCtlr = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      width: width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage("asset/img.png"))),
      child: Column(children: [
        SizedBox(
          height: hight * .1,
        ),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [
                Color.fromARGB(255, 122, 132, 173),
                Color.fromARGB(255, 104, 118, 174),
                Color.fromARGB(255, 104, 118, 174),
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds);
          },
          child: Text(
            "Tramper",
            style: GoogleFonts.marcellusSc(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: HexColor("#3B8DDE")),
          ),
        ),
        Text(
          "Travel Far, Connect Close",
          style: GoogleFonts.niramit(
              fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(
          height: hight * .2,
        ),
        Expanded(
          child: Container(
            margin:
                const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter User Nmae";
                      } else {
                        return null;
                      }
                    },
                    controller: userNameCtlr,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 0, 140, 255)),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        hintText: 'User Name'),
                  ),
                  SizedBox(
                    height: hight * .02,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your email address";
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Enter Correct Email Address";
                      } else {
                        return null;
                      }
                    },
                    controller: emailCtlr,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        hintText: 'Email'),
                  ),
                  SizedBox(
                    height: hight * .02,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter contact number";
                      } else {
                        return null;
                      }
                    },
                    controller: numberCtlr,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        hintText: 'Number'),
                  ),
                  SizedBox(
                    height: hight * .02,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      }
                      if (value.length < 6) {
                        return "Password Should Minimum 6 Digit";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordCtlr,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        hintText: 'Password'),
                  ),
                  SizedBox(
                    height: hight * .02,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (!(value == passwordCtlr.text)) {
                        return "Password  does not match";
                      } else {
                        return null;
                      }
                    },
                    controller: conforrmPasswordCtlr,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        hintText: 'Confirm Password'),
                  ),
                  SizedBox(
                    height: hight * .02,
                  ),
                  SizedBox(
                    width: width,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authInstence.sign(
                              emailCtlr.text, passwordCtlr.text, context);
                          int phonemuber = int.parse(numberCtlr.text);
                          // ignore: use_build_context_synchronously
                          await storenstence.addUserToCollectionUser(
                              authInstence.uID,
                              UserModel(
                                  userType: "USER",
                                  label: "",
                                  age: "",
                                  email: emailCtlr.text,
                                  gender: "MALE",
                                  password: passwordCtlr.text,
                                  phonenumber: phonemuber,
                                  profileimage: "",
                                  proofimage: "",
                                  userID: "${authInstence.uID}",
                                  username: userNameCtlr.text,
                                  about: "",
                                  address: "",
                                  area: "",
                                  city: "",
                                  hostingDetails: "",
                                  message: "",
                                  nickeNmae: "",
                                  pincode: "",
                                  state: ""),
                              context);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (route) => false);
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) => home()));
                        }
                      },
                      // alignment: Alignment.center,
                      // height: hight * .07,
                      // width: width,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#0E86D4"),
                        // borderRadius: BorderRadius.circular(50)),
                      ),
                      child: Text(
                        "SIGN UP",
                        style:
                            TextStyle(color: HexColor("#68BBE3"), fontSize: 22),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hight * .02,
                  ),
                  SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()));
                            },
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: 14, color: HexColor("#055C9D")),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: hight * .02,
                  ),
                  // SizedBox(
                  //   width: width,
                  //   height: 30,
                  //   child: const Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Expanded(
                  //           child: Divider(
                  //             endIndent: 20,
                  //             color: Colors.black,
                  //           ),
                  //         ),
                  //         Text("or Login with"),
                  //         Expanded(
                  //             child: Divider(
                  //           indent: 20,
                  //           color: Colors.black,
                  //         ))
                  //       ]),
                  // ),
                  // SizedBox(
                  //   height: hight * .02,
                  // ),
                  // SizedBox(
                  //   width: width,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       SizedBox(
                  //         height: 50,
                  //         width: width * .4,
                  //         child: ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //               elevation: 1, backgroundColor: Colors.white),
                  //           onPressed: () {
                  //             authInstence.signWithGoogle(
                  //               context,
                  //             );

                  //                Navigator.pushReplacement(context,
                  //             MaterialPageRoute(builder: (context) => HomePage()));
                  //           },
                  //           child: const Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               SizedBox(
                  //                   height: 20,
                  //                   width: 20,
                  //                   child: Image(
                  //                       image: NetworkImage(
                  //                           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQe81uHIllpQBPGHUyOOGdw5xOexE8sZhU1fg&usqp=CAU"))),
                  //               SizedBox(
                  //                 width: 20,
                  //               ),
                  //               Text(
                  //                 "Google",
                  //                 style: TextStyle(
                  //                     color: Colors.grey,
                  //                     fontWeight: FontWeight.w600),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 50,
                  //         width: width * .4,
                  //         child: ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //               backgroundColor: Colors.blue),
                  //           onPressed: () {},
                  //           child: const Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Icon(
                  //                 Icons.facebook,
                  //                 color: Colors.white,
                  //                 size: 30,
                  //               ),
                  //               SizedBox(
                  //                 width: 20,
                  //               ),
                  //               Text(
                  //                 "Facebook",
                  //                 style: TextStyle(
                  //                     color: Colors.white,
                  //                     fontWeight: FontWeight.w600),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // )
                ]),
              ),
            ),
          ),
        ),

        // Row(
        //   children: [
        //     Container(
        //       height: 45,
        //       width: 180,
        //       decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(12),
        //           border: Border.all(color: Colors.black)),
        //       child: Row(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.only(left: 10, right: 10),
        //             child: SizedBox(
        //                 height: 20,
        //                 width: 20,
        //                 child: Image(
        //                     image: NetworkImage(
        //                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQe81uHIllpQBPGHUyOOGdw5xOexE8sZhU1fg&usqp=CAU"))),
        //           ),
        //           Text("Sign in with Google"),
        //         ],
        //       ),
        //     ),
        //     Container(
        //       height: 45,
        //       width: 180,
        //       decoration: BoxDecoration(
        //           color: Colors.blue,
        //           borderRadius: BorderRadius.circular(12),
        //           border: Border.all(color: Colors.black)),
        //       child: Row(
        //         children: [
        //           Padding(
        //             padding:
        //                 const EdgeInsets.only(left: 5, right: 15, bottom: 10),
        //             child: SizedBox(
        //                 height: 20,
        //                 width: 20,
        //                 child: Icon(
        //                   Icons.facebook,
        //                   color: Colors.white,
        //                   size: 30,
        //                 )),
        //           ),
        //           Text("Login with Facebook"),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
      ]),
    ));
  }
  // return Scaffold(
  //   body: SizedBox(
  //     height: double.infinity,
  //     width: double.infinity,
  //     child: SingleChildScrollView(
  //       child: Column(

  //         children: [
  //           Stack(
  //             children: [
  //               Container(

  //                 height: 700,
  //                 width: double.infinity,
  //                 decoration: BoxDecoration(
  //                     image: DecorationImage(
  //                         fit: BoxFit.fill,
  //                         image: AssetImage("asset/img.png")
  //                     )
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(top: 80,left: 110),
  //                   child: Stack(

  //                     children: [
  //                       Text("Tramper",style: GoogleFonts.marcellusSc(
  //                           fontSize: 50,
  //                           fontWeight: FontWeight.bold,
  //                           color: HexColor("#3B8DDE")
  //                       ),),
  //                       Padding(
  //                         padding: const EdgeInsets.only(top: 50,left: 17),
  //                         child: Text("Travel Far, Connect Close",style: GoogleFonts.niramit(
  //                             fontSize: 13,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.white
  //                         ),),
  //                       ),

  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 285),
  //                 child: Column(
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 22,right: 22),
  //                       child: Stack(
  //                         children: [

  //                           Container(
  //                             height: 50,
  //                             width: double.infinity,

  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(50),
  //                                 border: Border.all(color: HexColor("#055C9D"))

  //                             ),

  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.only(
  //                                 left: 20
  //                             ),

  //                             child:TextFormField(
  //                               decoration: InputDecoration(

  //                                   border:InputBorder.none,

  //                                   hintText: 'User name'
  //                               ),

  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     Padding(
  //                         padding: const EdgeInsets.only(top: 10,left: 22,right: 22),
  //                         child: Stack(
  //                           children: [
  //                             Container(
  //                               height: 50,
  //                               width: double.infinity,

  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(50),
  //                                   border: Border.all(color: HexColor("#055C9D"))

  //                               ),

  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(
  //                                   left: 20
  //                               ),
  //                               child: TextFormField(
  //                                 decoration: InputDecoration(
  //                                     border:InputBorder.none,
  //                                     hintText: 'Email'
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         )
  //                     ),
  //                     Padding(
  //                         padding: const EdgeInsets.only(top: 10,left: 22,right: 22),
  //                         child: Stack(
  //                           children: [
  //                             Container(
  //                               height: 50,
  //                               width: double.infinity,

  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(50),
  //                                   border: Border.all(color: HexColor("#055C9D"))

  //                               ),

  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(
  //                                   left: 20
  //                               ),
  //                               child: TextFormField(
  //                                 decoration: InputDecoration(
  //                                     border:InputBorder.none,
  //                                     hintText: 'Number'
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         )
  //                     ),
  //                     Padding(
  //                         padding: const EdgeInsets.only(top: 10,left: 22,right: 22),
  //                         child: Stack(
  //                           children: [
  //                             Container(
  //                               height: 50,
  //                               width: double.infinity,

  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(50),
  //                                   border: Border.all(color: HexColor("#055C9D"))

  //                               ),

  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(
  //                                   left: 20
  //                               ),
  //                               child: TextFormField(
  //                                 decoration: InputDecoration(
  //                                     border:InputBorder.none,
  //                                     hintText: 'Password '
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         )
  //                     ),
  //                     Padding(
  //                         padding: const EdgeInsets.only(top: 10,left: 22,right: 22),
  //                         child: Stack(
  //                           children: [
  //                             Container(
  //                               height: 50,
  //                               width: double.infinity,

  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(50),
  //                                   border: Border.all(color: HexColor("#055C9D"))

  //                               ),

  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(
  //                                   left: 20
  //                               ),
  //                               child: TextFormField(
  //                                 decoration: InputDecoration(
  //                                     border:InputBorder.none,
  //                                     hintText: 'Confirm Password'
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         )
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(top: 30,
  //                           left: 0),
  //                       child: InkWell(
  //                         onTap: (){
  //                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>home()));
  //                         },
  //                         child: Container(
  //                           alignment: Alignment.center,
  //                           height: 55,
  //                           width: 335,
  //                           decoration: BoxDecoration(
  //                               color: HexColor("#0E86D4"),
  //                               borderRadius: BorderRadius.circular(50)
  //                           ),
  //                           child: Text("SIGN UP",style: TextStyle(color:HexColor("#68BBE3"),fontSize: 22),),
  //                         ),
  //                       ),
  //                     ),

  //                   ],
  //                 ),
  //               ),

  //               Padding(
  //                 padding: const EdgeInsets.only(top: 648,left: 160),
  //                 child: Row(
  //                   children: [
  //                     Text('Already have an account?',style: TextStyle(fontSize: 14,color: Colors.black),),
  //                     TextButton(onPressed: (){
  //                       Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
  //                     }, child: Text("LOGIN",style: TextStyle(fontSize: 14,color: HexColor("#055C9D")),)),
  //                   ],
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 690,left: 50),
  //                 child: Text("-------------------------or Login with-------------------------"),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 730
  //                     ,left: 10),
  //                 child: Row(
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(right: 10),
  //                       child: Container(
  //                         height: 45,
  //                         width: 180,
  //                         decoration: BoxDecoration(
  //                             color: Colors.blue,
  //                             borderRadius: BorderRadius.circular(12),
  //                             border: Border.all(color: Colors.black)
  //                         ),
  //                         child: Row(
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.only(left: 5,right: 15,bottom: 10),
  //                               child: SizedBox(
  //                                   height: 20,
  //                                   width: 20,
  //                                   child: Icon(Icons.facebook,color: Colors.white,size: 30,)),
  //                             ),
  //                             Text("Login with Facebook"),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       height: 45,
  //                       width: 180,
  //                       decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.circular(12),
  //                           border: Border.all(color: Colors.black)
  //                       ),
  //                       child: Row(
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.only(left: 4,right: 4),
  //                             child: SizedBox(
  //                                 height: 20,
  //                                 width: 20,
  //                                 child: Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQe81uHIllpQBPGHUyOOGdw5xOexE8sZhU1fg&usqp=CAU"))),
  //                           ),
  //                           Text("Sign in with Google"),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),

  //             ],
  //           ),

  //         ],
  //       ),
  //     ),
  //   ),
  // );
}
