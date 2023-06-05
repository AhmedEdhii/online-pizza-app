import '../entities/delivery_address.dart';

class User {
  final String userid;
  String name;
  String email;
  // final String phone;
  final List<DeliveryAddress> delivery_addresses;
  final String avatar_url;
  final String userRole;
  final List<String>? subscribed_Restaurants;
  final bool isVendorPending;
  // final List<String> cards;

  User(
      {required this.userid,
      required this.name,
      required this.email,
      // required this.phone,
      required this.delivery_addresses,
      required this.avatar_url,
      required this.userRole,
      this.subscribed_Restaurants,
      required this.isVendorPending
      // required this.cards,
      });

  static User fromJson(Map<String, dynamic> json, String id) => User(
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        delivery_addresses: json["delivery_addresses"] != null
            ? new List<DeliveryAddress>.from(json["delivery_addresses"]
                .map((x) => DeliveryAddress.fromJson(x)))
            : <DeliveryAddress>[],
        avatar_url: json['avatar_url'] as String? ?? '',
        userid: id,
        isVendorPending: json['isVendorPending'] as bool? ?? false,
        userRole: json['userRole'] as String? ?? '',
        subscribed_Restaurants: (json['subscribed_Restaurants'] as List?)
                ?.map((item) => item as String)
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'name': name,
        'email': email,
        // 'phone': phone,
        'delivery_addresses': List<dynamic>.from(
            delivery_addresses!.map((x) => x.toJson()).toList()),
        // 'delivery_addresses':
        //     delivery_addresses!.map((x) => x.toJson()).toList(),
        'avatar_url': avatar_url,
        'isVendorPending': isVendorPending,
        'userRole': userRole,
        // 'subscribed_Restaurants': subscribed_Restaurants,
      };
}
