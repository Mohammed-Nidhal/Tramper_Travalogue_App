import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tramber/View/modules/admin/homepage_admin.dart';
import 'package:tramber/View/modules/user/home.dart';
import 'package:tramber/ViewModel/check_login_preference.dart';
import 'package:tramber/utils/variables.dart';

class FirebaseAuths {
  FirebaseAuth auth = FirebaseAuth.instance;

  dynamic uID;

  sign(
    email,
    password,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      uID = userCredential.user!.uid;
      setLoginPrefertrue();
      print("*********************$uID**********************");
    } catch (e) {
      customeShowDiolog("$e", context);
    }
  }

  emailVarification(
    context,
  ) async {
    try {
      if (FirebaseAuth.instance.currentUser != null &&
          !FirebaseAuth.instance.currentUser!.emailVerified) {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification().then(
            (value) => customeShowDiolog(
                "Varification email Send to your registered email address ${FirebaseAuth.instance.currentUser!.email} ",
                context));
      }
    } catch (e) {
      customeShowDiolog("$e", context);
    }
  }

  login(email, password, context, selected) async {
    try {
      currentUID = await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        setLoginPrefertrue();
        if (selected == 0) {
          return await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePageAdmin()),
              (route) => false);
        } else if (selected == 1) {
          return await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        }
      });
    } catch (e) {
      customeShowDiolog("$e", context);
    }
  }
///////////////////////////////////////////////////////////////////////////////////////

  // Future signWithGoogle(
  //   context,
  // ) async {
  //   try {
  //     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication? gAuth = await gUser?.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //         accessToken: gAuth?.accessToken, idToken: gAuth?.idToken);

  //     await auth
  //         .signInWithCredential(credential)
  //         // return await auth.signInWithCredential(credential)
  //         .then((value) async {
  //       await storenstence.addUserToCollectionUser(
  //           value.user?.uid,
  //           UserModel(
  //             userType: "USER",
  //               label: "",
  //               age: "",
  //               email: "${gUser?.email}",
  //               gender: "",
  //               password: "",
  //               phonenumber: 0,
  //               profileimage: "${gUser?.photoUrl}",
  //               proofimage: "",
  //               userID: "${value.user?.uid}",
  //               username: "${gUser?.displayName}",
  //               about: "",
  //               address: "",
  //               area: "",
  //               city: "",
  //               hostingDetails: "",
  //               message: "",
  //               nickeNmae: "",
  //               pincode: "",
  //               state: ""),
  //           context);

  //       setLoginPrefertrue();
  //       return await Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => HomePage()));
  //     });
  //   } catch (e) {
  //     return customeShowDiolog("$e", context);
  //   }
  // }

  Future signInWithFacebook(context, page) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success &&
          loginResult.accessToken != null) {
        final String token =
            loginResult.accessToken!.toString(); // Ensure this is correct

        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(token);

        return FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential)
            .then((value) async {
          setLoginPrefertrue();
          return await Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      } else {
        return customeShowDiolog(
          "Facebook login failed: ${loginResult.message}",
          context,
        );
      }
    } catch (e) {
      return customeShowDiolog("$e", context);
    }
  }

  ///////////////////SIGNOUT//////////////////////////////////////
  ///
  ///

  Future signOut(
    context,
  ) async {
    setLoginPreferfalse();
    currentUID = null;
    uID = null;
    await signOutFromMAil(context);
    await signoutFromGoogle(
      context,
    );
    print(currentUID);
    print(uID);
  }

/////////////////////////////////////////////
  signOutFromMAil(context) async {
    await FirebaseAuth.instance.signOut();
  }

  signoutFromGoogle(context) async {
    await GoogleSignIn().signOut();
  }
}

customeShowDiolog(String title, BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      content: Text(title),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"))
      ],
    ),
  );
}
// void noti(msg) {
//   Fluttertoast.showToast(
//     msg: msg,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.CENTER,
//     timeInSecForIosWeb: 1,
//     backgroundColor: Colors.grey.shade200,
//     textColor: Colors.black,
//     fontSize: 20.0,
//   );
// }
