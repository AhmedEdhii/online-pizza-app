enum OrderStatus {
  Inprocess,
  Delivered,
  
}

class OrderStatusHelper {
  static String getValue(OrderStatus status) {
    switch (status) {
      case OrderStatus.Inprocess:
        return "Inprocess";
      case OrderStatus.Delivered:
        return "Delivered";
      default:
        return "";
    }
  }
}
