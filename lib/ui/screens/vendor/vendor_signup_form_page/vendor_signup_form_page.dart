import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/controllers/restaurant_provider.dart';
import 'package:online_pizza/data/models/restaurant_model.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/user_provider.dart';
import '../../../../services/google_signin_service.dart';
import '../../../widgets/form_widgets/form_widgets.dart';
import '../../../widgets/global_widgets/custom_back_button.dart';
import '../../../widgets/loginsreen_widgets/google_login.dart';
import '../../navigations/auth_navigation.dart';

class VendorSignupForm extends StatefulWidget {
  const VendorSignupForm({Key? key}) : super(key: key);

  @override
  State<VendorSignupForm> createState() => _VendorSignupFormState();
}

class _VendorSignupFormState extends State<VendorSignupForm> {
  final _formKey = GlobalKey<FormState>();
  var restaurant_name = '';
  var restaurant_address = '';
  var restaurant_website = '';
  var restaurant_delivery_time = '';
  var restaurant_delivery_cost = '';

  @override
  Widget build(BuildContext context) {
    var onPressed;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(150),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                      bottom: BorderSide(width: 1, color: MyColors.uiBlock))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBoxes.verticalBig,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBackButton(onPressed: onPressed),
                      ],
                    ),
                    Text(MyStrings.signUpPageHeading, style: Styles.H1),
                    Text(MyStrings.signUpPageSubtext, style: Styles.body14px),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBoxes.verticalLarge,
                          CustomTextField(
                            labelText: 'Restaurant Name',
                            hintText: 'e.g. Pizza Hut',
                            onChanged: (restaurantName) =>
                                restaurant_name = restaurantName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*Required';
                              }
                              return null;
                            },
                          ),
                          SizedBoxes.verticalMedium,
                          CustomTextField(
                            labelText: "Address",
                            hintText: 'e.g Block 13, Gulshan Iqbal, Karachi',
                            maxLines: 3,
                            onChanged: (restaurantAddress) =>
                                restaurant_address = restaurantAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*Required';
                              }
                              return null;
                            },
                          ),
                          SizedBoxes.verticalMedium,
                          CustomTextField(
                            labelText: "Business Website",
                            hintText: 'www.pizzahut.com',
                            onChanged: (restaurantWebsite) =>
                                restaurant_website = restaurantWebsite,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*Required';
                              }
                              return null;
                            },
                          ),
                          SizedBoxes.verticalMedium,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.44,
                                child: CustomTextField(
                                  labelText: 'Delivery Time (Min)',
                                  hintText: '30',
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  onChanged: (deliveryTime) =>
                                      restaurant_delivery_time = deliveryTime,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '*Required';
                                    } else if (!isValidInt(value)) {
                                      return '*Please Enter an Integer';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.44,
                                child: CustomTextField(
                                  labelText: 'Delivery Cost (Rs)',
                                  hintText: '50',
                                  keyboardType: TextInputType.number,
                                  onChanged: (deliveryCost) =>
                                      restaurant_delivery_cost = deliveryCost,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '*Required';
                                    } else if (!isValidInt(value)) {
                                      return '*Please Enter an Integer';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBoxes.verticalMedium,
                        ],
                      ),
                    ),
                  ),
                ),

                GoogleSignup(
                  signup: () async {
                    final restaurantProvider =
                        Provider.of<RestaurantProvider>(context, listen: false);
                    await restaurantProvider.clearFlag();
                    if (_formKey.currentState!.validate()) {
                      bool isVendor = true;
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      await provider.googleLogin(isVendor);
                      bool isSignedIn = await provider.isSignedIn;
                      if (await isSignedIn) {
                        await restaurantProvider.isVendorUniqueOrNot();
                      }
                      bool isAccountUnique = await provider.isAccountUnique;
                      if (await restaurantProvider.isVendorUnique &&
                          await isAccountUnique) {
                        Restaurant restaurant = Restaurant(
                            restaurant_name: restaurant_name,
                            restaurant_address: restaurant_address,
                            restaurant_email: "",
                            restaurant_website: restaurant_website,
                            delivery_time: restaurant_delivery_time,
                            delivery_cost: restaurant_delivery_cost,
                            vendorID: provider.current_user.uid);
                        restaurantProvider.addNewRestaurant(restaurant);
                        if (isSignedIn) {
                          final userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          userProvider.getCurrentUser();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthNavigation(),
                            ),
                          );
                        }
                      } else {
                        bool isSignedIn = provider.isSignedIn;
                        print(isSignedIn);
                        if (isSignedIn) {
                          provider.logout();
                          if (!isAccountUnique && !restaurantProvider.isVendorUnique) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                margin: EdgeInsets.all(18.0),
                                content: Text(
                                  'Sorry! A restaurant already exists with this account.',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                margin: EdgeInsets.all(18.0),
                                content: Text(
                                  'Sorry! A user account is already associated with this gmail.',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        }
                      }
                    }
                  },
                ),

                // ui_button.FilledButton(
                //   buttonText: MyStrings.signUpPageButton,
                //   onPressed: () async {
                //     Restaurant rs = Restaurant(
                //         restaurant_name: "Pizza One",
                //         restaurant_address: "none",
                //         restaurant_email: "pizzaone@gmail.com",
                //         restaurant_website: "",
                //         delivery_time: "40",
                //         delivery_cost: "150",
                //         vendorID: "344598");
                //     final provider = Provider.of<GoogleSignInProvider>(context,
                //         listen: false);
                //     await provider.googleLogin();
                //     context.read<RestaurantProvider>().addNewRestaurant(rs);
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) =>
                //     //         const VendorNavBarNavigationPage(),
                //     //   ),
                //     // );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidInt(String input) {
    final exp = RegExp('[0-9]+');
    return exp.hasMatch(input);
  }
}
