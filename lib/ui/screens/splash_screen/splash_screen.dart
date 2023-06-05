import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_pizza/constant/colors.dart';
import 'package:online_pizza/ui/screens/login_page/login_page.dart';

import '../../../constant/assets.dart';
import '../navbar_navigation_page.dart';
import '../navigations/role_navigation.dart';
import '../navigations/auth_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // void initState() {
  //   super.initState();
  //   getRoute();
  // }
  //
  // Future<void> getRoute () async {
  //   await _navigateUser();
  //   await AuthNavigation();
  // }
  //
  // Future<void> _navigateUser() async {
  //   await Future.delayed(Duration(milliseconds: 2000), () {});
  //   final user = FirebaseAuth.instance.currentUser!;
  //   if (user != null) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => AuthNavigation()));
  //   } else {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => LoginScreen()));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // child: Text("Splash Screen"),
          child: AnimatedSplashScreen(
            splash: ImageAssets.splashLogo,
            nextScreen: AuthNavigation(),
            // nextScreen: LoginScreen(),
            splashTransition: SplashTransition.scaleTransition,
            //pageTransitionType: PageTransitionType.scale,

            duration: 2500,
            backgroundColor: MyColors.splashScreen,
          ),
        ),
      ),
    );
  }
}
