import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/user/drop_menu/bucket_list.dart';
import 'package:tramber/View/modules/user/home.dart';
import 'package:tramber/View/modules/user/intro_pages/splash_screen.dart';
import 'package:tramber/View/modules/user/profile/tabs/about.dart';
import 'package:tramber/View/modules/user/profile/tabs/contact.dart';
import 'package:tramber/View/modules/user/profile/tabs/hosting.dart';
import 'package:tramber/View/modules/user/profile/update_profile.dart';
import 'package:tramber/ViewModel/firestore.dart';

import 'package:tramber/utils/image.dart';
import 'package:tramber/utils/variables.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  int current = 0;
  // List of tab bar items

  List<Map<String, dynamic>> items = [
    {
      'name': 'About',
    },
    {
      'name': 'Hosting details',
    },
    {
      'name': 'Contact',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Firestore>(builder: (context, firestore, child) {
      List<Widget> pages = [
        about(
          obj: firestore,
        ),
        Hosting(
          obj: firestore,
        ),
        contact(obj: firestore),
      ];
      return Scaffold(
        body: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      height: 290,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("asset/img_6.png"))),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 335, top: 50),
                            child: PopupMenuButton(
                              icon: const Icon(CupertinoIcons
                                  .list_dash), //don't specify icon if you want 3 dot menu
                              color: HexColor("#055C9D"),
                              itemBuilder: (context) => [
                                PopupMenuItem<int>(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()));
                                  },
                                  value: 0,
                                  child: Text(
                                    "Home",
                                    style: GoogleFonts.niramit(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                PopupMenuItem<int>(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BucketList()));
                                  },
                                  value: 1,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Bucket List    ",
                                        style: GoogleFonts.niramit(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Icon(
                                        CupertinoIcons.bookmark,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    ],
                                  ),
                                ),
                                // PopupMenuItem<int>(
                                //     onTap: () {
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (context) => AddPlace()));
                                //     },
                                //     value: 2,
                                //     child: Text(
                                //       "Add a Place",
                                //       style: GoogleFonts.niramit(
                                //         color: Colors.white,
                                //         fontSize: 16,
                                //       ),
                                //     )),
                                PopupMenuItem<int>(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    },
                                    value: 3,
                                    child: Text(
                                      "Help",
                                      style: GoogleFonts.niramit(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    )),
                              ],
                              onSelected: (item) => {print(item)},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: Center(
                              child: ShaderMask(
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
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 145, top: 200),
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: firestore.userModel!.profileimage.isEmpty 
                                ? imageNotFound
                                : NetworkImage(
                                    "${firestore.userModel?.profileimage}")),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  )
                ],
              ),
              Text(
                "${firestore.userModel?.username}",
                style: GoogleFonts.niramit(
                    fontSize: 28, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: firestore.userModel?.userType == "USER"
                        ? 1
                        : items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.all(5),
                                height: 35,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: current == index
                                      ? HexColor("#055C9D")
                                      : HexColor("#FFFFFF"),
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: HexColor("#055C9D")),
                                ),
                                duration: Duration(),
                                child: Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 5),
                                      child: Text(
                                        items[index]['name'],
                                        style: GoogleFonts.niramit(
                                            color: HexColor("#68BBE3"),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      );
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 260,
                decoration: const BoxDecoration(),
                child: pages[current],
              ),
              const Expanded(child: SizedBox()),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateProfile(
                                      obj: firestore,
                                    )));
                      },
                      child: ListTile(
                        leading: const Icon(
                          Icons.person,
                          size: 24,
                        ),
                        title: Text(
                          "Update Profile",
                          style: GoogleFonts.roboto(
                              fontSize: 19, fontWeight: FontWeight.w600),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 21,
                        ),
                      ),
                    ),
                    ListTile(
                        leading: const Icon(
                          Icons.settings,
                          size: 24,
                        ),
                        title: Text(
                          "Settings",
                          style: GoogleFonts.roboto(
                              fontSize: 19, fontWeight: FontWeight.w600),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 21,
                        )),
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => Center(
                                child: ElevatedButton(
                                  onPressed: ()async {
                                  await  authInstence.signOut(context).then(
                                        (value) => Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const splash_screen()),
                                            (route) => false));
                                  },
                                  child: const Text("Log out?"),
                                ),
                              )),
                      child: ListTile(
                          leading: const Icon(
                            Icons.logout,
                            size: 24,
                          ),
                          title: Text(
                            "Log out",
                            style: GoogleFonts.roboto(
                                fontSize: 19, fontWeight: FontWeight.w600),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 21,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
