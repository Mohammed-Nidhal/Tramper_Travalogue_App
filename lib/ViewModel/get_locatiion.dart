import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tramber/ViewModel/button_state.dart';
import 'package:tramber/utils/variables.dart';

class LocationPrvider with ChangeNotifier {
  Position? latLonposition;
  Placemark decodeData = Placemark();
  Location? locationData;
  bool isLocationFetched = false;

  double? lat;
  double? lon;
  String? place;
  String? country;

  Future<Position> _getCurrentLatLonPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String?> _getAddressFromLatLon(Position position) async {
    //this future function for getting current location when the app is open
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((placemarks) {
      decodeData = placemarks[0];
      place = decodeData.locality;
      country = decodeData.country;
    });
    isLocationFetched = false;
    notifyListeners();
    return place;
  }
/////////////////////////////////////////////////////////////////////////////////

  Future<String?> getCurrentLocation() async {
    buttonState = ButtonState.fetching;
    isLocationFetched = true;
    notifyListeners();
    latLonposition = await _getCurrentLatLonPosition();
    print("lat and loc = ${latLonposition.toString()}");
    lat = latLonposition!.latitude;
    lon = latLonposition!.longitude;
    notifyListeners();
    return _getAddressFromLatLon(latLonposition!);
  }
}
