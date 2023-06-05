import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:online_pizza/data/models/restaurant_model.dart';
import 'package:online_pizza/data/repository/user_repo.dart';
import 'package:online_pizza/services/fire_storage_service.dart';

import '../data/models/user_model.dart';
import '../data/repository/restaurant_repo.dart';

class RestaurantProvider with ChangeNotifier {
  final Firebase_Storage_Service storage_service = Firebase_Storage_Service();

  List<Restaurant> restaurants = [];
  List<Restaurant> pendingRestaurants = [];
  List<Restaurant> searchedRestaurants = [];
  String vendorID = '';
  Restaurant restaurant = Restaurant(
      restaurant_name: "",
      restaurant_address: "",
      restaurant_email: "restaurant_email",
      restaurant_website: "",
      delivery_time: "",
      delivery_cost: "",
      vendorID: "");
  bool isRestaurantAdding = false;
  bool isRestaurantsFetching = false;
  bool isFetching = false;
  bool isRestaurantSearched = false;
  bool isRestaurantFetching = false;
  bool isVendorApproving = false;
  bool isVendorRestaurantUpdated = false;
  bool isApproved = false;
  bool isVendorUnique = false;
  bool isImageUpdated = false;
  bool isRestaurantUpdated = false;

  bool imageUplaoding = false;
  final RestaurantRepo _restaurantRepo = FirebaseRestaurantsRepository();

  void addNewRestaurant(Restaurant restaurant) async {
    isRestaurantAdding = true;
    // notifyListeners();
    await _restaurantRepo.addRestaurant(restaurant);
    isRestaurantAdding = false;
    notifyListeners();
    fetchRestaurants();
  }

  // String get getRestaurantID {
  //   return restaurant.restaurantID;
  // }

  Future<void> isVendorUniqueOrNot() async {
    bool flag = await _restaurantRepo.isVendorUnique();
    isVendorUnique = !flag;
    notifyListeners();
  }

  Future<void> setVendorID(String vendorID) async {
    this.vendorID = vendorID;
    notifyListeners();
  }

  Future<void> clearFlag() async {
    isVendorUnique = false;
  }

  Future<void> fetchVendorRestaurant() async {
    isRestaurantFetching = true;
    restaurant = await _restaurantRepo.fetchRestaurant();
    isRestaurantFetching = false;
    notifyListeners();
  }

  void fetchRestaurants() async {
    isRestaurantsFetching = true;
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    notifyListeners();
    restaurants = await _restaurantRepo.fetchRestaurantsList();
    isRestaurantsFetching = false;
    notifyListeners();
  }

  void fetchNotApprovedRestaurants() async {
    isFetching = true;
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    notifyListeners();
    pendingRestaurants = await _restaurantRepo.fetchNotApprovedRestaurants();
    isFetching = false;
    notifyListeners();
  }

  void fetchSearchedRestaurants(String restraurantName) async {
    isRestaurantsFetching = true;
    // await Future.delayed(
    //   const Duration(milliseconds: 10),
    // );
    // notifyListeners();
    searchedRestaurants =
        await _restaurantRepo.fetchSearchedRestaurantsList(restraurantName);
    isRestaurantsFetching = false;
    notifyListeners();
    if (restaurants.length != 0) {
      isRestaurantSearched = true;
    } else
      isRestaurantSearched = false;
  }

  File imageFile = File("");
  String imageName = '';
  String uploadError = '';
  String restaurantImageURL = '';

  Future<bool> uploadImage() async {
    imageUplaoding = true;
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );
    if (results == null) {
      uploadError = ('No File Selected');
      return Future.value(false);
    }
    final path = results.files.single.path!;
    final fileName = results.files.single.name;

    imageFile = File(path);
    imageName = fileName;

    final firebase_url =
        await storage_service.uploadImageToDefaultBucket(imageFile, imageName);
    restaurantImageURL = firebase_url;
    notifyListeners();
    print(restaurantImageURL);
    updateRestaurantImage(this.vendorID);
    fetchVendorRestaurant();
    //clearPath();
    return Future.value(true);
  }

  Future<void> updateRestaurantImage(String vendorID) async {
    print(restaurantImageURL);
    isImageUpdated = await _restaurantRepo.updateRestaurantImage(
        vendorID, this.restaurantImageURL);
    notifyListeners();
    print(isImageUpdated);
  }

  void clearPath() {
    //imageFile = File("");
    imageName = '';
    restaurantImageURL = '';
  }

  Future<void> updateVendorRestaurant(
      String restaurantID, Restaurant restaurant) async {
    isVendorRestaurantUpdated =
        await _restaurantRepo.updateRestaurant(restaurantID, restaurant);
    //print(isVendorRestaurantUpdated);
    notifyListeners();
  }

  Future<void> fetchRestaurantByID(String restaurantID) async {
    isRestaurantFetching = true;
    restaurant = await _restaurantRepo.fetchRestaurantByID(restaurantID);
    isRestaurantFetching = false;
    notifyListeners();
  }

  void clearRestaurant() async {
    restaurant = Restaurant(
        restaurant_name: "",
        restaurant_address: "",
        restaurant_email: "",
        restaurant_website: "",
        delivery_time: "",
        delivery_cost: "",
        vendorID: "");
    notifyListeners();
  }

  Future<void> approveVendorAndRestaurant(String vendorID) async {
    isVendorApproving = true;
    isApproved = await _restaurantRepo.approveVendorAndRestaurant(vendorID);
    isVendorApproving = false;
    fetchNotApprovedRestaurants();
    fetchRestaurants();
    notifyListeners();
  }
}
