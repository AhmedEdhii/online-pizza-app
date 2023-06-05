class Product {
  late final String product_name;
  final String product_type;
  final String product_description;
  final String base_price;
  final List<String>? product_sizes;
  final List<String>? product_prices;
  final String? product_image_url;
  final int? discount;
  final bool isFeatured;
  final bool isActive;
  final String restaurantID;
  final String productID;

  Product({
    required this.product_name,
    required this.product_type,
    required this.product_description,
    required this.base_price,
    this.product_sizes,
    this.product_prices,
    this.product_image_url,
    this.discount,
    required this.isFeatured,
    this.isActive = true,
    required this.restaurantID,
    this.productID = "",
    // required this.cards,
  });

  static Product fromJson(Map<String, dynamic> json, String id) => Product(
        product_name: json['product_name'] as String? ?? '',
        product_type: json['product_type'] as String? ?? '',
        product_description: json['product_description'] as String? ?? '',
        base_price: json['base_price'] as String ?? '',
        product_sizes: (json['product_sizes'] as List?)
                ?.map((item) => item as String)
                .toList() ??
            [],
        product_prices: (json['product_prices'] as List?)
                ?.map((item) => item as String)
                .toList() ??
            [],
        product_image_url: json['product_image_url'] as String? ?? '',
        discount: json['discount'] as int? ?? 0,
        isFeatured: json['isFeatured'] as bool? ?? false,
        isActive: json['isActive'] as bool? ?? false,
        restaurantID: json['restaurantID'] as String? ?? '',
        productID: id,
      );

  Map<String, dynamic> toJson() => {
        'product_name': product_name,
        'product_type': product_type,
        'product_description': product_description,
        'base_price': base_price,
        'product_sizes': product_sizes,
        'product_prices': product_prices,
        'product_image_url': product_image_url,
        'isFeatured': isFeatured,
        'isActive': isActive,
        'restaurantID': restaurantID,
      };
}
