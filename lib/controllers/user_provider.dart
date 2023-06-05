import 'package:flutter/material.dart';
import 'package:online_pizza/data/entities/delivery_address.dart';
import 'package:online_pizza/data/repository/user_repo.dart';

import '../data/models/user_model.dart';

class UserProvider with ChangeNotifier {
  List<User> users = [];

  bool isFetching = false;
  User current_user = User(
      userid: "",
      name: "",
      email: "",
      avatar_url: "",
      userRole: "",
      delivery_addresses: [],
      isVendorPending: false);

  List<DeliveryAddress> userAddressList = [];
  bool isCurrentUserUpdated = false;
  bool fetchingOrders = false;
  bool fetchingAddresses = false;
  bool addressExists = false;
  bool isUpdated = false;
  String selectedAddressNick = '';
  String selectedDeliveryAddress = '';
  List<String> nicks = [];

  final UserRepo _userRepo = FirebaseUsersRepository();

  Future<bool> getCurrentUser() async {
    current_user = await _userRepo.fetchCurrentUser();
    //print("userid in provider" + current_user.userRole);
    notifyListeners();
    return true;
  }

  Future<void> updateCurrentUser(String userID, User user) async {
    isCurrentUserUpdated = await _userRepo.updateCurrentUser(userID, user);
    // print("userid in provider" + current_user.userRole);
    //print(isCurrentUserUpdated);
    notifyListeners();
  }

  Future<bool> AddressExists(DeliveryAddress delivery_Address) async {
    await fetchUserAddresses(current_user.userid);
    bool flag = false;
    for (DeliveryAddress userAddress in userAddressList) {
      if (userAddress.address == delivery_Address.address ||
          userAddress.address_nick == delivery_Address.address_nick) {
        flag = true;
        break;
      }
    }
    addressExists = flag;
    return addressExists;
  }

  Future<void> clearFlag() async {
    addressExists = false;
  }

  void updateDeliveryAddresses(DeliveryAddress delivery_Address) async {
    print(delivery_Address.address);
    await _userRepo.updateDeliveryAddresses(
        current_user.userid, delivery_Address);
    await fetchUserAddresses(current_user.userid);
  }

  void updateIsPending() async {
    await _userRepo.updateIsPending();
    //print("userid in provider" + current_user.userRole);
    notifyListeners();
  }

  Future<void> fetchUserAddresses(String userid) async {
    fetchingAddresses = true;
    await Future.delayed(
      const Duration(milliseconds: 400),
    );
    userAddressList = await _userRepo.fetchDeliveryAddresses(userid);
    fetchingAddresses = false;
    notifyListeners();
  }

  void setAddressNick(String newAddress) {
    selectedAddressNick = newAddress;
    print(selectedAddressNick);
  }

  Future<bool> setDeliveryAddress(String nick) async {
    await fetchUserAddresses(current_user.userid);
    bool flag = false;
    for (DeliveryAddress userAddress in userAddressList) {
      if (userAddress.address_nick == nick) {
        selectedDeliveryAddress = userAddress.address;
        flag = true;
        break;
      }
    }
    isUpdated = flag;
    return isUpdated;
  }

  void addNick(String nick) {
    if (!nicks.contains(nick)) {
      nicks.add(nick);
    }
    print(nick);
    fetchNick();
  }

  List<String> fetchNick() {
    return nicks;
  }

  void clearNick() {
    nicks = [];
    fetchNick();
  }
}
