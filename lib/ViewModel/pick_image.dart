import 'dart:io';
import 'dart:async' show Future;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tramber/ViewModel/firestore.dart';
import 'package:tramber/utils/variables.dart';

File? imageFileProfile;
File? imageFileProof;
File? imageFilePlace;
File? imageFilePopular;
List<File> imageFilePreviewList = [];

final db = FirebaseFirestore.instance;
final firbaseStorage = FirebaseStorage.instance;

///////////////////////////////////////////////////////////////
Future<void> selectImage(context, int selected) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  DocumentReference profileRef =
      db.collection('user').doc(FirebaseAuth.instance.currentUser!.uid);

  SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');

  if (pickedFile != null) {
    if (selected == 1) {
      imageFileProfile = File(pickedFile.path);

      UploadTask uploadTask = firbaseStorage
          .ref()
          .child("userimage/$currentUID")
          .putFile(imageFileProfile!, metadata);
      TaskSnapshot snapshot = await uploadTask;

      await snapshot.ref.getDownloadURL().then((url) {
        profileRef.update({"profileimage": url});
      });

      Provider.of<Firestore>(context, listen: false)
          .fetchCurrentUser(FirebaseAuth.instance.currentUser!.uid);
    } else if (selected == 2) {
      imageFileProof = File(pickedFile.path);
      UploadTask uploadTask = firbaseStorage
          .ref()
          .child("userProof/$currentUID")
          .putFile(imageFileProof!, metadata);
      TaskSnapshot snapshot = await uploadTask;

      await snapshot.ref.getDownloadURL().then((proofURL) {
        profileRef.update({"proofimage": proofURL});
      });

      Provider.of<Firestore>(context, listen: false)
          .fetchCurrentUser(FirebaseAuth.instance.currentUser!.uid);
    }
  }
}

Future addPlaceImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
  if (pickedFile != null) {
    final currenttime = TimeOfDay.now();
    imageFilePlace = File(pickedFile.path);
    UploadTask uploadTask = firbaseStorage
        .ref()
        .child("placeImage/Admin$currenttime")
        .putFile(imageFilePlace!, metadata);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
    // final doc = db.collection("placeimage").doc();

    // next add image to firestore
  }
}

Future addHotelImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
  if (pickedFile != null) {
    final currenttime = TimeOfDay.now();
    imageFilePlace = File(pickedFile.path);
    UploadTask uploadTask = firbaseStorage
        .ref()
        .child("HotelImage/Admin$currenttime")
        .putFile(imageFilePlace!, metadata);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
    // final doc = db.collection("placeimage").doc();

    // next add image to firestore
  }
}

List<String> imageUrl = [];
Future<List<String>> addPreviewImages() async {
  imageUrl = [];
  imageFilePreviewList = [];
  final picker = ImagePicker();
  final pickedFile = await picker.pickMultiImage();
  SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
  pickedFile.map((e) {
    return imageFilePreviewList.add(File(e.path));
  }).toList();

  if (imageFilePreviewList.isNotEmpty) {
    for (var file in imageFilePreviewList) {
      final currenttime = DateTime.now();
      // UploadTask uploadTask =
      firbaseStorage
          .ref()
          .child("PreviewImages/Admin${currenttime.microsecond}")
          .putFile(file, metadata)
          .then((uploadTask) {
        TaskSnapshot snapshot = uploadTask;
        snapshot.ref.getDownloadURL().then((value) {
          imageUrl.add(value);
        });
      });

//         TaskSnapshot snapshot = await uploadTask;
//
    }
  }
  return imageUrl;
  // next add image to firestore
  return imageUrl;
}

Future addRestaurentImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
  if (pickedFile != null) {
    final currenttime = TimeOfDay.now();
    imageFilePlace = File(pickedFile.path);
    UploadTask uploadTask = firbaseStorage
        .ref()
        .child("RestaurentImage/Admin$currenttime")
        .putFile(imageFilePlace!, metadata);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
    // final doc = db.collection("placeimage").doc();

    // next add image to firestore
  }
}

Future addPopularPlaceImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
  if (pickedFile != null) {
    final currenttime = TimeOfDay.now();
    imageFilePopular = File(pickedFile.path);
    UploadTask uploadTask = firbaseStorage
        .ref()
        .child("PopularPlaceImage/Admin$currenttime")
        .putFile(imageFilePopular!, metadata);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
    // final doc = db.collection("placeimage").doc();

    // next add image to firestore
  }
}
