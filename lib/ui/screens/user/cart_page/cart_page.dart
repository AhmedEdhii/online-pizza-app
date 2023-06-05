// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/controllers/cart_provider.dart';
import 'package:online_pizza/controllers/restaurant_provider.dart';
import 'package:online_pizza/data/models/cart_model.dart';
import 'package:online_pizza/ui/screens/user/checkout_page/checkout_page.dart';
import 'package:online_pizza/ui/widgets/cart_widgets/amount.dart';
import 'package:online_pizza/ui/widgets/cart_widgets/cart_item_widget.dart';
import 'package:online_pizza/ui/widgets/global_widgets/heading_bar.dart';
import 'package:online_pizza/ui/widgets/global_widgets/ui_button.dart'
    as ui_button;
import 'package:provider/provider.dart';

import '../../../../constant/styles.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartProvider>().fetchCartItems();
  }

  // List<Widget> cart_items = [
  //   CartItem(),
  //   CartItem(),
  //   CartItem(),
  // ];
  @override
  Widget build(BuildContext context) {
    final cart_items = context.watch<CartProvider>().cartItems;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Heading_Bar(
                    title: MyStrings.cartPageHeading,
                    backButton: false,
                    notifications: false,
                    userAvatar: false,
                  ),
                  //SizedBoxes.verticalTiny,
                  // restaurant name
                  // Text(
                  //   "Pizza One",
                  //   style: Styles.H2Bold,
                  //   textAlign: TextAlign.left,
                  // ),
                  SizedBoxes.verticalTiny,
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: MyColors.uiBlock))),
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: cart_items.length == 0
                        ? Center(child: const Text("Your Cart is Empty"))
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: cart_items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child:
                                    CartItemWidget(cartItem: cart_items[index], index: index),
                              );
                            },
                          ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Total_Amount(),
                  SizedBoxes.verticalBig,
                  ui_button.FilledButton(
                    onPressed: () {
                      if (cart_items.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            margin: EdgeInsets.all(18.0),
                            content: Text(
                              'Sorry! Your Cart is Empty',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutPage(),
                          ),
                        );
                      }
                    },
                    buttonText: MyStrings.cartPageButton,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
