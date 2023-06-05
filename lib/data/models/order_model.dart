import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Order {
  final String orderID;
  final String restaurantID;
  final String restaurantName;
  final String userid;
  final List<CartItem> order_items;
  final String delivery_cost;
  final String order_status;
  final DateTime? order_date;
  final String total_price;
  final String additional_instructions;
  final String delivery_address;
  final String payment_method;

  Order(
      {this.orderID = "",
      required this.restaurantID,
      required this.restaurantName,
      required this.userid,
      required this.order_items,
      required this.delivery_cost,
      this.order_status = "inProcess",
      this.order_date,
      required this.total_price,
      required this.additional_instructions,
      required this.delivery_address,
      required this.payment_method});

  factory Order.fromJson(Map<String, dynamic> json, String id) => Order(
        restaurantID: json['restaurantID'] as String? ?? '',
        restaurantName: json['restaurantName'] as String? ?? '',
        userid: json['userid'] as String? ?? '',
        // order_items:
        //     (json['order_items'] as List<Item>)?.map((item) => item).toList() ??
        //         [],
        order_items: json["order_items"] != null
            ? new List<CartItem>.from(
                json["order_items"].map((x) => CartItem.fromJson(x)))
            : <CartItem>[],
        // order_items: List<CartItem>.from(
        //     json["order_items"].map((x) => CartItem.fromJson(x))),
        delivery_cost: json['delivery_cost'] as String? ?? '',
        order_status: json['order_status'] as String? ?? '',
        order_date: (json["order_date"] as Timestamp).toDate(),
        total_price: json['total_price'] as String? ?? '',
        additional_instructions:
            json['additional_instructions'] as String? ?? '',
        delivery_address: json['delivery_address'] as String? ?? '',
        payment_method: json['total_price'] as String? ?? '',
        orderID: id,
      );

  Map<String, dynamic> toJson() => {
        // 'orderID': orderID,
        'restaurantID': restaurantID,
        'restaurantName': restaurantName,
        'userid': userid,
        "order_items": List<dynamic>.from(order_items.map((x) => x.toJson())),
        'delivery_cost': delivery_cost,
        'order_status': order_status,
        'order_date': DateTime.now(),
        'total_price': total_price,
        'additional_instructions': additional_instructions,
        'delivery_address': delivery_address,
        'payment_method': payment_method
      };
}
