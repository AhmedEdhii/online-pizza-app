import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_pizza/controllers/cart_provider.dart';
import 'package:online_pizza/controllers/location_provider.dart';
import 'package:online_pizza/controllers/new_item_provider.dart';
import 'package:online_pizza/controllers/order_provider.dart';
import 'package:online_pizza/controllers/product_provider.dart';
import 'package:online_pizza/controllers/restaurant_provider.dart';
import 'package:online_pizza/controllers/review_provider.dart';
import 'package:online_pizza/controllers/topping_provider.dart';
import 'package:online_pizza/services/google_signin_service.dart';
import 'package:provider/provider.dart';
import 'package:online_pizza/ui/screens/myapp/myapp.dart';

import 'controllers/user_provider.dart';
import 'firebase_options.dart';

///dev brach push test

// App dev Project
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        // Providers Sorted Alphabetically
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => NewItemProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ToppingProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
