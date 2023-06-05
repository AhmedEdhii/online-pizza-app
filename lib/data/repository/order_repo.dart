import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:online_pizza/data/models/order_model.dart' as _order;

abstract class OrderRepo {
  Future<void> addOrder(_order.Order order);
  Future<List<_order.Order>> fetchVendorActiveOrderList(String restaurantID);
  Future<List<_order.Order>> fetchVendorDeliveredOrderList(String restaurantID);
  Future<List<_order.Order>> fetchVendorOrderList(String restaurantID);
  Future<List<_order.Order>> fetchUserDeliveredOrders(String userid);
  Future<List<_order.Order>> fetchUserActiveOrders(String userid);
  Future<bool> MarkCompleted(String orderID);

//Future<Order> fetchOrder(String restaurantID);
}

class FirebaseOrderRepo implements OrderRepo {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> addOrder(_order.Order order) async {
    await db.collection("Orders").add(order.toJson());
  }

  @override
  Future<List<_order.Order>> fetchVendorActiveOrderList(
      String restaurantID) async {
    List<_order.Order> orders = [];
    if (restaurantID != '') {
      await db
          .collection("Orders")
          .where('restaurantID', isEqualTo: restaurantID)
          .where('order_status', isEqualTo: "inProcess")
          .get()
          .then((event) {
        orders = event.docs
            .map((e) => _order.Order.fromJson(e.data(), e.id))
            .toList();
      });
    }
    return orders;
  }

  @override
  Future<List<_order.Order>> fetchVendorDeliveredOrderList(
      String restaurantID) async {
    List<_order.Order> orders = [];
    if (restaurantID != '') {
      await db
          .collection("Orders")
          .where('restaurantID', isEqualTo: restaurantID)
          .where('order_status', isEqualTo: "delivered")
          .get()
          .then((event) {
        orders = event.docs
            .map((e) => _order.Order.fromJson(e.data(), e.id))
            .toList();
      });
    }
    return orders;
  }

  @override
  Future<List<_order.Order>> fetchVendorOrderList(String restaurantID) async {
    List<_order.Order> orders = [];
    if (restaurantID != '') {
      await db
          .collection("Orders")
          .where('restaurantID', isEqualTo: restaurantID)
          .get()
          .then((event) {
        orders = event.docs
            .map((e) => _order.Order.fromJson(e.data(), e.id))
            .toList();
      });
    }
    return orders;
  }

  @override
  Future<List<_order.Order>> fetchUserDeliveredOrders(String userid) async {
    List<_order.Order> orders = [];
    if (userid != '') {
      await db
          .collection("Orders")
          .where('userid', isEqualTo: userid)
          .where('order_status', isEqualTo: "delivered")
          .get()
          .then((event) {
        orders = event.docs
            .map((e) => _order.Order.fromJson(e.data(), e.id))
            .toList();
      });
    }
    return orders;
  }

  @override
  Future<List<_order.Order>> fetchUserActiveOrders(String userid) async {
    List<_order.Order> orders = [];
    if (userid != '') {
      await db
          .collection("Orders")
          .where('userid', isEqualTo: userid)
          .where('order_status', isEqualTo: "inProcess")
          .get()
          .then((event) {
        orders = event.docs
            .map((e) => _order.Order.fromJson(e.data(), e.id))
            .toList();
      });
    }
    return orders;
  }

  @override
  Future<bool> MarkCompleted(String orderID) async {
    await db.collection('Orders').doc(orderID).update({
      'order_status': "delivered",
    }).then((value) {
      print("Order Status updated");
      return Future.value(true);
    }).catchError((error) {
      print("Failed to updated Task: $error");
    });
    return Future.value(true);
  }
}
