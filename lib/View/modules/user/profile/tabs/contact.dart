import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class contact extends StatefulWidget {
  dynamic obj;
  contact({super.key, required this.obj});

  @override
  State<contact> createState() => _contactState();
}

class _contactState extends State<contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.phone,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 13, left: 3),
                        child: Text(
                          "Contact",
                          style: GoogleFonts.niramit(
                              fontWeight: FontWeight.w700, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                      "${widget.obj.userModel?.phonenumber}" ?? "not found",
                      style: GoogleFonts.niramit(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.chat_bubble_outline_outlined,
                          size: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 13, left: 3),
                          child: Text(
                            "Chat",
                            style: GoogleFonts.niramit(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Text(
                        "${widget.obj.userModel?.phonenumber}" ?? "not found",
                        style: GoogleFonts.niramit(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.mail_outline_outlined,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 13, left: 3),
                        child: Text(
                          "Mail",
                          style: GoogleFonts.niramit(
                              fontWeight: FontWeight.w700, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                      "${widget.obj.userModel?.email}",
                      style: GoogleFonts.niramit(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
