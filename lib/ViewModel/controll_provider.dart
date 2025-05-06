import 'package:flutter/material.dart';

class Controller with ChangeNotifier {
  var cetegory;
  onchanged(value) {
    cetegory = value;
    notifyListeners();
  }

  bool isImageLoading = false;

  imageIsLoading(value) {
    isImageLoading = value;
    notifyListeners();
  }

  // bool isPlaceSave = false;
  // isplaceSvae() {
  //   isPlaceSave = !isPlaceSave;
  //   notifyListeners();
  // }
}
