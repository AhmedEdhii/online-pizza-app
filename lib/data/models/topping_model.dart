class Topping {
  final String toppingID;
  final String toppingName;
  final String toppingPrice;
  final String restaurantID;

  Topping({
    required this.toppingID,
    required this.toppingName,
    required this.toppingPrice,
    this.restaurantID='',
  });

  Map<String, dynamic> toJson() => {
        "toppingID": toppingID,
        "toppingName": toppingName,
        "toppingPrice": toppingPrice,
        "restaurantID": restaurantID,
      };

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        toppingID: json["toppingID"],
        toppingName: json["toppingName"],
        toppingPrice: json["toppingPrice"],
        restaurantID: json["restaurantID"],
      );
}
