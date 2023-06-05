import 'package:flutter/material.dart';
import 'package:online_pizza/ui/screens/orders/OrderScreen.dart';
import 'package:online_pizza/ui/screens/vendor/menu_screen/menu_screen.dart';
import 'package:online_pizza/ui/screens/vendor/new_item/select_category.dart';
import 'package:online_pizza/ui/screens/vendor/store_details/store_details.dart';
import 'package:online_pizza/ui/screens/vendor/vendor_dashboard/vendor_dashboard.dart';
import 'package:online_pizza/ui/screens/vendor/vendor_profile/vendor_profile.dart';
import '../widgets/global_widgets/bottom_navbar.dart';
import 'notification/Notifications_screen.dart';

class VendorNavBarNavigationPage extends StatefulWidget {
  const VendorNavBarNavigationPage({Key? key}) : super(key: key);

  @override
  _VendorNavBarNavigationPageState createState() =>
      _VendorNavBarNavigationPageState();
}

class _VendorNavBarNavigationPageState
    extends State<VendorNavBarNavigationPage> {
  int currentIndex = 0;
  final screens = [
    VendorDashboard(),
    MenuScreen(),
    SelectCategory(),
    StoreDetails(),
    VendorProfile(),
  ];

  get bottomNavigationBar => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: VendorBottomNavBarWidget(
          currentIndex: currentIndex,
          onTapDashboard: onTapDashboard,
          onTapMenu: onTapMenu,
          onTapAddItem: onTapAddItem,
          onTapNotifications: onTapNotifications,
          onTapProfile: onTapProfile),
    );
  }

  void onTapDashboard() {
    currentIndex = 0;
    setState(() {});
  }

  void onTapMenu() {
    currentIndex = 1;
    setState(() {});
  }

  void onTapAddItem() {
    currentIndex = 2;
    setState(() {});
  }

  void onTapNotifications() {
    currentIndex = 3;
    setState(() {});
  }

  void onTapProfile() {
    currentIndex = 4;
    setState(() {});
  }
}
