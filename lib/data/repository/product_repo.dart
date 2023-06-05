import 'package:online_pizza/data/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:online_pizza/data/models/restaurant_model.dart';

abstract class ProductRepo {
  Future<void> addProduct(Product product);
  Future<List<Product>> fetchProductsList(String restaurantID);
  Future<List<Product>> fetchFeaturedProductsList(String restaurantID);
  Future<List<Product>> fetchVendorFeaturedProductsList();
  Future<List<Product>> fetchVendorProductsList();
}

class FirebaseProductRepo implements ProductRepo {
  final db = FirebaseFirestore.instance;

  CollectionReference firebaseRestaurant =
      FirebaseFirestore.instance.collection('Restaurants');
  CollectionReference firebaseProduct =
      FirebaseFirestore.instance.collection('Products');

  @override
  Future<void> addProduct(Product product) async {
    await db.collection("Products").add(product.toJson());
  }
  //
  // @override
  // Future<Product> fetchProduct() async {
  //   final auth_user = auth.FirebaseAuth.instance.currentUser!;
  //   //print("auth_user" + auth_user.uid);
  //   var products;
  //   await firebaseUser.doc(auth_user.uid).get().then((doc) {
  //     // Load User from Firebase to User Provider
  //     products = Product.fromJson(doc.data() as Map<String, dynamic>, doc.id);
  //
  //   });
  //
  //   return products;
  // }

  @override
  Future<List<Product>> fetchProductsList(String restaurantID) async {
    List<Product> products = [];
    await db
        .collection("Products")
        .where('restaurantID', isEqualTo: restaurantID)
        .get()
        .then((event) {
      products =
          event.docs.map((e) => Product.fromJson(e.data(), e.id)).toList();
    });
    return products;
  }

  @override
  Future<List<Product>> fetchVendorFeaturedProductsList() async {
    // toString used cuz future string returned
    String restaurantID = '';
    final resID = await fetchRestaurantID();
    if(resID.isNotEmpty){
      restaurantID = resID.toString();
    }

    List<Product> products = [];
    await db
        .collection("Products")
        .where('restaurantID', isEqualTo: restaurantID)
        .where('isFeatured', isEqualTo: true)
        .get()
        .then((event) {
      products =
          event.docs.map((e) => Product.fromJson(e.data(), e.id)).toList();
    });
    return products;
  }

  Future<String> fetchRestaurantID() async {
    String restaurantID = '';
    final current_user = auth.FirebaseAuth.instance.currentUser!;
    if (current_user.uid != '') {
      await firebaseRestaurant
          .where('vendorID', isEqualTo: current_user.uid)
          .get()
          .then((doc) {
            if(doc.docs.isNotEmpty){
              restaurantID = doc.docs.first.id;
            }
      });
    }
    return restaurantID;
  }

  @override
  Future<List<Product>> fetchVendorProductsList() async {
    // toString used cuz future string returned
    String restaurantID = '';
    final resID = await fetchRestaurantID();
    if(resID.isNotEmpty){
      restaurantID = resID.toString();
    }

    List<Product> products = [];
    await db
        .collection("Products")
        .where('restaurantID', isEqualTo: restaurantID)
        .get()
        .then((event) {
      products =
          event.docs.map((e) => Product.fromJson(e.data(), e.id)).toList();
    });
    return products;
  }

  @override
  Future<List<Product>> fetchFeaturedProductsList(String restaurantID) async {
    List<Product> products = [];
    await db
        .collection("Products")
        .where('restaurantID', isEqualTo: restaurantID)
        .where('isFeatured', isEqualTo: true)
        .get()
        .then((event) {
      products =
          event.docs.map((e) => Product.fromJson(e.data(), e.id)).toList();
    });
    return products;
  }
}

//
// class MockProductsRepository implements ProductRepo {
//   final db = FirebaseFirestore.instance;
//   List<Product> products = [];
//
//   @override
//   Future<void> addProduct(Product product) async {
//     products.add(product);
//     print('Product added');
//   }
//
//   // @override
//   // Future<List<Product>> fetchProductsList async {
//   //   return products;
//   // }
//
//   @override
//   Future<Product> fetchProduct() {
//     // TODO: implement fetchProduct
//     throw UnimplementedError();
//   }
//
// }
