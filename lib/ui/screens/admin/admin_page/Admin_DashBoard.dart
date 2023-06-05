// ignore_for_file: file_names, library_prefixes

import 'package:flutter/material.dart';
import 'package:online_pizza/ui/widgets/global_Widgets/TabBar.dart' as tabBar;
import 'package:online_pizza/ui/widgets/AdminPage_widgets/Admin_AllRestaurant.dart'
    as allRestraurant;
import 'package:online_pizza/ui/widgets/AdminPage_widgets/Admin_pendingApprovals.dart'
    as pendingApproval;
import 'package:provider/provider.dart';
import '../../../../constant/app_icons.dart';
import '../../../widgets/global_widgets/ui_button.dart' as ui_button;
import '../../../../services/google_signin_service.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  allRestraurant.AllRestaurant allRestaurants =
      const allRestraurant.AllRestaurant();
  pendingApproval.pendingApprovals pendingApprovals =
      const pendingApproval.pendingApprovals();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabBar.TabBarExample(
        list: [pendingApprovals.getTabName(), allRestaurants.getTabName()],
        tabViewList: [pendingApprovals, allRestaurants],
        title: "Admin Dashboard",
      ),
      floatingActionButton: ui_button.IconButton(
        onPressed: () {
            final provider = Provider.of<GoogleSignInProvider>(context,
                listen: false);
            provider.logout();
        },
        buttonText: 'LOG OUT',
        buttonSize: const Size(330, 56),
        icon: AppIcons.logout,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
