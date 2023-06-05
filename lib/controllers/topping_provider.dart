import 'package:flutter/material.dart';
import 'package:online_pizza/data/models/topping_model.dart';

class ToppingProvider with ChangeNotifier {
  List<Topping> toppings = [];
  bool isToppingAdding = false;

  void addTopping(Topping topping) async {
    isToppingAdding = true;
    toppings.add(topping);
    isToppingAdding = false;
    fetchToppings();
    notifyListeners();
  }

  void removeTopping(Topping topping) async {
    print(topping.toppingID);
    isToppingAdding = true;
    toppings.remove(topping);
    isToppingAdding = false;
    fetchToppings();
    notifyListeners();
  }

  Future<List<Topping>> fetchToppings() async {
    // print("fetchhhhhhhhhhhhhhhhhhhhh topping ---------------------------------------------");
    toppings.forEach((Topping topping) {
      print(topping.toppingID);
      print(topping.toppingName);
    });
    return toppings;
  }

  void initializeTopping() {
    toppings = [];
    fetchToppings();
    notifyListeners();
  }
}
