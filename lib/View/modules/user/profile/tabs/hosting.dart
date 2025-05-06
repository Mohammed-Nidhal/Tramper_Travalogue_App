import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Hosting extends StatefulWidget {
  dynamic obj;
  Hosting({super.key, required this.obj});

  @override
  State<Hosting> createState() => _HostingState();
}

class _HostingState extends State<Hosting> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Container(
          height: height * .3,
          width: width * .8,
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Color.fromRGBO(104, 187, 227, 0.91)),
                right: BorderSide(
                  color: Color.fromRGBO(104, 187, 227, 0.91),
                ),
                bottom: BorderSide(color: Color.fromRGBO(104, 187, 227, 0.91)),
                left: BorderSide(color: Colors.transparent)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 30, bottom: 30),
            child: Text(
              "${widget.obj.userModel?.hostingDetails}",
              style: GoogleFonts.niramit(fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
