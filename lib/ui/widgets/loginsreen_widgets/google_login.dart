import 'package:flutter/material.dart';
import 'package:online_pizza/constant/assets.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/constant/sizedbox.dart';
import 'package:online_pizza/constant/strings.dart';
import 'package:online_pizza/constant/styles.dart';
import 'package:provider/provider.dart';

import '../../../services/google_signin_service.dart';

// ignore: must_be_immutable
class GoogleSignup extends StatefulWidget {
  GoogleSignup({required this.signup, super.key});
  final VoidCallback signup;
  @override
  State<GoogleSignup> createState() => _GoogleSignupState();
}

class _GoogleSignupState extends State<GoogleSignup> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.signup,
      // onTap: () async {
      //   final provider =
      //       Provider.of<GoogleSignInProvider>(context, listen: false);
      //   provider.googleLogin();
      // },
      child: Container(
        width: 450,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: MyColors.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBoxes.horizontalMedium,
            SizedBox(
              height: 32,
              width: 32,
              child: Image.asset(ImageAssets.googleIcon),
            ),
            SizedBoxes.horizontalMedium,
            Text(
              MyStrings.loginPageGoogleSignUp,
              style: Styles.buttonText,
            )
          ],
        ),
      ),
    );
  }
}
