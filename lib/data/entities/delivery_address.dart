class DeliveryAddress {
  final String id;
  final String address_nick;
  final String address;

  DeliveryAddress({
    this.id = '',
    required this.address_nick,
    required this.address,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        id: json["id"] as String? ?? '',
        address_nick: json["address_nick"] as String? ?? '',
        address: json["address"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'address_nick': address_nick,
        'address': address,
      };
}
