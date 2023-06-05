import 'package:flutter/cupertino.dart';
import 'package:online_pizza/data/models/review_model.dart';
import 'package:online_pizza/data/repository/review_repo.dart';


class ReviewProvider with ChangeNotifier {
  List<Review> reviews = [];


  bool isReviewAdding = false;
  bool isReviewsFetching = false;

  // final RestaurantRepo _productRepoMock = MockRestaurantsRepository();

  final ReviewRepo _reviewRepo = FirebaseReviewRepo();

  void addNewReview(Review review) async {
    isReviewAdding = true;
    await _reviewRepo.addReview(review);
    isReviewAdding = false;
    notifyListeners();
  }

  void fetchReviewList(String restaurantID) async {
    isReviewsFetching = true;

    reviews = await _reviewRepo.fetchReviewList(restaurantID);
    isReviewsFetching = false;
    notifyListeners();
  }

  
}