import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tramber/View/modules/user/login/sign_up.dart';

import 'package:tramber/utils/variables.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
      child: Container(
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
          Container(
            height: hight * .5,
            margin: EdgeInsets.all(40),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(children: [
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
                    controller: emailController,
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
                        return "Enter Password";
                      }
                      if (value.length < 6) {
                        return "Password Should Minimum 6 Digit";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordController,
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
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password ?",
                          style: GoogleFonts.niramit(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: HexColor("#61677A")),
                        )),
                  ),
                  SizedBox(
                    width: width,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authInstence.login(
                            emailController.text,
                            passwordController.text,
                            context,1
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#0E86D4"),
                      ),
                      child: Text(
                        "LOGIN",
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
                          'Don’t have an account?',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => sign_up()));
                            },
                            child: Text(
                              "SIGN UP",
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
                  SizedBox(
                    height: hight * .05,
                  ),
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
        ]),
      ),
    ));
  }
}
