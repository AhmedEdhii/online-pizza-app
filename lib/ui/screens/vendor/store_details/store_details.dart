import 'package:flutter/material.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/controllers/restaurant_provider.dart';
import 'package:online_pizza/controllers/user_provider.dart';
import 'package:online_pizza/data/models/restaurant_model.dart';
import 'package:online_pizza/ui/widgets/form_widgets/form_widgets.dart';
import 'package:online_pizza/ui/widgets/global_widgets/heading_bar.dart';
import 'package:online_pizza/ui/widgets/global_widgets/ui_button.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/user_model.dart';

class StoreDetails extends StatefulWidget {
  const StoreDetails({super.key});

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().fetchVendorRestaurant();
    context.read<UserProvider>().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final vendor_restaurant = context.watch<RestaurantProvider>().restaurant;
    final current_user = context.watch<UserProvider>().current_user;
    String changedRestaurantName = "";
    String changedUserName = "";
    String changedRestaurantEmail = "";
    String changedRestaurantAddress = "";
    //final restaurant = context.watch<RestaurantProvider>().restaurant;

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
                    backButton: false,
                    title: "Store Details",
                    notifications: false,
                    userAvatar: false),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CustomTextField(
                  labelText: 'Restaurant Name',
                  // hintText: 'e.g. Pizza Hut',

                  initialValue: vendor_restaurant.restaurant_name,
                  onChanged: (restaurantName) =>
                      changedRestaurantName = restaurantName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
                SizedBoxes.verticalBig,
                CustomTextField(
                  labelText: "Owner's Name",
                  //hintText: 'e.g. Pizza Hut',

                  initialValue: current_user.name,
                  onChanged: (userName) => changedUserName = userName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
                SizedBoxes.verticalBig,
                CustomTextField(
                  labelText: "Email",
                  //hintText: 'e.g. Pizza Hut',

                  initialValue: vendor_restaurant.restaurant_email,
                  onChanged: (restaurantEmail) =>
                      changedRestaurantEmail = restaurantEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
                SizedBoxes.verticalBig,
                CustomTextField(
                  labelText: "Address",
                  initialValue: vendor_restaurant.restaurant_address,
                  onChanged: (restaurantAddress) =>
                      changedRestaurantAddress = restaurantAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Required';
                    }
                    return null;
                  },
                ),
              ],
            ),
            FilledButton(
              buttonText: "Edit Changes",
              onPressed: () async {
                Restaurant updatedVendorRestaurant = vendor_restaurant;
                User updatedUser = current_user;
                if (changedUserName != "") updatedUser.name = changedUserName;

                if (changedRestaurantAddress != "")
                  updatedVendorRestaurant.restaurant_address =
                      changedRestaurantAddress;

                if (changedRestaurantEmail != "")
                  updatedVendorRestaurant.restaurant_email =
                      changedRestaurantEmail;

                if (changedRestaurantName != "")
                  updatedVendorRestaurant.restaurant_name =
                      changedRestaurantName;
                await context.read<RestaurantProvider>().updateVendorRestaurant(
                    updatedVendorRestaurant.restaurantID,
                    updatedVendorRestaurant);
                await context
                    .read<UserProvider>()
                    .updateCurrentUser(updatedUser.userid, updatedUser);
                final provider1 =
                    Provider.of<RestaurantProvider>(context, listen: false);
                final provider2 =
                    Provider.of<UserProvider>(context, listen: false);
                bool isVendorRestaurantUpdated =
                    await provider1.isVendorRestaurantUpdated;
                bool isCurrentUserUpdated =
                    await provider2.isCurrentUserUpdated;
                print(isVendorRestaurantUpdated);
                print(isCurrentUserUpdated);
                if (isVendorRestaurantUpdated && isCurrentUserUpdated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      margin: EdgeInsets.all(18.0),
                      content: Text(
                        'Details Updated!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
