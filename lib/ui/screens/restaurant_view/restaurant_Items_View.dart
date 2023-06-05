import 'package:flutter/material.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/ui/widgets/global_widgets/subTabBar.dart'
    as subtabBar;
import 'package:online_pizza/ui/widgets/restaurant_widgets/restaurantItems.dart'
    as restaurantItems;
import 'package:provider/provider.dart';

import '../../../controllers/product_provider.dart';

class RestaurantItemsView extends StatefulWidget {
  RestaurantItemsView(
      {Key? key, this.restaurantID = '', required this.isVendor})
      : super(key: key);
  bool isVendor;
  String restaurantID;
  @override
  State<RestaurantItemsView> createState() => _RestaurantItemsViewState();
}

class _RestaurantItemsViewState extends State<RestaurantItemsView> {
  @override
  Widget build(BuildContext context) {
    // final allProducts = context.watch<ProductProvider>().allProducts;
    return SizedBox(
      child: subtabBar.subTabBarExample(
        list: ["All", "Pizza", "Drinks", "Sauces"],
        tabViewList: [
          restaurantItems.RestaurantItems(
              tabID: 1,
              restaurantID: widget.restaurantID,
              isVendor: widget.isVendor),
          restaurantItems.RestaurantItems(
              tabID: 2,
              restaurantID: widget.restaurantID,
              isVendor: widget.isVendor),
          restaurantItems.RestaurantItems(
              tabID: 3,
              restaurantID: widget.restaurantID,
              isVendor: widget.isVendor),
          restaurantItems.RestaurantItems(
              tabID: 4,
              restaurantID: widget.restaurantID,
              isVendor: widget.isVendor)
        ],
      ),
    );
  }
}
