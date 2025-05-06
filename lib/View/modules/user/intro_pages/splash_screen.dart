import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tramber/ViewModel/check_login_preference.dart';
import 'package:tramber/ViewModel/get_locatiion.dart';


class splash_screen extends StatelessWidget {
  const splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    //  print(currentUID);
    // print(authInstence.uID);
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      checkLoginStatus(context)
       .then((value) =>
      Provider.of<LocationPrvider>(context, listen: false)
          .getCurrentLocation());
    });

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Text(
          "Tramper",
          style: GoogleFonts.inter(
              fontSize: 60,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
        ),
      ),
    );
  }
}
