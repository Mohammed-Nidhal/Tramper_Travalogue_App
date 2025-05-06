import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tramber/Model/bucketlist_model.dart';
import 'package:tramber/Model/hotel_model.dart';
import 'package:tramber/Model/place_model.dart';
import 'package:tramber/Model/popularplacemodel.dart';
import 'package:tramber/Model/restaurent_model.dart';
import 'package:tramber/Model/review_feedback_model.dart';
import 'package:tramber/Model/user_model.dart';

import 'package:tramber/View/modules/user/home.dart';
import 'package:tramber/ViewModel/firebase_auths.dart';

class Firestore with ChangeNotifier {
  UserModel? userModel;
  List<UserModel> userAllList = [];
  UserModel? hosterModel;

  List<UserModel> hosterAllList = [];
  List<UserModel> hostFemaleList = [];
  List<UserModel> hostMaleList = [];
  List<PlaceModel> placeList = [];
  List<HotelModel> hotelsList = [];
  List<RestaurentModel> restaurentList = [];
  // List<PlaceModel> topCategoryList = [];
  // List<PlaceModel> adventuresList = [];
  // List<PlaceModel> familyDestinationList = [];
  // List<PlaceModel> allPlaces = [];
  List<UserModel> selctedPlaceHosterList = [];
  List<BucketListModel> bucketList = [];
  List<ReviewFeedbackModel> allRevieList = [];
  final db = FirebaseFirestore.instance;

////*********************************************************************************** */
  getloginUSer(loginId, context) async {
    fetchCurrentUser;
    notifyListeners();

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => home()));
  }

//**************************USER***************************************************************//

  //---------------D E S T I N A T I O N
  Future fetchDestination() async {
    await _fetchFamilyDestination().then((value) async {
      await _fetchTopCategory().then((value) async {
        await _fetchAdventure();
      });
    });
  }

///////////////////////////////////
  Future fetchDatas(lginId) async {
    // await _fethcAllDestinaton();

    await fetchCurrentUser(lginId);
    // notifyListeners();
  }

  //////////////////////////////add user/////////////////////
  Future<void> addUserToCollectionUser(
      uid, UserModel userModel, context) async {
    try {
      final userRef = db.collection("user");
      final docs = userRef.doc(uid);
      await docs.set(userModel.toJson());
      print("----------------added user-----------------");
    } catch (e) {
      return customeShowDiolog("$e", context);
    }
  }

