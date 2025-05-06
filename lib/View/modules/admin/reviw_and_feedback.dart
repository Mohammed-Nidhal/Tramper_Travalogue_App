import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/ViewModel/firestore.dart';

class ReviewAndFeedback extends StatelessWidget {
  const ReviewAndFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Review & Feedback",
          style: GoogleFonts.poppins(fontSize: 30),
        ),
      ),
      body: Consumer<Firestore>(builder: (context, firestore, child) {
        final list = firestore.allRevieList;
        return SizedBox(
          height: height,
          width: width,
          child: ListView.builder(
            itemBuilder: (context, index) {
              // return Container(
              //   margin: EdgeInsets.all(20),
              //   height: height * .2,
              //   width: width,
              //   child: Row(
              //     children: [
              //       Container(
              //         color: Colors.amber,
              //         height: height * .15,
              //         width: width / 2,
              //       ),
              //       Column(
              //         children: [
              //           Text("username"),
              //           SizedBox(
              //               height: height * .10,
              //               width: height * .10,
              //               child: Image(
              //                 image: imageNotFound,
              //                 fit: BoxFit.fill,
              //               )),
              //         ],
              //       )
              //     ],
              //   ),
              // );
              return ListTile(
                leading: Text("${index + 1}"),
                title: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(83, 80, 142, 192),
                      borderRadius: BorderRadius.circular(20)),
                  height: height * .1,
                  width: width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(list[index].hosterId ?? "ID NOT PROVIDED"),
                      Text(
                        list[index].message,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                trailing: Text(list[index].date,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400)),
              );
            },
            itemCount: list.length,
          ),
        );
      }),
    );
  }
}
