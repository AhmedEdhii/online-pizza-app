class Restaurant {
  String restaurant_name;
  String restaurant_address;
  String restaurant_email;
  final String restaurant_website;
  final String delivery_time;
  final String delivery_cost;
  final List<String>? subscribed_users;
  final String? cover_image_URL;
  final bool? isOpen;
  final bool? isCustomPizza;
  final String vendorID;
  final String restaurantID;
  final bool isApproved;

  Restaurant(
      {required this.restaurant_name,
      required this.restaurant_address,
      required this.restaurant_email,
      required this.restaurant_website,
      required this.delivery_time,
      required this.delivery_cost,
      this.subscribed_users,
      this.cover_image_URL,
      this.isOpen,
      this.isCustomPizza,
      required this.vendorID,
      this.restaurantID = "",
      this.isApproved = false
      // required this.cards,
      });

  static Restaurant fromJson(Map<String, dynamic> json, String id) =>
      Restaurant(
        restaurant_name: json['restaurant_name'] as String? ?? '',
        restaurant_address: json['restaurant_address'] as String? ?? '',
        restaurant_email: json['restaurant_email'] as String? ?? '',
        restaurant_website: json['restaurant_website'] as String? ?? '',
        delivery_time: json['delivery_time'] as String? ?? '',
        delivery_cost: json['delivery_cost'] as String? ?? '',
        subscribed_users: (json['subscribed_users'] as List?)
                ?.map((item) => item as String)
                .toList() ??
            [],
        cover_image_URL: json['cover_image_URL'] as String? ?? '',
        isOpen: json['isOpen'] as bool? ?? false,
        isCustomPizza: json['isCustomPizza'] as bool? ?? false,
        vendorID: json['vendorID'] as String? ?? '',
        restaurantID: id,
        isApproved: json['isApproved'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'restaurant_name': restaurant_name,
        'restaurant_address': restaurant_address,
        'restaurant_email': restaurant_email,
        'restaurant_website': restaurant_website,
        'delivery_time': delivery_time,
        'delivery_cost': delivery_cost,
        'subscribed_users': subscribed_users,
        'cover_image_URL': cover_image_URL,
        'isOpen': isOpen,
        'isCustomPizza': isCustomPizza,
        'vendorID': vendorID,
        'isApproved': isApproved,
        // 'restaurantID': restaurantID,
      };
}