//-----------------C O U C H I N G
  fetchAllHoster() async {
    QuerySnapshot<Map<String, dynamic>> usersSnapshot = await db
        .collection("user")
        .where("userType", isEqualTo: "HOSTER")
        .get();
    hosterAllList = usersSnapshot.docs.map((doc) {
      return UserModel.fromJson(doc.data());
    }).toList();
    // notifyListeners();
  }

  fetchMaleHosters() async {
    // final collection = db.collection("user");
    // QuerySnapshot<Map<String, dynamic>> maleSnapshot =
    //     await collection.where("gender", isEqualTo: "MALE").get();

    // hostMaleList = maleSnapshot.docs.map((e) {
    //   return UserModel.fromJson(e.data());
    // }).toList();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    print(hostFemaleList.length);
    final hosters =
        db.collection("user").where("userType", isEqualTo: "HOSTER");
    print("hh");
    final male = hosters.where("gender", isEqualTo: "MALE");
    print("gg");
    QuerySnapshot<Map<String, dynamic>> maleSnapshot =
        await male.where("userID", isNotEqualTo: uid).get();

    hostMaleList = maleSnapshot.docs.map((e) {
      return UserModel.fromJson(e.data());
    }).toList();
  }

  fetchFemalHosters() async {
    final hosters =
        db.collection("user").where("userType", isEqualTo: "HOSTER");
    final female = hosters.where("gender", isEqualTo: "FEMALE");
    QuerySnapshot<Map<String, dynamic>> femaleSnapshot = await female
        .where("userID", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    // final collection = db.collection("user");
    // QuerySnapshot<Map<String, dynamic>> femaleSnapshot =
    //     await collection.where("gender", isEqualTo: "FENALE").get();

    hostFemaleList = femaleSnapshot.docs.map((e) {
      return UserModel.fromJson(e.data());
    }).toList();
  }

  List<UserModel> hostVerifiedList = [];
  fetchVerifiedHosters() async {
    final hosters =
        db.collection("user").where("userType", isEqualTo: "HOSTER");
    final profUploaded = hosters.where("proofimage", isNotEqualTo: null);
    QuerySnapshot<Map<String, dynamic>> verifiedSnapshot = await profUploaded
        .where("userID", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    // final collection = db.collection("user");
    // QuerySnapshot<Map<String, dynamic>> verifiedSnapshot =
    //     await collection.where("profileimage", isNotEqualTo: "").get();
    hostVerifiedList = verifiedSnapshot.docs.map((e) {
      return UserModel.fromJson(e.data());
    }).toList();

    print(hostVerifiedList.length);
  }

  fetchSelectedHoster(hosterID) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await db.collection("user").doc(hosterID).get();
    if (userSnapshot.exists) {
      hosterModel = UserModel.fromJson(userSnapshot.data()!);
      // notifyListeners();
    }
  }

//////////////////////////////bucketList//////////////////////////////////////////////
  Future addtoBucketList(
      currentUser, BucketListModel bucketListModel, placeId) async {
    final userCollection = db.collection("user");
    final docs =
        userCollection.doc(currentUser).collection("Bucket List").doc(placeId);
    await docs.set(bucketListModel.toJson(docs.id));
  }

  Future fetchAllBucketList(currentUID) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("user")
        .doc(currentUID)
        .collection("Bucket List")
        .get();
    bucketList = snapshot.docs.map((doc) {
      return BucketListModel.fromJson(doc.data());
    }).toList();
  }

  removeFromBucketList(curretUID, selectedBucket) async {
    await db
        .collection("user")
        .doc(curretUID)
        .collection("Bucket List")
        .doc(selectedBucket)
        .delete();

    notifyListeners();
  }
