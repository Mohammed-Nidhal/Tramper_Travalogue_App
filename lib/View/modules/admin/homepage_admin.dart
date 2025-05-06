import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/admin/place/add_place.dart';
import 'package:tramber/View/modules/admin/place/placelist.dart';
import 'package:tramber/View/modules/admin/reviw_and_feedback.dart';
import 'package:tramber/View/modules/user/intro_pages/splash_screen.dart';
import 'package:tramber/ViewModel/firestore.dart';
import 'package:tramber/utils/image.dart';
import 'package:tramber/utils/variables.dart';

class HomePageAdmin extends StatelessWidget {
  const HomePageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // Provider.of<Firestore>(context,listen: false).fetchDataForAdmin();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              color: const Color.fromARGB(255, 94, 81, 76),
              width: width / 2,
              height: height * .3,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          backgroundImage: imageNotFound,
                        ),
                      ),
                      Text(
                        "Admin",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      Text(
                        "admin@gmail.com",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ]),
              ),
            ),
            ListTile(
              title: Text(
                "Add Location",
                style: GoogleFonts.poppins(fontSize: 20),
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddPlace()));
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            ListTile(
              title: Text(
                "Explore Locations",
                style: GoogleFonts.poppins(fontSize: 20),
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlaceListPage()));
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            ListTile(
              title: Text(
                "Review & Feedback",
                style: GoogleFonts.poppins(fontSize: 20),
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReviewAndFeedback()));
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            // Expanded(child: SizedBox()),
            ListTile(
              title: Text(
                "Logout",
                style: GoogleFonts.poppins(fontSize: 20),
              ),
              trailing: IconButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await authInstence.signOut(context).then(
                                      (value) => Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const splash_screen()),
                                          (route) => false));
                                },
                                child: const Text("Log out?"),
                              ),
                            ),
                          ));

                  ListTile(
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
                      ));
                },
                icon: const Icon(Icons.logout),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "TRAMBER",
          style: GoogleFonts.poppins(fontSize: 30),
        ),
      ),
      body: Consumer<Firestore>(builder: (context, firestore, child) {
        return FutureBuilder(
            future: firestore.fetchDataForAdmin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final list = firestore.userAllList;

              return SizedBox(
                  height: height,
                  width: width,
                  child: list.isEmpty
                      ? const Center(
                          child: Text("No user found"),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: SizedBox(
                                height: 70,
                                width: 70,
                                child: CircleAvatar(
                                  backgroundImage:
                                      list[index].profileimage == ""
                                          ? imageNotFound
                                          : NetworkImage(
                                              list[index].profileimage,
                                            ),
                                ),
                              ),
                              title: Text(
                                list[index].username.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                list[index].userType,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: list[index].userType == "USER"
                                        ? Colors.blue
                                        : Colors.green),
                              ),
                              trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Confirm Delete"),
                                        content: const Text(
                                            "Make sure about deleting this user"),
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                        actions: [
                                          IconButton(
                                              onPressed: () {
                                                firestore.deleteUser(
                                                    list[index].userID);
                                              },
                                              icon: const Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.red,
                                                  size: 40))
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  "Remove",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: list.length));
            });
      }),

      // body: ,
    );
  }
}
