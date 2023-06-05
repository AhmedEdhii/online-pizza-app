import 'package:flutter/material.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/data/models/product_model.dart';
import 'package:online_pizza/data/models/topping_model.dart';
import 'package:online_pizza/ui/widgets/cart_widgets/qty_widget.dart';
import 'package:online_pizza/ui/widgets/fooditem_view_widgets/Sizes_widget.dart';
import 'package:online_pizza/ui/widgets/fooditem_view_widgets/extra_topping.dart';
import 'package:online_pizza/ui/widgets/fooditem_view_widgets/food_image.dart';
import 'package:online_pizza/ui/widgets/fooditem_view_widgets/footer.dart';

import 'package:online_pizza/ui/widgets/global_widgets/heading_bar.dart';

// ignore: must_be_immutable
class FoodItemView extends StatelessWidget {
  FoodItemView({super.key, required this.product, required this.restaurantID});
  Product product;
  String restaurantID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // Set this height
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Top Bar Homepage
                Heading_Bar(
                    backButton: true,
                    title: product.product_name,
                    notifications: false,
                    userAvatar: false),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FoodImage(product_image_url: product.product_image_url),
                      SizedBoxes.verticalMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              product.product_name,
                              style: Styles.H1,
                            ),
                          ),
                          QtyWidget(),
                        ],
                      ),
                      SizedBoxes.verticalMicro,
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          product.product_description,
                          style: Styles.body14px,
                        ),
                      ),
                      SizedBoxes.verticalLarge,
                      product.product_type != 'pizza'
                          ? SizedBoxes.verticalTiny
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(MyStrings.itemViewPageSize,
                                    style: Styles.H3Bold),
                                SizedBoxes.verticalTiny,
                                Container(
                                  height: 100,
                                  child: Sizes(
                                    productSizes: product.product_sizes!,
                                    productPrices: product.product_prices!,
                                  ),
                                ),
                                SizedBoxes.verticalLarge,
                                Text(MyStrings.itemViewPageTopping,
                                    style: Styles.H3Bold),
                                SizedBoxes.verticalTiny,
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: toppings.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Extras(topping: toppings[index]);
                                  },
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Footer(
              restaurantID: restaurantID,
              productID: product.productID,
              productName: product.product_name,
              productURL: product.product_image_url!,
            )
          ],
        ),
      ),
    );
  }
}

List<Topping> toppings = [
  Topping(toppingID: "1", toppingName: "Mozzarella Cheese", toppingPrice: "240"),
  Topping(toppingID: "2", toppingName: "Mushrooms", toppingPrice: "80"),
  Topping(toppingID: "3", toppingName: "Olives", toppingPrice: "80"),
  Topping(toppingID: "4", toppingName: "Onion", toppingPrice: "40")
];
