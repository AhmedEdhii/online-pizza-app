import 'package:flutter/material.dart';

import 'package:online_pizza/constant/sizedbox.dart';

import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/data/models/product_model.dart';
import 'package:provider/provider.dart';

import '../../../constant/assets.dart';
import '../../../constant/colors.dart';
import '../../../controllers/cart_provider.dart';
import '../../../controllers/topping_provider.dart';
import '../../screens/user/food_item_view/food_item_view.dart';

class FeaturedProductCard extends StatelessWidget {
  FeaturedProductCard(
      {required this.product,
      super.key,
      required this.isVendor,
      required this.restaurantID});
  bool isVendor;
  Product product;
  String restaurantID;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: InkWell(
        onTap: isVendor
            ? null
            : () {
                context
                    .read<CartProvider>()
                    .setInitialPrice(product.base_price);
                context.read<CartProvider>().setInitialQuantity();
                context.read<ToppingProvider>().initializeTopping();
                if (product.product_type.toLowerCase() == 'pizza') {
                  context
                      .read<CartProvider>()
                      .setSelectedSize(product.product_sizes![0]);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodItemView(
                        product: product, restaurantID: restaurantID),
                  ),
                );
              },
        child: Container(
          width: 180,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(66, 56, 56, 56).withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 30,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  image: product.product_image_url != null
                      ? DecorationImage(
                          image: NetworkImage(product.product_image_url!),
                          fit: BoxFit.cover)
                      : DecorationImage(
                          image: AssetImage(ImageAssets.restaurantDefaultImage),
                          fit: BoxFit.fitHeight),
                  borderRadius: BorderRadius.circular(4),
                  color: MyColors.white,
                ),
              ),
              SizedBoxes.verticalTiny,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.product_name,
                    style: Styles.H3,
                  ),
                  SizedBoxes.verticalTiny,
                  Text("Rs. " + product.base_price.toString(),
                      style: Styles.body12pxdark),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
