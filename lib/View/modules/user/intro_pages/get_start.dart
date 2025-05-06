import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tramber/View/modules/user/intro_pages/page_view.dart';

class intro1 extends StatefulWidget {
  const intro1({super.key});

  @override
  State<intro1> createState() => _intro1State();
}

class _intro1State extends State<intro1> {
  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: hight,
        width: width,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://media.istockphoto.com/id/492673612/photo/travel.jpg?s=612x612&w=0&k=20&c=gYc3-FCt-2q627yXZDBAbeYDiy3RHSow_WyeO4pRfgM=",
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 240, left: 140),
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(80)),
                  ),
                )
              ],
            ),
            Text(
              "TRAMPER",
              style: GoogleFonts.marcellusSc(
                  fontSize: 60,
                  color: Color.fromARGB(255, 60, 60, 60),
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal),
            ),
            const Text(
              "Travel Far, Connect Close",
              style: TextStyle(
                  color: Color.fromARGB(255, 60, 60, 60), fontSize: 19),
            ),
            const SizedBox(
              height: 220,
            ),
            Expanded(
              child: SizedBox(),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => page_view()));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                alignment: Alignment.center,
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50)),
                child: const Text(
                  "Get Started for Free",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