/////////////////////////fetch current User///////////////////////////////

  Future fetchCurrentUser(logiId) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await db.collection("user").doc(logiId).get();
    if (userSnapshot.exists) {
      userModel = UserModel.fromJson(userSnapshot.data()!);
      // notifyListeners();
      print(userSnapshot.data()!);
      print("--------fetchd user------");
    }
  }

  updateUSerDAta(userID, UserModel userModel, context) async {
    final userRef = db.collection("user");
    final docs = userRef.doc(userID);
    await docs.update(userModel.toJson());
    notifyListeners();
    await getloginUSer(userID, context);
  }

  ////////////////////////plca page////////////////////
  // Future fetchAllHotelAndRestaurentsSelectedPlace(
  //     placeID, selectedPlace) async {

  //   await _fetchSelectedPlaceHosters(selectedPlace);
  //   // await fetchAllRestaurentFromSelectedPlace(placeID);
  //   // await fetchAllHotelFromSelectedPlace(placeID);
  // }
  fetchSelectedPlaceHosters(selectedPlace) async {
    final collection = db.collection("user");

    final samecity = collection.where("city", isEqualTo: selectedPlace);
    QuerySnapshot<Map<String, dynamic>> snapshot = await samecity
        .where("userID", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    selctedPlaceHosterList = snapshot.docs.map((e) {
      return UserModel.fromJson(e.data());
    }).toList();
  }

  Future fetchResturentInSelectedPlace(placeID) async {
    QuerySnapshot<Map<String, dynamic>> restSnapshot = await db
        .collection("Places")
        .doc(placeID)
        .collection("Restaurent")
        .get();
    restaurentList = restSnapshot.docs.map((e) {
      return RestaurentModel.fromJson(e.data());
    }).toList();
  }

  Future fetchHotelsInSelectedPlace(placeID) async {
    QuerySnapshot<Map<String, dynamic>> hotelSnapshot =
        await db.collection("Places").doc(placeID).collection("Hotels").get();
    hotelsList = hotelSnapshot.docs.map((e) {
      return HotelModel.fromJson(e.data());
    }).toList();
  }

  HotelModel? selectedhotel;
  fetchSelectedHotelDetails(placeid, hotelId) async {
    DocumentSnapshot<Map<String, dynamic>> hotelSnapshot = await db
        .collection("Places")
        .doc(placeid)
        .collection("Hotels")
        .doc(hotelId)
        .get();

    if (hotelSnapshot.exists) {
      selectedhotel = HotelModel.fromJson(hotelSnapshot.data()!);
    }
  }

  RestaurentModel? selectedRestaurent;
  fetchSelectedRestaurentDetails(placeid, restId) async {
    DocumentSnapshot<Map<String, dynamic>> restSnapshot = await db
        .collection("Places")
        .doc(placeid)
        .collection("Restaurent")
        .doc(restId)
        .get();

    if (restSnapshot.exists) {
      selectedRestaurent = RestaurentModel.fromJson(restSnapshot.data()!);
    }
  }

  ////////////////////////////////////////////
  List<PlaceModel> topCategoryList = [];
  Future _fetchTopCategory() async {
    final collection = db.collection("Places");
    QuerySnapshot<Map<String, dynamic>> placeSnapshot =
        await collection.where("category", isEqualTo: "TOP CATEGORY").get();
    topCategoryList = placeSnapshot.docs.map((e) {
      return PlaceModel.fromJson(e.data());
    }).toList();
    // notifyListeners();
  }

  List<PlaceModel> adventuresList = [];
  Future _fetchAdventure() async {
    final collection = db.collection("Places");
    QuerySnapshot<Map<String, dynamic>> placeSnapshot =
        await collection.where("category", isEqualTo: "ADVENTURES").get();
    adventuresList = placeSnapshot.docs.map((e) {
      return PlaceModel.fromJson(e.data());
    }).toList();
    // notifyListeners();
  }

  List<PlaceModel> familyDestinationList = [];
  Future _fetchFamilyDestination() async {
    final collection = db.collection("Places");
    QuerySnapshot<Map<String, dynamic>> placeSnapshot = await collection
        .where("category", isEqualTo: "FAMILY DESTINATION")
        .get();
    familyDestinationList = placeSnapshot.docs.map((e) {
      return PlaceModel.fromJson(e.data());
    }).toList();
    // notifyListeners();
  }

  // _fethcAllDestinaton() async {
  //   final collection = db.collection("Places");
  //   QuerySnapshot<Map<String, dynamic>> placeSnapshot = await collection.get();
  //   allPlaces = placeSnapshot.docs.map((e) {
  //     return PlaceModel.fromJson(e.data());
  //   }).toList();
  //   // notifyListeners();
  // }

  ///////////////////////////////////////////////

  sendFeedBacktoAdmin(ReviewFeedbackModel reviewFeedbackModel, currentUID) {
    final doc = db.collection("Rview&Feedback").doc();
    doc.set(reviewFeedbackModel.toJson(currentUID));
  }

//**************************************************ADMIN************************************************** */

  fetchDataForAdmin() async {
    await fetchAllUsers();
    await fetchAllPlaces();
    await fetchAllReviews();
    // notifyListeners();
  }

  deleteUser(doc) {
    db.collection("user").doc(doc).delete();
    notifyListeners();
  }

  ////////////////////////////////restaurent////////////////////
  addRestaurent(selectedplaceId, RestaurentModel restaurentModel) {
    final restaurentDocs = db
        .collection("Places")
        .doc(selectedplaceId)
        .collection("Restaurent")
        .doc();
    restaurentDocs.set(restaurentModel.toJson(restaurentDocs.id));
    notifyListeners();
  }

  fetchAllRestaurentFromSelectedPlace(placeId) async {
    QuerySnapshot<Map<String, dynamic>> restSnapshot = await db
        .collection("Places")
        .doc(placeId)
        .collection("Restaurent")
        .get();
    restaurentList = restSnapshot.docs.map((e) {
      return RestaurentModel.fromJson(e.data());
    }).toList();
    // notifyListeners();
  }

  ///////////////////////HOTELS///////////////////////////////
  Future addHotels(selectedplaceId, HotelModel hotelModel) async {
    final hotelDocs =
        db.collection("Places").doc(selectedplaceId).collection("Hotels").doc();
    await hotelDocs.set(hotelModel.toJson(hotelDocs.id));
    notifyListeners();
  }

  fetchAllHotelFromSelectedPlace(placeId) async {
    print("<<<<<<<<<<<<<<<<<<<<<<object>>>>>>>>>>>>>>>>>>>>>>");
    QuerySnapshot<Map<String, dynamic>> hotelSnapshot =
        await db.collection("Places").doc(placeId).collection("Hotels").get();
    print(hotelSnapshot.docs.length);

    hotelsList = hotelSnapshot.docs.map((e) {
      return HotelModel.fromJson(e.data());
    }).toList();
    print(hotelsList.length); // notifyListeners();
  }

  ///////////////////POPULAR PLACE///////////////////////
  addPopularPlace(selectedplaceId, AddPopularPlace addPopularPlace) {
    final placedoc = db
        .collection("Places")
        .doc(selectedplaceId)
        .collection("Popular")
        .doc();
    placedoc.set(addPopularPlace.toJson(placedoc.id));
    notifyListeners();
  }

  List<AddPopularPlace> popularList = [];
  fetchAllpopPlacesFromSelectedPlace(placeId) async {
    QuerySnapshot<Map<String, dynamic>> popSnap =
        await db.collection("Places").doc(placeId).collection("Popular").get();
    popularList = popSnap.docs.map((e) {
      return AddPopularPlace.fromjson(e.data());
    }).toList();
    // notifyListeners();
  }

  ///////////////////add place IMAGE////////////////////////
  addPlaceDetailsToFirestore(PlaceModel placeModel) async {
    final docs = db.collection("Places").doc();
    await docs.set(placeModel.toJson(docs.id));
    print("*****************image added****************");
  }

  fetchAllPlaces() async {
    QuerySnapshot<Map<String, dynamic>> placeSnapshot =
        await db.collection("Places").get();
    placeList = placeSnapshot.docs.map((doc) {
      return PlaceModel.fromJson(doc.data());
    }).toList();
    // notifyListeners();
    // _fetchSorteduser();
  }

  deletePlacefromFirestore(selectedPlace) async {
    CollectionReference hotelRef =
        db.collection("Places").doc(selectedPlace).collection("Hotels");
    CollectionReference restaurentRef =
        db.collection("Places").doc(selectedPlace).collection("Restaurent");

    await _deleteCollection(hotelRef);
    await _deleteCollection(restaurentRef);
    await db.collection("Places").doc(selectedPlace).delete().then((value) {
      notifyListeners();
    });
    // notifyListeners();
  }

  Future<void> _deleteCollection(
      CollectionReference collectionReference) async {
    final QuerySnapshot snapshot = await collectionReference.get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
    notifyListeners();
  }

  //////////////////fetchAllUSer///////////////////////////////////

  fetchAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> usersSnapshot =
        await db.collection("user").get();
    userAllList = usersSnapshot.docs.map((doc) {
      return UserModel.fromJson(doc.data());
    }).toList();
    // notifyListeners();
  }

  fetchAllReviews() async {
    QuerySnapshot<Map<String, dynamic>> reviewSnapshot =
        await db.collection("Rview&Feedback").get();
    allRevieList = reviewSnapshot.docs.map((doc) {
      return ReviewFeedbackModel.fromJson(doc.data());
    }).toList();
    // notifyListeners();
  }

  // updateIsLikedTrue(selectedPlaceID) async {
  //   db.collection("Places").doc(selectedPlaceID).update({"isLiked": true});
  //   notifyListeners();
  // }

  // updateIsLikedFalse(selectedPlaceID) async {
  //   db.collection("Places").doc(selectedPlaceID).update({"isLiked": false});
  //   notifyListeners();
  // }
  String? type;
  String? gender;
  fetchCurrentUserType() async {
    final doc = await db
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (doc.exists) {
      final data = doc.data();
      type = data!["userType"];
      gender = data["gender"];
      print(type);
    }
  }

  editUserType(newType) async {
    final doc = await db
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"userType": newType});
    // notifyListeners();
  }

  editUserGender(newGender) async {
    final doc = await db
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"gender": newGender});
    // notifyListeners();
  }

  bool? isLiked;
  Future<bool> checkThePlaceisInTheBucketList(
    placeId,
  ) async {
    final snap = await db
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Bucket List")
        .doc(placeId)
        .get();
    if (snap.exists) {
      isLiked = true;
      return true;
    } else {
      isLiked = false;
      return false;
    }
  }

  getTheNewvalue() {
    isLiked;
    notifyListeners();
  }
}
