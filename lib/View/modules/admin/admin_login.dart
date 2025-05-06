import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tramber/utils/variables.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({super.key});

  @override
  State<LoginAdmin> createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  String email = "admin@gmail.com";
  String password = "123456";
 
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
                      if (value != email) {
                        return "The email is not valid user";
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
                      // if (value != password) {
                      //   return "password does not matching";
                      // }
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
                          authInstence.login(emailController.text,
                              passwordController.text, context,0);
                          // if (emailController.text == email &&
                          //     passwordController.text == password) {
                          //   setLoginPrefertrue();
                          //   Navigator.pushAndRemoveUntil(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => HomePageAdmin()),
                          //       (route) => false);
                          // }
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
                ]),
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}
