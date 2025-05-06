import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tramber/View/modules/admin/homepage_admin.dart';
import 'package:tramber/View/modules/user/intro_pages/get_start.dart';
import 'package:tramber/utils/variables.dart';

checkLoginStatus(context) async {
  bool isLoggedIn = await getLoggedPrefer();
  if (isLoggedIn == true) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    if (uid == adminUid) {
      return await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePageAdmin()),
          (route) => false);
    }
    await storenstence.getloginUSer(uid, context);
  } else {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => intro1()));
  }
}

Future<bool> getLoggedPrefer() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

void setLoginPrefertrue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  getLoggedPrefer();
}

void setLoginPreferfalse() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);
  getLoggedPrefer();
}
