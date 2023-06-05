// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/controllers/cart_provider.dart';
import 'package:online_pizza/controllers/order_provider.dart';
import 'package:online_pizza/controllers/restaurant_provider.dart';
import 'package:online_pizza/data/models/order_model.dart';
import 'package:online_pizza/ui/screens/navigations/auth_navigation.dart';
import 'package:online_pizza/ui/widgets/cart_widgets/amount.dart';
import 'package:online_pizza/ui/widgets/cart_widgets/cart_item_widget.dart';
import 'package:online_pizza/ui/widgets/checkoutpage_widgets/payment_buttons.dart';
import 'package:online_pizza/ui/widgets/global_widgets/heading_bar.dart';
import 'package:online_pizza/ui/widgets/global_widgets/location_dropdown.dart';

import 'package:online_pizza/ui/widgets/global_widgets/ui_button.dart'
    as ui_button;
import 'package:provider/provider.dart';

import '../../../../controllers/user_provider.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserProvider>().getCurrentUser();
    context.read<CartProvider>().fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    final cart_items = context.watch<CartProvider>().cartItems;
    final userID = context.watch<UserProvider>().current_user.userid;
    String restaurantID = context.watch<CartProvider>().restaurant_id;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Heading_Bar(
                backButton: true,
                title: MyStrings.checkoutPageHeading,
                notifications: false,
                userAvatar: false,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: MyColors.uiBlock))),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: cart_items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: CartItemWidget(
                          cartItem: cart_items[index], index: index),
                    );
                  },
                ),
              ),
              Total_Amount(),
              AddressDropdownCheckout(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    MyStrings.checkoutPagePayment,
                    style: Styles.H2,
                  ),
                  PaymentOptions(),
                ],
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: ui_button.FilledButton(
                  onPressed: () async {
                    final provider =
                        Provider.of<RestaurantProvider>(context, listen: false);
                    await provider.fetchRestaurantByID(restaurantID);
                    final provider2 =
                        Provider.of<CartProvider>(context, listen: false);
                    final provider3 =
                        Provider.of<UserProvider>(context, listen: false);
                    String restaurantName =
                        await provider.restaurant.restaurant_name;
                    String deliveryCost =
                        await provider.restaurant.delivery_cost;
                    String totalCost = await provider2.total_price.toString();
                    String paymentMethod = await provider2.paymentMethod;
                    String nick = await provider3.selectedAddressNick;
                    await provider3.setDeliveryAddress(nick);
                    String deliveryAddress = '';
                    deliveryAddress = await provider3.selectedDeliveryAddress;
                    print(deliveryAddress);
                    print(paymentMethod);
                    // if (deliveryAddress == '') {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       margin: EdgeInsets.all(18.0),
                    //       content: Text(
                    //         'Please Select Delivery Address',
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //   );
                    // }
                    if (paymentMethod == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          margin: EdgeInsets.all(18.0),
                          content: Text(
                            'Please Select Payment Method',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      Order order = Order(
                          restaurantID: restaurantID,
                          restaurantName: restaurantName,
                          userid: userID,
                          order_items: cart_items,
                          delivery_cost: deliveryCost,
                          total_price: totalCost,
                          additional_instructions: "none",
                          delivery_address: deliveryAddress,
                          payment_method: paymentMethod);
                      context.read<OrderProvider>().addNewOrder(order);
                      context.read<RestaurantProvider>().clearRestaurant();
                      context.read<CartProvider>().clearCart();
                      context.read<CartProvider>().clearOtherProviders();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          margin: EdgeInsets.all(18.0),
                          content: Text(
                            'Order added Successfully',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthNavigation(),
                        ),
                      );
                    }
                    // print("checkoutttttttttttttttttttt");
                    // print(restaurantName);
                    // print(paymentMethod);
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     margin: EdgeInsets.all(18.0),
                    //     content: Text(
                    //       'Added to cart',
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // );
                  },
                  buttonText: MyStrings.checkoutPageButton,
                  buttonSize: Size.fromHeight(59),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressDropdownCheckout extends StatelessWidget {
  const AddressDropdownCheckout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          backgroundColor: MyColors.uiBlock,
          radius: 24,
          child: Icon(
            Icons.location_pin,
            color: MyColors.primaryColor,
            size: 24,
          ),
        ),
        SizedBoxes.horizontalMedium,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MyStrings.addressDetailsHeading,
              style: Styles.SH1Primary,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: LocationDropDown(),
            ),
          ],
        ),
      ],
    );
  }
}
