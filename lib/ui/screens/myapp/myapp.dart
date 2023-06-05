import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_pizza/ui/screens/myapp/myThemeData.dart';
import 'package:online_pizza/ui/screens/navigations/auth_navigation.dart';
import 'package:online_pizza/ui/screens/splash_screen/splash_screen.dart';
import 'package:online_pizza/ui/screens/vendor/approval_screen/approvaal_screen.dart';

import '../location/location_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return MaterialApp(
      theme: MyThemeData().themedata,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
