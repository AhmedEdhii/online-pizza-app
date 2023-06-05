import 'package:flutter/material.dart';
import 'package:online_pizza/constant/assets.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:online_pizza/controllers/user_provider.dart';
import 'package:online_pizza/ui/screens/vendor_navbar_navigation_page.dart';
import 'package:online_pizza/ui/screens/vendor/vendor_signup_form_page/vendor_signup_form_page.dart';
import 'package:online_pizza/ui/widgets/loginsreen_widgets/google_login.dart';
import 'package:online_pizza/ui/widgets/loginsreen_widgets/page_indicator.dart';
import 'package:online_pizza/ui/widgets/loginsreen_widgets/slider_widget.dart';
import 'package:online_pizza/ui/widgets/global_widgets/ui_button.dart'
    as ui_button;
import 'package:provider/provider.dart';

import '../../../services/google_signin_service.dart';
import '../navigations/auth_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<Widget> imglist = [
    PageSlider(
      image: ImageAssets.onboardingPizza,
      title: MyStrings.loginPageHeading,
      description: MyStrings.loginPageSubtext,
    ),
    const PageSlider(
      image: ImageAssets.onboardingDelivery,
      title: "Quick Delivery",
      description:
          "Get Pizza from your favourite restaurant at your doorstep within minutes.",
    ),
  ];
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 64, 16, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PageIndicator(
                    imglist: imglist,
                  ),
                  SizedBoxes.verticalGargangua,
                  GoogleSignup(
                    signup: () async {
                      bool isVendor = false;
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      final userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      await provider.googleLogin(isVendor);
                      bool isSignedIn = await provider.isSignedIn;
                      if (isSignedIn) {
                        userProvider.getCurrentUser();
                      }
                    },
                  ),
                ],
              ),
              ui_button.SecondaryFilledButton(
                buttonText: MyStrings.loginPageButton,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VendorSignupForm(),
                    ),
                  );
                },
                buttonSize: Size(450, 60),
                buttonColor: MyColors.uiBlock,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
