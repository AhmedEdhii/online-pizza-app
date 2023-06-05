import 'package:flutter/cupertino.dart';
import 'package:online_pizza/data/models/product_model.dart';
import 'package:online_pizza/data/repository/product_repo.dart';

class ProductProvider with ChangeNotifier {
  List<Product> allProducts = [];

  List<Product> featuredProducts = [];

  Product product = Product(
      product_name: '',
      product_type: '',
      product_description: '',
      base_price: '',
      isFeatured: false,
      restaurantID: '',
      productID: '');

  bool isProductAdding = false;
  bool isAllProductsFetching = false;
  bool isFeaturedProductsFetching = false;
  //bool isVendorFeaturedProductsFetching = false;

  // final RestaurantRepo _productRepoMock = MockRestaurantsRepository();

  final ProductRepo _productRepo = FirebaseProductRepo();

  void addNewProduct(Product product) async {
    isProductAdding = true;
    await _productRepo.addProduct(product);
    isProductAdding = false;
    notifyListeners();
  }

  void fetchProductsList(String restaurantID) async {
    isAllProductsFetching = true;
    allProducts = await _productRepo.fetchProductsList(restaurantID);
    isAllProductsFetching = false;
    notifyListeners();
  }

  void fetchVendorProductsList() async {
    isAllProductsFetching = true;
    allProducts = await _productRepo.fetchVendorProductsList();
    isAllProductsFetching = false;
    notifyListeners();
  }

  void fetchFeaturedProductsList(String restaurantID) async {
    isFeaturedProductsFetching = true;
    featuredProducts =
        await _productRepo.fetchFeaturedProductsList(restaurantID);
    isFeaturedProductsFetching = false;
    notifyListeners();
  }

  void fetchVendorFeaturedProductsList() async {
    isFeaturedProductsFetching = true;
    featuredProducts = await _productRepo.fetchVendorFeaturedProductsList();
    isFeaturedProductsFetching = false;
    notifyListeners();
  }
}
