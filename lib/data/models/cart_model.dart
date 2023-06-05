import 'package:flutter/cupertino.dart';
import 'package:online_pizza/data/models/cart_item.dart';
import 'package:online_pizza/data/models/product_model.dart';

class Cart {
  final String restaurantID;
  final String subtotal_price;
  final String delivery_cost;
  final String total_price;
  final List<CartItem> cartItems;

  Cart(
      {required this.restaurantID,
      required this.subtotal_price,
      required this.delivery_cost,
      required this.total_price,
      required this.cartItems});

  factory Cart.fromJson(Map<String, dynamic> json, String id) => Cart(
        restaurantID: json['restaurantID'] as String? ?? '',
        subtotal_price: json['subtotal_price'] as String? ?? '',
        delivery_cost: json['delivery_cost'] as String? ?? '',
        total_price: json['total_price'] as String? ?? '',
        cartItems:
            List<CartItem>.from(json["cartItems"].map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'restaurantID': restaurantID,
        'subtotal_price': subtotal_price,
        'delivery_cost': delivery_cost,
        'total_price': total_price,
        "cartItems": List<dynamic>.from(cartItems.map((x) => x.toJson())),
      };
}
