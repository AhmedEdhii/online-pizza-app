import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:online_pizza/data/models/restaurant_model.dart';

abstract class RestaurantRepo {
  Future<bool> addRestaurant(Restaurant restaurant);
  Future<List<Restaurant>> fetchRestaurantsList();
  Future<List<Restaurant>> fetchNotApprovedRestaurants();
  Future<Restaurant> fetchRestaurant();
  Future<List<Restaurant>> fetchSearchedRestaurantsList(String restaurantName);
  Future<bool> updateRestaurant(String restaurantID, Restaurant restaurant);
  Future<bool> approveVendorAndRestaurant(String vendorID);
  Future<bool> isVendorUnique();
  Future<Restaurant> fetchRestaurantByID(String restaurantID);
  Future<bool> updateRestaurantImage(String vendorID, String imageURL);
}

class FirebaseRestaurantsRepository implements RestaurantRepo {
  CollectionReference firebaseRestaurant =
      FirebaseFirestore.instance.collection('Restaurants');
  final db = FirebaseFirestore.instance;

  Future<bool> isVendorUnique() async {
    print(auth.FirebaseAuth.instance.currentUser!.uid);
    final current_user = auth.FirebaseAuth.instance.currentUser!;
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("Restaurants")
        .where('vendorID', isEqualTo: current_user.uid)
        .get();
    return query.docs.isNotEmpty;
  }

  @override
  Future<bool> addRestaurant(Restaurant restaurant) async {
    if (await isVendorUnique()) {
      print('Restaurant already exists');
      return false;
    } else {
      print('Restaurant not exists');
      await firebaseRestaurant.add(restaurant.toJson());
      return true;
    }
  }

  @override
  Future<Restaurant> fetchRestaurant() async {
    final current_user = await auth.FirebaseAuth.instance.currentUser!;
    //print("auth_user" + current_user.uid);
    Restaurant vendor_restaurant = Restaurant(
        cover_image_URL: "",
        restaurant_name: "",
        restaurant_address: "",
        restaurant_email: "",
        restaurant_website: "",
        delivery_time: "",
        delivery_cost: "",
        vendorID: "");
    await firebaseRestaurant
        .where('vendorID', isEqualTo: current_user.uid)
        .get()
        .then((doc) {
      if (doc.docs.isNotEmpty) {
        vendor_restaurant = Restaurant.fromJson(
          doc.docs.first.data() as Map<String, dynamic>,
          doc.docs.first.id,
        );
      }
    });
    return vendor_restaurant;
  }

  @override
  Future<List<Restaurant>> fetchRestaurantsList() async {
    List<Restaurant> restaurants = [];
    await db.collection("Restaurants").get().then((event) {
      restaurants =
          event.docs.map((e) => Restaurant.fromJson(e.data(), e.id)).toList();
    });
    return restaurants;
  }

  Future<List<Restaurant>> fetchNotApprovedRestaurants() async {
    List<Restaurant> restaurants = [];
    await db
        .collection("Restaurants")
        .where('isApproved', isEqualTo: false)
        .get()
        .then((event) {
      restaurants =
          event.docs.map((e) => Restaurant.fromJson(e.data(), e.id)).toList();
    });
    return restaurants;
  }

  @override
  Future<List<Restaurant>> fetchSearchedRestaurantsList(
      String restaurantName) async {
    List<Restaurant> restaurants = [];
    await db
        .collection("Restaurants")
        .where('restaurant_name', isGreaterThan: restaurantName)
        .where('restaurant_name', isLessThan: restaurantName + 'z')
        .get()
        .then((event) {
      restaurants =
          event.docs.map((e) => Restaurant.fromJson(e.data(), e.id)).toList();
    });
    return restaurants;
  }

  @override
  Future<bool> updateRestaurant(
      String restaurantID, Restaurant restaurant) async {
    await db
        .collection("Restaurants")
        .doc(restaurantID)
        .update(restaurant.toJson());
    return Future.value(true);
  }

  @override
  Future<bool> updateRestaurantImage(String vendorID, String imageURL) async {
    String restaurantID = '';
    await firebaseRestaurant
        .where('vendorID', isEqualTo: vendorID)
        .get()
        .then((doc) => {restaurantID = doc.docs.first.id})
        .catchError((error) => {
              print("Error on get data from Restaurant"),
              print(error.toString())
            });

    await firebaseRestaurant.doc(restaurantID).update({
      'cover_image_URL': imageURL,
    }).then((value) {
      print("url updated");
    }).catchError((error) => print("Failed to updated url $error"));

    return Future.value(true);
  }

  Future<bool> approveVendorAndRestaurant(String vendorID) async {
    String restaurantID = '';
    await db.collection("Users").doc(vendorID).update({
      'userRole': "vendor",
    }).then((value) {
      print("Vendor updated");
    }).catchError((error) => print("Failed to updated Vendor: $error"));

    await firebaseRestaurant
        .where('vendorID', isEqualTo: vendorID)
        .get()
        .then((doc) => {restaurantID = doc.docs.first.id})
        .catchError((error) => {
              print("Error on get data from Restaurant"),
              print(error.toString())
            });

    await firebaseRestaurant.doc(restaurantID).update({
      'isApproved': true,
    }).then((value) {
      print("status updated");
    }).catchError((error) => print("Failed to updated status $error"));

    return Future.value(true);
  }

  Future<Restaurant> fetchRestaurantByID(String restaurantID) async {
    var restaurant;
    if (restaurantID != '') {
      await firebaseRestaurant.doc(restaurantID).get().then((doc) {
        restaurant = Restaurant.fromJson(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      });
    }
    return restaurant;
  }
}

class MockRestaurantsRepository implements RestaurantRepo {
  List<Restaurant> restaurants = [];

  @override
  Future<List<Restaurant>> fetchRestaurantsList() async {
    return restaurants;
  }

  @override
  Future<Restaurant> fetchRestaurant() {
    // TODO: implement fetchRestaurant
    throw UnimplementedError();
  }

  @override
  Future<List<Restaurant>> fetchSearchedRestaurantsList(
      String restraurantName) async {
    // TODO: implement fetchSearchedRestaurantsList
    return restaurants;
  }

  @override
  Future<bool> updateRestaurant(String restaurantID, Restaurant restaurant) {
    // TODO: implement updateRestaurant
    return Future.value(true);
  }

  @override
  Future<Restaurant> fetchRestaurantByID(String restaurantID) {
    // TODO: implement fetchRestaurantByID
    throw UnimplementedError();
  }

  @override
  Future<bool> approveVendorAndRestaurant(String vendorID) {
    // TODO: implement approveVendorAndRestaurant
    throw UnimplementedError();
  }

  @override
  Future<bool> addRestaurant(Restaurant restaurant) {
    // TODO: implement addRestaurant
    throw UnimplementedError();
  }

  @override
  Future<bool> isVendorUnique() {
    // TODO: implement isVendorUnique
    throw UnimplementedError();
  }

  @override
  Future<List<Restaurant>> fetchNotApprovedRestaurants() {
    // TODO: implement fetchNotApprovedRestaurants
    throw UnimplementedError();
  }

  @override
  Future<bool> updateRestaurantImage(String vendorID, String imageURL) {
    // TODO: implement updateRestaurantImage
    throw UnimplementedError();
  }
}
