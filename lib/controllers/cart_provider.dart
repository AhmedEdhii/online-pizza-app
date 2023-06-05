import 'package:flutter/cupertino.dart';
import 'package:online_pizza/data/models/cart_item.dart';
import 'package:online_pizza/data/models/product_model.dart';
import 'package:online_pizza/data/models/topping_model.dart';

import 'package:online_pizza/services/fire_storage_service.dart';

class CartProvider with ChangeNotifier {
  final Firebase_Storage_Service storage_service = Firebase_Storage_Service();

  bool isAdding = false;
  bool isUpdating = false;

  int _count = 1;
  int _subtotal = 0;
  int _total = 0;
  int _deliveryCost = 0;
  String restaurantID = '';
  String restaurantName = '';
  String prevRestaurantID = '';
  String paymentMethod = '';
  List<CartItem> cartItems = [];
  String selectedSize = '';

  int currentProductPrice = 0;
  int currentCartPrice = 0;

  Product currentProduct = Product(
      product_name: '',
      product_type: '',
      product_description: '',
      base_price: '',
      isFeatured: false,
      restaurantID: '');

  String currentProductID = '';

  int get subtotal {
    return _subtotal;
  }

  int get total_price {
    return _total;
  }

  int get count {
    return _count;
  }

  int get deliveryCost {
    return _deliveryCost;
  }

  List<CartItem> get cart_items {
    return cartItems;
  }

  String get restaurant_id {
    return restaurantID;
  }

  void increment() async {
    var newCount = count + 1;
    _count = newCount;
    notifyListeners();
  }

  void decrement() async {
    var newCount = count - 1;
    if (newCount <= 0) {
      newCount = 1;
    }
    _count = newCount;
    notifyListeners();
  }

  void setCurrentProductPrice(String productPrice) async {
    currentProductPrice = int.parse(productPrice);
    print('This is the product price' + currentProductPrice.toString());
    print('This is the cart price' + currentCartPrice.toString());

    currentCartPrice = currentProductPrice;
    notifyListeners();
    // if (currentCartPrice == 0) {
    //   currentCartPrice = currentProductPrice;
    // }
    // else {
    //   var newPrice = currentCartPrice + currentProductPrice;
    //   currentCartPrice = newPrice;
    // }
    print('This is the product price' + currentProductPrice.toString());
    print('This is the cart price' + currentCartPrice.toString());
  }

  void increaseCurrentCartPrice(String productPrice) async {
    currentProductPrice = currentProductPrice + int.parse(productPrice);
    var newPrice = currentProductPrice * _count;
    currentCartPrice = newPrice;
    notifyListeners();
  }

  void decreaseCurrentCartPrice(String productPrice) async {
    currentProductPrice = currentProductPrice - int.parse(productPrice);
    var newPrice = currentProductPrice * _count;
    if (newPrice >= 0) {
      currentCartPrice = newPrice;
    }
    notifyListeners();
  }

  void increaseCurrentPriceByQty() async {
    var newPrice = currentProductPrice * _count;
    currentCartPrice = newPrice;
    notifyListeners();
  }

  void decreaseCurrentPriceByQty() async {
    var newPrice = currentProductPrice * _count;
    currentCartPrice = newPrice;
    if (newPrice >= 0) {
      currentCartPrice = newPrice;
    }
    notifyListeners();
  }

  void setInitialPrice(String basePrice) {
    currentCartPrice = int.parse(basePrice);
    currentProductPrice = int.parse(basePrice);
    //print(currentCartPrice);
    notifyListeners();
  }

  void setInitialQuantity() {
    _count = 1;
    notifyListeners();
  }

  void setSelectedSize(String size) {
    selectedSize = size;
    notifyListeners();
    print(selectedSize);
  }

  void setRestaurantID(String resID) {
    restaurantID = resID;
  }

  void setPreviousRestaurantID(String restaurantID) {
    prevRestaurantID = restaurantID;
  }

  bool isRestaurantDiff() {
    return prevRestaurantID != restaurantID;
  }

  void clearOtherProviders() {
    prevRestaurantID = '';
    restaurantID = '';
    _deliveryCost = 0;
    _subtotal = 0;
    _total = 0;
  }

  //  void set subtotal_price {
  //  return _subtotal;
  //  }
  //   String set total_price {
  //  return _total;
  //  }
  //   String set delivery_cost {
  //  return _delivery;
  //  }
  //  List<Item> set products {
  //  return _products;
  //  }

  // void addToCart(CartItem item) async {
  //   if (isResDiff) {
  //     cartItems = [];
  //     fetchCartItems();
  //   }
  //   isAdding = true;
  //   cartItems.add(item);
  //   fetchCartItems();
  //   updateSubTotal(cart_items);
  //   isAdding = false;

  //   notifyListeners();
  // }

  void addToCart(
      String productName, String img_url, List<Topping> toppings) async {
    // print("addtocart");
    // print(currentProductPrice);
    // print(currentCartPrice);
    isAdding = true;
    CartItem newLineItem = CartItem(
      toppings: toppings,
      name: productName,
      quantity: _count.toString(),
      size: selectedSize,
      unit_price: currentProductPrice.toString(),
      img_url: img_url,
    );
    cartItems.add(newLineItem);
    fetchCartItems();
    updateSubTotal();
    notifyListeners();
  }

  void deleteFromCart(int index) {
    cartItems.removeAt(index);
    fetchCartItems();
    updateSubTotal();
    if (cartItems.length == 0) {
      _deliveryCost = 0;
      _total = 0;
      _subtotal = 0;
    }
    notifyListeners();
  }

  void clearCart() {
    cartItems = [];
    fetchCartItems();
  }

  List<CartItem> fetchCartItems() {
    return cartItems;
  }

  void updateSubTotal() async {
    isUpdating = true;
    _subtotal = 0;
    int item_total = 0;
    //print("cart provider");
    cartItems.forEach((CartItem cart) {
      //print(cart.quantity);
      //print(cart.price);
      item_total = int.parse(cart.unit_price) * int.parse(cart.quantity);
      _subtotal = _subtotal + item_total;
      //print(_subtotal);
    });
    //print(item_total);
    isUpdating = false;
  }

  void updateTotal(String deliveryCost) async {
    if (deliveryCost != '') {
      _total = 0;
      isUpdating = true;
      _total = _subtotal + int.parse(deliveryCost);
      isUpdating = false;
    }
  }

  void setDeliveryCost(String deliveryCost) async {
    if (deliveryCost != '') {
      _deliveryCost = int.parse(deliveryCost);
    }
  }

  void setPaymentMethod(String paymentMethod) async {
    this.paymentMethod = paymentMethod;
  }

  void initializePaymentMethod() async {
    this.paymentMethod = '';
  }
}
