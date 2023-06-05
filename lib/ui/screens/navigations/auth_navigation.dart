import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_pizza/controllers/user_provider.dart';
import 'package:online_pizza/ui/screens/login_page/login_page.dart';
import 'package:provider/provider.dart';

import '../user/home_page/home_page.dart';
import '../navbar_navigation_page.dart';
import 'role_navigation.dart';


class AuthNavigation extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return RoleNavigation();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error! Try Again'));
          } else {
            return LoginScreen();
          }
        }, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}