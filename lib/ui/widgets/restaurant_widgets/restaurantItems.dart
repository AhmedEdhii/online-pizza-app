import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/controllers/restaurant_provider.dart';
import 'package:online_pizza/ui/widgets/product_widgets/product_card.dart';
import 'package:provider/provider.dart';

import '../../../constant/strings.dart';
import '../../../constant/styles.dart';
import '../../../controllers/product_provider.dart';
import '../global_widgets/user_avatar.dart';

class RestaurantItems extends StatefulWidget {
  RestaurantItems(
      {Key? key,
      required this.tabID,
      this.restaurantID = '',
      required this.isVendor})
      : super(key: key);

  bool isVendor;
  String restaurantID;
  String getTabName() {
    if (tabID == 1) {
      return MyStrings.menuPageTab1;
    }
    if (tabID == 2) {
      return MyStrings.menuPageTab2;
    }
    if (tabID == 3) {
      return MyStrings.menuPageTab3;
    }
    if (tabID == 4) {
      return MyStrings.menuPageTab4;
    }
    return '';
  }

  int tabID;
  @override
  State<RestaurantItems> createState() => _RestaurantItemsState();
}

class _RestaurantItemsState extends State<RestaurantItems> {
  var allProducts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isVendor) {
      context.read<ProductProvider>().fetchVendorProductsList();
    } else {
      context.read<ProductProvider>().fetchProductsList(widget.restaurantID);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabID == 1) {
      allProducts = context.watch<ProductProvider>().allProducts;
    }
    if (widget.tabID == 2) {
      allProducts = context
          .watch<ProductProvider>()
          .allProducts
          .where((i) =>
              i.product_type.toLowerCase() ==
              MyStrings.menuPageTab2.toLowerCase())
          .toList();
    }
    if (widget.tabID == 3) {
      allProducts = context
          .watch<ProductProvider>()
          .allProducts
          .where((i) =>
              i.product_type.toLowerCase() ==
              MyStrings.menuPageTab3.toLowerCase())
          .toList();
    }
    if (widget.tabID == 4) {
      allProducts = context
          .watch<ProductProvider>()
          .allProducts
          .where((i) =>
              i.product_type.toLowerCase() ==
              MyStrings.menuPageTab4.toLowerCase())
          .toList();
    }

    return context.watch<ProductProvider>().isAllProductsFetching
        ? Center(child: const CircularProgressIndicator())
        : allProducts.length == 0
            ? Center(child: const Text("No Product Found"))
            : ListView.builder(
                clipBehavior: Clip.none,
                padding: const EdgeInsets.only(
                    top: 25, bottom: 45, right: 5, left: 5),
                itemCount: allProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                      product: allProducts[index],
                      isVendor: widget.isVendor,
                      restaurantID: widget.restaurantID);
                },
              );
  }
}
