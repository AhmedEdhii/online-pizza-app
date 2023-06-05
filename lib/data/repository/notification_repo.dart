import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_pizza/data/models/notification_model.dart';

abstract class NotificationRepo {
  Future<void> addNotification(Notifications notification);
  Future<List<Notifications>> fetchNotificationList(String restaurantID);
 // Future<List<Review>> fetchUserReviewList(String userid);
  //Future<Order> fetchOrder(String restaurantID);
}

class FirebaseNotificationRepo implements NotificationRepo {
  final db = FirebaseFirestore.instance;

  CollectionReference firebaseUser =
      FirebaseFirestore.instance.collection('Notifications');

  @override
  Future<void> addNotification(Notifications notification) async {
    await db.collection("Notifications").add(notification.toJson());
  }


  @override
  Future<List<Notifications>> fetchNotificationList(String restaurantID) async {
    List<Notifications> notifications = [];
    await db
        .collection("Notifications")
        .where('restaurantID', isEqualTo: restaurantID)
        .get()
        .then((event) {
      notifications =
          event.docs.map((e) => Notifications.fromJson(e.data(), e.id)).toList();
    });
    return notifications;
  }



}