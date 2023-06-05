import 'package:flutter/material.dart';
import 'package:online_pizza/data/models/cart_model.dart';
import 'package:online_pizza/ui/screens/orders/OrderScreen.dart';
import 'package:online_pizza/ui/screens/user/user_profile/user_profile.dart';
import 'package:online_pizza/ui/screens/vendor/vendor_dashboard/vendor_dashboard.dart';
import 'package:online_pizza/ui/screens/vendor/vendor_profile/vendor_profile.dart';
import '../widgets/global_widgets/bottom_navbar.dart';
import 'user/cart_page/cart_page.dart';
import 'user/home_page/home_page.dart';
import 'login_page/login_page.dart';
import 'restaurant_view/restaurant_view.dart';

class NavBarNavigationPage extends StatefulWidget {
  const NavBarNavigationPage({Key? key}) : super(key: key);

  @override
  _NavBarNavigationPageState createState() => _NavBarNavigationPageState();
}

class _NavBarNavigationPageState extends State<NavBarNavigationPage> {
  int currentIndex = 0;
  final screens = [
    HomeScreen(),
    CartPage( ),
    OrdersScreen(),
    UserProfile(),
  ];

  get bottomNavigationBar => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: UserBottomNavBarWidget(
          currentIndex: currentIndex,
          onTapHome: onTapHome,
          onTapCart: onTapCart,
          onTapOrders: onTapOrders,
          onTapProfile: onTapProfile),
    );
  }

  void onTapCart() {
    currentIndex = 1;
    setState(() {});
  }

  void onTapHome() {
    currentIndex = 0;
    setState(() {});
  }

  void onTapOrders() {
    currentIndex = 2;
    setState(() {});
  }

  void onTapProfile() {
    currentIndex = 3;
    setState(() {});
  }
}
