import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/controllers/cart_provider.dart';
import 'package:online_pizza/controllers/restaurant_provider.dart';
import 'package:online_pizza/controllers/topping_provider.dart';
import 'package:online_pizza/data/models/cart_item.dart';
import 'package:online_pizza/data/models/topping_model.dart';

import 'package:online_pizza/ui/widgets/global_widgets/ui_button.dart'
    as ui_button;
import 'package:provider/provider.dart';

class Footer extends StatefulWidget {
  Footer(
      {super.key,
      required this.productID,
      required this.productName,
      required this.productURL,
      required this.restaurantID});
  String productID;
  String productName;
  String productURL;
  String restaurantID;

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(color: MyColors.white, boxShadow: [
        BoxShadow(
          color: MyColors.uiBlock,
          blurRadius: 5.0,
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price",
                  style: Styles.body14px,
                ),
                Text(
                  MyStrings.unit +
                      context.watch<CartProvider>().currentCartPrice.toString(),
                  style: Styles.H1Primary,
                ),
              ],
            ),
            ui_button.FilledButton(
              buttonText: MyStrings.itemViewPageButton,
              onPressed: () async {
                List<Topping> toppings = [];
                final provider =
                    Provider.of<CartProvider>(context, listen: false);
                final provider1 =
                    Provider.of<ToppingProvider>(context, listen: false);
                toppings = await provider1.fetchToppings();
                if (provider.cartItems.length != 0 &&
                    provider.isRestaurantDiff()) {
                  return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Alert"),
                      content: Text(
                          "You still have products from another Restaurant. Are you sure you want a Fresh Cart?"),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            provider.setRestaurantID(widget.restaurantID);
                            provider
                                .setPreviousRestaurantID(widget.restaurantID);
                            provider.clearCart();
                            provider.addToCart(widget.productName,
                                widget.productURL, toppings);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                margin: EdgeInsets.all(18.0),
                                content: Text(
                                  'Added to cart',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                            Navigator.of(context)
                              ..pop()
                              ..pop()
                              ..pop();
                          },
                          child: Text("Yes"),
                        ),
                      ],
                    ),
                  );
                } else {
                  provider.setPreviousRestaurantID(widget.restaurantID);
                  provider.addToCart(
                      widget.productName, widget.productURL, toppings);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      margin: EdgeInsets.all(18.0),
                      content: Text(
                        'Added to cart',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                  Navigator.of(context)..pop();
                }
                context
                    .read<RestaurantProvider>()
                    .fetchRestaurantByID(widget.restaurantID);
              },
              buttonSize: Size(170, 47),
            )
          ],
        ),
      ),
    );
  }
}
