import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class NavbarValueProvider with ChangeNotifier {

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) async {
    _currentIndex = index;
    notifyListeners();
  }

}