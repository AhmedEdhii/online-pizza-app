import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_pizza/data/models/review_model.dart';

abstract class ReviewRepo {
  Future<void> addReview(Review review);
  Future<List<Review>> fetchReviewList(String restaurantID);
 // Future<List<Review>> fetchUserReviewList(String userid);
  //Future<Order> fetchOrder(String restaurantID);
}

class FirebaseReviewRepo implements ReviewRepo {
  final db = FirebaseFirestore.instance;

  CollectionReference firebaseUser =
      FirebaseFirestore.instance.collection('Reviews');

  @override
  Future<void> addReview(Review review) async {
    await db.collection("Reviews").add(review.toJson()).then((value) {
      print("review added.");
    }).catchError((error) => print("Failed to add Task: $error"));
  }
  



  @override
  Future<List<Review>> fetchReviewList(String restaurant) async {
    List<Review> reviews = [];
    await db
        .collection("Reviews")
        .where('restaurantID', isEqualTo: restaurant)
        .get()
        
        .then((event) {
      reviews =
          event.docs.map((e) => Review.fromJson(e.data(), e.id)).toList();
    });
    return reviews;
  }



}