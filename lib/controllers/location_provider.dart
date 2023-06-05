import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  String address = '';

  late Position startPosition;

  void setAddress(String userAddress) {
    address = userAddress;
    print(address);
    notifyListeners();
  }

  void getCurrentLocation() async {
    var startPosition = await Geolocator.getCurrentPosition();

    print(startPosition);

    notifyListeners();
  }
}
