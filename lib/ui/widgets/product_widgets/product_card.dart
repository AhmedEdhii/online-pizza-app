import 'package:flutter/material.dart';

import 'package:online_pizza/constant/sizedbox.dart';

import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/controllers/cart_provider.dart';
import 'package:online_pizza/controllers/topping_provider.dart';
import 'package:online_pizza/data/models/product_model.dart';
import 'package:online_pizza/ui/screens/user/food_item_view/food_item_view.dart';
import 'package:provider/provider.dart';

import '../../../constant/assets.dart';
import '../../../constant/colors.dart';

class ProductCard extends StatelessWidget {
  ProductCard(
      {required this.product,
      super.key,
      required this.isVendor,
      required this.restaurantID});
  bool isVendor;
  Product product;
  String restaurantID;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isVendor
          ? null
          : () {
              context.read<CartProvider>().setInitialPrice(product.base_price);
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
        height: 120,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 12),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.product_name,
                      style: Styles.H3,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.52,
                      child: Text(
                        product.product_description,
                        style: Styles.body12px,
                      ),
                    ),
                  ],
                ),
                Text("Rs. " + product.base_price.toString(),
                    style: Styles.H3Bold),
              ],
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: product.product_image_url != null
                    ? DecorationImage(
                        image: NetworkImage(product.product_image_url!),
                        fit: BoxFit.fitHeight)
                    : DecorationImage(
                        image: AssetImage(ImageAssets.restaurantDefaultImage),
                        fit: BoxFit.fitHeight),
                borderRadius: BorderRadius.circular(4),
                color: MyColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
