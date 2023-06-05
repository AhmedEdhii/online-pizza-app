import 'package:flutter/cupertino.dart';
import 'package:online_pizza/data/models/notification_model.dart';
import 'package:online_pizza/data/repository/notification_repo.dart';

class NotificationProvider with ChangeNotifier {
  List<Notifications> notifications = [];


  bool isNotificationAdding = false;
  bool isNotificationsFetching = false;

  // final RestaurantRepo _productRepoMock = MockRestaurantsRepository();

  final NotificationRepo _notificationRepo = FirebaseNotificationRepo();

  void addNewNotification(Notifications notification) async {
    isNotificationAdding = true;
    await _notificationRepo.addNotification(notification);
    isNotificationAdding = false;
    notifyListeners();
  }

  void fetchNotificationList(String restaurantID) async {
    isNotificationsFetching = true;

    notifications = await _notificationRepo.fetchNotificationList(restaurantID);
    isNotificationsFetching = false;
    notifyListeners();
  }

  
}