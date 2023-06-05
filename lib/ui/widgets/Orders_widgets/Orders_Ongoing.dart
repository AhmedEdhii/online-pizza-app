import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/ui/widgets/global_widgets/ui_button.dart'
    as ui_button;
import 'package:provider/provider.dart';
import '../../../constant/strings.dart';
import '../../../constant/styles.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:intl/intl.dart';

import '../../../controllers/order_provider.dart';

class OngoingOrdersWidget extends StatefulWidget {
  const OngoingOrdersWidget({Key? key}) : super(key: key);

  String getTabName() {
    return MyStrings.ordersPageTab1;
  }

  @override
  State<OngoingOrdersWidget> createState() => _OngoingOrdersWidgetState();
}

class _OngoingOrdersWidgetState extends State<OngoingOrdersWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userID = auth.FirebaseAuth.instance.currentUser!.uid;
    context.read<OrderProvider>().fetchUserActiveOrders(userID);
  }

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().userActiveOrders;

    return context.watch<OrderProvider>().isActiveOrdersFetching
        ? Center(child: const CircularProgressIndicator())
        : ListView.separated(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(orders[index].restaurantName, style: Styles.H3),
                    subtitle: Text("Rs. " + orders[index].total_price,
                        style: Styles.body14px),
                    trailing: Text(
                        DateFormat.yMMMd()
                            .format((DateTime.parse(
                                orders[index].order_date.toString())))
                            .toString(),
                        style: Styles.IDText),
                  ),
                ],
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

List<MyOngoingOrders> OngoingOrders = [
  MyOngoingOrders(
      OrderID: " #162432", Restaurantname: "Pizza Hut", Cost: "Rs. 360"),
  MyOngoingOrders(
      OrderID: " #162634", Restaurantname: "Pizza Hut", Cost: "Rs. 1360"),
  MyOngoingOrders(
      OrderID: " #143452", Restaurantname: "Pizza Hut", Cost: "Rs. 2760")
]; // TODO Implement this libraryry.
