import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_pizza/data/entities/delivery_address.dart';
import 'package:online_pizza/data/entities/user_auth.dart';
import 'package:online_pizza/data/models/user_model.dart' as UserModel;

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  bool isSignedIn = false;

  GoogleSignInAccount? _user;

  UserAuth user_auth = UserAuth(uid: "", email: "", name: "", photoUrl: "");
  OAuthCredential? credential;

  GoogleSignInAccount get user => _user!;

  FirebaseAuth auth = FirebaseAuth.instance;
  var current_user;
  bool isAccountUnique = true;

  Future googleLogin(bool isVendor) async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      credential = await GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential!);
      current_user = await FirebaseAuth.instance.currentUser;
      await addGoogleUserToEntity();
      await RegisterUser(isVendor);
      isSignedIn = true;
      // await RegisterUser(credential, user_auth);
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future RegisterUser(bool isVendor) async {
    print("----------------------------------");
    current_user = await FirebaseAuth.instance.currentUser!;
    UserCredential userCredential =
        await auth.signInWithCredential(credential!);
    DocumentSnapshot userExist = await FirebaseFirestore.instance
        .collection('Users')
        .doc(current_user.uid)
        .get();

    if (userExist.exists) {
      isAccountUnique = false;
      print("User already exists");
    } else {
      print("user not exist");
      print(current_user.uid);
      print(user_auth.photoUrl);
      print(user_auth.uid);
      print(user_auth.name);
      print(user_auth.email);
      //  User new_user = User(userid: userCredential.user!.uid, name: userCredential.user!.displayName, email: userCredential.user!.email, userCredential.user!.photoURL, userRole: "user");
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user_auth.uid)
          .set(UserModel.User(
                  isVendorPending: isVendor,
                  userid: user_auth.uid,
                  name: user_auth.name,
                  delivery_addresses: <DeliveryAddress>[],
                  email: user_auth.email,
                  avatar_url: user_auth.photoUrl,
                  userRole: "user")
              .toJson());
    }
  }

  Future addGoogleUserToEntity() async {
    String uid = await current_user.uid.toString();
    String email = await current_user.email.toString();
    String name = await current_user.displayName.toString();
    String URL = await current_user.photoURL.toString();
    user_auth = UserAuth(uid: uid, email: email, name: name, photoUrl: URL);
    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    isSignedIn = false;
  }
}
