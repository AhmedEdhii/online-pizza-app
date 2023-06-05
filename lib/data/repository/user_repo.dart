import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:online_pizza/data/entities/delivery_address.dart';
import 'package:online_pizza/data/models/user_model.dart';
import 'package:online_pizza/data/user_roles.dart';

abstract class UserRepo {
  // Future<List<User>> fetchUserList();
  // Future<void> addUser(User user);
  Future<User> fetchCurrentUser();
  Future<bool> updateCurrentUser(String userID, User user);
  Future<void> updateDeliveryAddresses(
      String userID, DeliveryAddress deliveryAddress);
  Future<void> updateIsPending();
  Future<bool> doesAddressExists(DeliveryAddress delivery_Address);
  Future<List<DeliveryAddress>> fetchDeliveryAddresses(String userid);
}

class FirebaseUsersRepository implements UserRepo {
  final db = FirebaseFirestore.instance;

  CollectionReference firebaseUser =
      FirebaseFirestore.instance.collection('Users');

  @override
  Future<User> fetchCurrentUser() async {
    User current_user = User(
        userid: "",
        name: "",
        email: "",
        avatar_url: "",
        userRole: "",
        delivery_addresses: [],
        isVendorPending: false);

    if (auth.FirebaseAuth.instance.currentUser != null) {
      final auth_user = auth.FirebaseAuth.instance.currentUser!;
      //print("auth_user" + auth_user.uid);
      await firebaseUser.doc(auth_user.uid).get().then((doc) {
        // Load User from Firebase to User Provider
        if (doc.exists) {
          current_user =
              User.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        }
      });
    }
    return current_user;
  }

  @override
  Future<bool> updateCurrentUser(String userID, User user) async {
    await db.collection("Users").doc(userID).update(user.toJson());
    return Future.value(true);
  }

  Future<bool> doesAddressExists(DeliveryAddress delivery_Address) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("Users")
        .where({
      "delivery_addresses",
      "array-contains",
      delivery_Address.toString()
    }).get();
    return query.docs.isNotEmpty;
  }

  @override
  Future<void> updateDeliveryAddresses(
      String userID, DeliveryAddress delivery_Address) async {
    await db.collection("Users").doc(userID).update({
      'delivery_addresses': FieldValue.arrayUnion([
        {
          'address': delivery_Address.address,
          'address_nick': delivery_Address.address_nick
        }
      ])
    });
  }

  Future<void> updateIsPending() async {
    final auth_user = auth.FirebaseAuth.instance.currentUser!;
    await db.collection("Users").doc(auth_user.uid).update({
      'isVendorPending': false,
    });
  }

  @override
  Future<List<DeliveryAddress>> fetchDeliveryAddresses(String userid) async {
    List<DeliveryAddress> address_list = [];
    await db
        .collection("Users")
        .where('userid', isEqualTo: userid)
        .get()
        .then((event) {
      User user = User.fromJson(event.docs.first.data(), event.docs.first.id);
      //print(user.delivery_addresses![0].address);
      final address = user.delivery_addresses;
      address_list = List<DeliveryAddress>.from(address!.map((x) => x));
      //print(address_list[0].address);
    });
    return address_list;
  }

  // @override
  // Future<List<User>> fetchUserList() async {
  //   List<User> users = [];
  //   await db.collection("Users").get().then((event) {
  //     // users = event.docs.map((e) => User.fromJson(e.data(), e.id)).toList();
  //   });
  //
  //   return users;
  // }

  // @override
  // Future<void> addUser(User user) async {
  //   db.collection('Users').add(user.toJson()).then(
  //     (value) {
  //       print("User added.");
  //     },
  //   ).catchError(
  //     // ignore: invalid_return_type_for_catch_error
  //     (error) => print("Failed to add Task: $error"),
  //   );
  // }
}

// class MockUsersRepository implements UserRepo {
//   final db = FirebaseFirestore.instance;
//   List<User> users = [
//     User(
//       userid: '309449',
//       name: 'Ebrahim Baig',
//       email: 'baig@gmail.com',
//       // phone: '01234',
//       // delivery_addresses: ['address 1', 'address 2'],
//       avatar_url:
//           'https://miro.medium.com/focal/70/70/50/50/1*L6gfDRU9iPXpWx978BzcOw.png',
//       userRole: UserRoles.user.name,
//       subscribed_Restaurants: null,
//     ),
//   ];
