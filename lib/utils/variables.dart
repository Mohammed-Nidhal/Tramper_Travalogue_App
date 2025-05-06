import 'package:firebase_auth/firebase_auth.dart';
import 'package:tramber/ViewModel/button_state.dart';
import 'package:tramber/ViewModel/firebase_auths.dart';
import 'package:tramber/ViewModel/firestore.dart';
import 'package:tramber/ViewModel/get_locatiion.dart';

FirebaseAuths authInstence = FirebaseAuths();
Firestore storenstence = Firestore();
dynamic currentUID = FirebaseAuth.instance.currentUser!.uid;
LocationPrvider locationInstence = LocationPrvider();

 ButtonState buttonState = ButtonState.defaultvalue;
  String adminUid = "VJ6BPG1Sn7WBp6AFh7g5Ogdr8rR2";