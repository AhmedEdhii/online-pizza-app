import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_pizza/ui/screens/admin/admin_page/Admin_DashBoard.dart';
import 'package:online_pizza/ui/screens/navigations/auth_navigation.dart';
import 'package:online_pizza/ui/screens/vendor/approval_screen/approvaal_screen.dart';
import 'package:online_pizza/ui/screens/vendor_navbar_navigation_page.dart';
import 'package:provider/provider.dart';

import '../../../controllers/user_provider.dart';
import '../navbar_navigation_page.dart';

class RoleNavigation extends StatefulWidget {
  @override
  State<RoleNavigation> createState() => _RoleNavigationState();
}

class _RoleNavigationState extends State<RoleNavigation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    await context.read<UserProvider>().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<UserProvider>().current_user;
    //print("user role: " + firebaseUser.userRole);
    if (firebaseUser.isVendorPending) {
      return ApprovalScreen();
    } else if (firebaseUser.userRole == "vendor") {
      return VendorNavBarNavigationPage();
    } else if (firebaseUser.userRole == "admin") {
      return AdminDashboard();
    } else
      return NavBarNavigationPage();
  }
}
