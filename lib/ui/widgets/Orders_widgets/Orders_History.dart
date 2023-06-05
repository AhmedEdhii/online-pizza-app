import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/controllers/order_provider.dart';
import 'package:provider/provider.dart';
import '../../../constant/strings.dart';
import '../../../constant/styles.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class OrdersHistoryWidget extends StatefulWidget {
  const OrdersHistoryWidget({Key? key}) : super(key: key);

  String getTabName() {
    return MyStrings.ordersPageTab2;
  }

  @override
  State<OrdersHistoryWidget> createState() => _OrdersHistoryWidgetState();
}

class _OrdersHistoryWidgetState extends State<OrdersHistoryWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userID = auth.FirebaseAuth.instance.currentUser!.uid;
    context.read<OrderProvider>().fetchUserDeliveredOrders(userID);
  }

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().userDeliveredOrders;

    return context.watch<OrderProvider>().isDeliveredOrdersFetching
        ? Center(child: const CircularProgressIndicator())
        : ListView.separated(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(orders[index].restaurantName, style: Styles.H3),
                subtitle: Text("Rs. " + orders[index].total_price,
                    style: Styles.body14px),
                trailing: Text(
                    DateFormat.yMMMd()
                        .format((DateTime.parse(
                            orders[index].order_date.toString())))
                        .toString(),
                    style: Styles.IDText),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
  }
}

class MyOngoingOrders {
  final OrderID;
  final String Restaurantname;
  final String Cost;

  MyOngoingOrders({
    required this.Cost,
    required this.Restaurantname,
    required this.OrderID,
  });
}

List<MyOngoingOrders> OrdersHistory = [
  MyOngoingOrders(
      OrderID: " #162432", Restaurantname: "Pizza Hut", Cost: "Rs. 360"),
  MyOngoingOrders(
      OrderID: " #162634", Restaurantname: "Pizza Hut", Cost: "Rs. 1360"),
  MyOngoingOrders(
      OrderID: " #143452", Restaurantname: "Pizza Hut", Cost: "Rs. 2760")
]; // TODO Implement this library.
