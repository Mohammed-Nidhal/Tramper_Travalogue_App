import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class View1 extends StatefulWidget {
  const View1({super.key});

  @override
  State<View1> createState() => _View1State();
}

class _View1State extends State<View1> {
  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: hight * .6,
            width: width,
            decoration: const BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2019/07/25/17/09/camp-4363073_640.png'))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Stack(
              children: [
                Text(
                  "Life is short and ",
                  style: GoogleFonts.marcellusSc(
                      color: Colors.black, fontSize: 40),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    "\t World is wide",
                    style: GoogleFonts.marcellusSc(
                        color: Colors.black, fontSize: 40),
                  ),
                )
              ],
            ),
          ),
          Text(
            "Tramper allows it’s users to have",
            style: GoogleFonts.niramit(color: Colors.black, fontSize: 16),
          ),
          Text(
            "a hassle free travel experience",
            style: GoogleFonts.niramit(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
