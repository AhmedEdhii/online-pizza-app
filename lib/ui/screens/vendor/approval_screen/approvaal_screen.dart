import 'package:flutter/material.dart';
import 'package:online_pizza/constant/assets.dart';
import 'package:online_pizza/controllers/restaurant_provider.dart';
import 'package:online_pizza/controllers/user_provider.dart';
import 'package:online_pizza/ui/screens/navigations/auth_navigation.dart';
import '../../../widgets/global_widgets/ui_button.dart' as ui_button;

import 'package:provider/provider.dart';

import '../../../../constant/app_icons.dart';
import '../../../../constant/sizedbox.dart';
import '../../../../constant/styles.dart';
import '../../../../services/google_signin_service.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({super.key});

  @override
  State<ApprovalScreen> createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RestaurantProvider>().fetchVendorRestaurant();
  }

  bool condition = true;
  @override
  Widget build(BuildContext context) {
    final restaurant = context.watch<RestaurantProvider>().restaurant;
    return Scaffold(
      body: context.watch<RestaurantProvider>().isRestaurantFetching
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: !restaurant.isApproved
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 132,
                          // width: 134,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ImageAssets.waitingIcon),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                        SizedBoxes.verticalBig,
                        Text(
                          'You’ve successfully Applied to Become a Merchant',
                          style: Styles.H1,
                          textAlign: TextAlign.center,
                        ),
                        SizedBoxes.verticalTiny,
                        Text(
                          'Your application is will be processed in 2-3 business days. You’ll be notified once your application has been processed.',
                          style: Styles.body14px,
                          textAlign: TextAlign.center,
                        ),
                        SizedBoxes.verticalBig,
                        ui_button.IconButton(
                          buttonText: 'LOG OUT',
                          onPressed: () {
                            final provider = Provider.of<GoogleSignInProvider>(
                                context,
                                listen: false);
                            provider.logout();
                          },
                          buttonSize: const Size(360, 56),
                          icon: AppIcons.logout,
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 140,
                          // width: 134,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ImageAssets.approvedIcon),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                        SizedBoxes.verticalBig,
                        Text(
                          'Congratulations!',
                          style: Styles.H1,
                          textAlign: TextAlign.center,
                        ),
                        SizedBoxes.verticalTiny,
                        Text(
                          'Your application has been approved.',
                          style: Styles.body14px,
                          textAlign: TextAlign.center,
                        ),
                        SizedBoxes.verticalBig,
                        ui_button.FilledButton(
                          buttonText: 'Proceed to Vendor Dashboard',
                          onPressed: () {
                            final provider = Provider.of<UserProvider>(
                                context,
                                listen: false);
                            provider.updateIsPending();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AuthNavigation(),
                              ),
                            );
                          },
                        ),
                      ],
                    )),
    );
  }
}
