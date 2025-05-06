import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tramber/Model/user_model.dart';

class Hosting2 extends StatefulWidget {
  UserModel data;
  Hosting2({super.key, required this.data});

  @override
  State<Hosting2> createState() => _Hosting2State();
}

class _Hosting2State extends State<Hosting2> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: height * .3,
        width: MediaQuery.of(context).size.width * .7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: HexColor("#68BBE3")),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 30, bottom: 30),
          child: widget.data.about == ""
              ?const  Center(
                  child: Text("no data"),
                )
              : Text(
                  widget.data.about,
                  style: GoogleFonts.niramit(fontSize: 12),
                ),
        ),
      ),
    );
  }
}
