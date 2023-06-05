import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:provider/provider.dart';

import '../../../controllers/cart_provider.dart';
import '../../../controllers/restaurant_provider.dart';

class Total_Amount extends StatelessWidget {
  Total_Amount({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = context.watch<RestaurantProvider>().restaurant;
    final provider = Provider.of<CartProvider>(context, listen: false);
    if (provider.cartItems.isNotEmpty) {
      provider.updateSubTotal();
      provider.setDeliveryCost(restaurant.delivery_cost);
      provider.updateTotal(restaurant.delivery_cost);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              MyStrings.subTotal,
              style: Styles.H3Regular,
            ),
            Text(
              MyStrings.unit +
                  context.watch<CartProvider>().subtotal.toString(),
              style: Styles.H3Regular,
            ),
          ],
        ),
        SizedBoxes.verticalMicro,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              MyStrings.delivery,
              style: Styles.H3Regular,
            ),
            Text(
              MyStrings.unit +
                  context.watch<CartProvider>().deliveryCost.toString(),
              style: Styles.H3Regular,
            ),
          ],
        ),
        SizedBoxes.verticalMicro,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              MyStrings.total,
              style: Styles.H2Bold,
            ),
            Text(
              MyStrings.unit +
                  context.watch<CartProvider>().total_price.toString(),
              style: Styles.H2Bold,
            ),
          ],
        ),
      ]),
    );
  }
}
