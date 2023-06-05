import 'package:flutter/material.dart';
import 'package:online_pizza/ui/widgets/global_Widgets/TabBar.dart' as tabBar;
import 'package:online_pizza/ui/widgets/Orders_widgets/Orders_Ongoing.dart'
    as OrderOngoing;
import 'package:online_pizza/ui/widgets/Orders_widgets/Orders_History.dart'
    as OrderHistory;

import '../../../constant/strings.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  OrderOngoing.OngoingOrdersWidget OngoingOrders = const OrderOngoing.OngoingOrdersWidget();
  OrderHistory.OrdersHistoryWidget HistoryOrders = const OrderHistory.OrdersHistoryWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabBar.TabBarExample(
        list:  [OngoingOrders.getTabName(),HistoryOrders.getTabName()],
        tabViewList:  [ OngoingOrders,HistoryOrders],
        title: MyStrings.ordersPageHeading,
      ),
    );
  }
}