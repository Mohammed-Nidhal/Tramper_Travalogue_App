import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tramber/Model/user_model.dart';
import 'package:tramber/utils/launcher.dart';

class contact2 extends StatefulWidget {
  UserModel data;
  contact2({super.key, required this.data});

  @override
  State<contact2> createState() => _contact2State();
}

class _contact2State extends State<contact2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              call(widget.data.phonenumber);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
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
                    "${widget.data.phonenumber}",
                    style: GoogleFonts.niramit(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: InkWell(
              onTap: () {
                whatsapp(widget.data.phonenumber);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
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
                      "${widget.data.phonenumber}",
                      style: GoogleFonts.niramit(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              email(widget.data.email);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
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
                    widget.data.email,
                    style: GoogleFonts.niramit(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
