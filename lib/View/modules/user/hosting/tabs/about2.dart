import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tramber/Model/user_model.dart';

class about2 extends StatefulWidget {
  UserModel data;
  about2({super.key, required this.data});

  @override
  State<about2> createState() => _about2State();
}

class _about2State extends State<about2> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.gender == "" ? "no data" : widget.data.gender,
            style:
                GoogleFonts.niramit(fontWeight: FontWeight.w400, fontSize: 20),
          ),
          Text(
            widget.data.label == "" ? "no data" : widget.data.label,
            style:
                GoogleFonts.niramit(fontWeight: FontWeight.w400, fontSize: 20),
          ),
          Text(
            widget.data.city == "" ? "no data" : widget.data.city,
            style:
                GoogleFonts.niramit(fontWeight: FontWeight.w400, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 30),
            child: Container(
              height: MediaQuery.of(context).size.height * .2,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(0, 71, 255, 0.28),
                        Color.fromRGBO(192, 194, 244, 0.16),
                        Color.fromRGBO(255, 255, 255, 0),
                      ]),
                  border: Border.all(color: HexColor("#055C9D"))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.data.about,
                  style: GoogleFonts.niramit(fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
