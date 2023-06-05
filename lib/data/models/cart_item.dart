import 'package:online_pizza/data/models/topping_model.dart';

class CartItem {
  final String id;
  final String name;
  final String quantity;
  final String size;
  final String unit_price;
  final String? img_url;
  final List<Topping>? toppings;

  CartItem({
    this.id = '',
    required this.name,
    required this.quantity,
    required this.size,
    required this.unit_price,
    required this.img_url,
    this.toppings,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"] as String? ?? '',
        name: json["name"] as String? ?? '',
        quantity: json["quantity"] as String? ?? '',
        size: json["size"] as String? ?? '',
        unit_price: json["unit_price"] as String? ?? '',
        img_url: json["img_url"] as String? ?? '',
        toppings: json["toppings"] != null
            ? new List<Topping>.from(
                json["toppings"].map((x) => Topping.fromJson(x)))
            : <Topping>[],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'size': size,
        'unit_price': unit_price,
        'img_url': img_url,
        "toppings": List<dynamic>.from(toppings!.map((x) => x.toJson())),
      };
}
