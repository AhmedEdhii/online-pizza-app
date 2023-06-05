import 'package:flutter/cupertino.dart';
import 'package:online_pizza/data/models/order_model.dart';
import 'package:online_pizza/data/repository/order_repo.dart';

class OrderProvider with ChangeNotifier {
  List<Order> activeOrders = [];

  List<Order> allOrders = [];

  List<Order> deliveredOrders = [];

  List<Order> userActiveOrders = [];

  List<Order> userDeliveredOrders = [];

  bool isActiveVendorOrdersFetching = false;
  bool isDeliveredVendorOrdersFetching = false;
  bool isVendorOrdersFetching = false;
  bool isOrderAdding = false;
  bool isDeliveredOrdersFetching = false;
  bool isActiveOrdersFetching = false;
  bool isOrdersFetching = false;
  bool isOrderUpdating = false;
  bool isDelivered = false;

  // final RestaurantRepo _productRepoMock = MockRestaurantsRepository();

  final OrderRepo _orderRepo = FirebaseOrderRepo();

  void addNewOrder(Order order) async {
    isOrderAdding = true;
    await _orderRepo.addOrder(order);
    isOrderAdding = false;
    // notifyListeners();
  }

  void fetchVendorActiveOrderList(String restaurantID) async {
    isActiveVendorOrdersFetching = true;
    activeOrders = await _orderRepo.fetchVendorActiveOrderList(restaurantID);
    isActiveVendorOrdersFetching = false;
    notifyListeners();
  }

  void fetchVendorDeliveredOrderList(String restaurantID) async {
    isDeliveredVendorOrdersFetching = true;
    deliveredOrders =
        await _orderRepo.fetchVendorDeliveredOrderList(restaurantID);
    isDeliveredVendorOrdersFetching = false;
    notifyListeners();
  }

  void fetchVendorOrderList(String restaurantID) async {
    isVendorOrdersFetching = true;
    allOrders = await _orderRepo.fetchVendorOrderList(restaurantID);
    isVendorOrdersFetching = false;
    notifyListeners();
  }

  void fetchUserDeliveredOrders(String userid) async {
    isDeliveredOrdersFetching = true;
    await Future.delayed(
      const Duration(milliseconds: 400),
    );
    userDeliveredOrders = await _orderRepo.fetchUserDeliveredOrders(userid);
    isDeliveredOrdersFetching = false;
    notifyListeners();
  }

  void fetchUserActiveOrders(String userid) async {
    isActiveOrdersFetching = true;
    await Future.delayed(
      const Duration(milliseconds: 400),
    );
    userActiveOrders = await _orderRepo.fetchUserActiveOrders(userid);
    isActiveOrdersFetching = false;
    notifyListeners();
  }

  void markCompleted(String orderID) async {
    isOrderUpdating = true;
    notifyListeners();
    isDelivered = await _orderRepo.MarkCompleted(orderID);
    isOrderUpdating = false;
    notifyListeners();
  }
}
