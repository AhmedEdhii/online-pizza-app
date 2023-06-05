import 'package:flutter/material.dart';
import 'package:online_pizza/constant/app_icons.dart';
import 'package:online_pizza/constant/colors.dart';

class VendorBottomNavBarWidget extends StatelessWidget {
  const VendorBottomNavBarWidget(
      {Key? key,
      required this.currentIndex,
      required this.onTapDashboard,
      required this.onTapMenu,
      required this.onTapAddItem,
      required this.onTapNotifications,
      required this.onTapProfile})
      : super(key: key);

  final int currentIndex;
  final VoidCallback onTapDashboard;
  final VoidCallback onTapMenu;
  final VoidCallback onTapAddItem;
  final VoidCallback onTapNotifications;
  final VoidCallback onTapProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BottomNavBarItem(
            icon: AppIcons.window,
            isSelected: 0 == currentIndex,
            // label: 'Home',
            onTap: onTapDashboard,
          ),
          _BottomNavBarItem(
            icon: AppIcons.hamburger,
            isSelected: 1 == currentIndex,
            // label: 'Wallet',
            onTap: onTapMenu,
          ),
          _MainBottomNavBarItem(
            icon: Icons.add,
            isSelected: 2 == currentIndex,
            // label: 'Profile',
            onTap: onTapAddItem,
          ),
          _BottomNavBarItem(
            icon: AppIcons.edit,
            isSelected: 3 == currentIndex,
            // label: 'Cart',
            onTap: onTapNotifications,
          ),
          _BottomNavBarItem(
            icon: AppIcons.user,
            isSelected: 4 == currentIndex,
            // label: 'Profile',
            onTap: onTapProfile,
          ),
        ],
      ),
    );
  }
}

class UserBottomNavBarWidget extends StatelessWidget {
  const UserBottomNavBarWidget(
      {Key? key,
      required this.currentIndex,
      required this.onTapHome,
      required this.onTapCart,
      required this.onTapOrders,
      required this.onTapProfile})
      : super(key: key);

  final int currentIndex;
  final VoidCallback onTapHome;
  final VoidCallback onTapCart;
  final VoidCallback onTapOrders;
  final VoidCallback onTapProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BottomNavBarItem(
            icon: AppIcons.home,
            isSelected: 0 == currentIndex,
            // label: 'Home',
            onTap: onTapHome,
          ),
          _BottomNavBarItem(
            icon: AppIcons.buy,
            isSelected: 1 == currentIndex,
            // label: 'Wallet',
            onTap: onTapCart,
          ),
          _BottomNavBarItem(
            icon: AppIcons.document,
            isSelected: 2 == currentIndex,
            // label: 'Cart',
            onTap: onTapOrders,
          ),
          _BottomNavBarItem(
            icon: AppIcons.user,
            isSelected: 3 == currentIndex,
            // label: 'Profile',
            onTap: onTapProfile,
          ),
        ],
      ),
    );
  }
}

class _BottomNavBarItem extends StatelessWidget {
  const _BottomNavBarItem({
    Key? key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    // required this.label,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onTap;
  // final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: MyColors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color:
                      isSelected ? MyColors.primaryColor : MyColors.lightGray,
                ),
                const SizedBox(height: 4),
                // Text(
                //   label,
                //   style: Styles.body12px,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MainBottomNavBarItem extends StatelessWidget {
  const _MainBottomNavBarItem({
    Key? key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    // required this.label,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onTap;
  // final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? MyColors.uiBlock : MyColors.primaryColor,
              border: Border.all(
                color: isSelected ? MyColors.lightGray : MyColors.primaryColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: isSelected ? MyColors.primaryColor : MyColors.white,
                  ),

                  // Text(
                  //   label,
                  //   style: Styles.body12px,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
