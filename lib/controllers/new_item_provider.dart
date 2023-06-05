import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:online_pizza/data/models/product_model.dart';

import '../services/fire_storage_service.dart';

class NewItemProvider with ChangeNotifier {
  final Firebase_Storage_Service storage_service = Firebase_Storage_Service();

  // Product NewProduct = new Product(
  //     product_name: '',
  //     product_type: '',
  //     product_description: '',
  //     singleProductPrice: 0,
  //     isFeatured: false,
  //     restaurantID: '');
  late Product newProduct;

  String product_name = '';
  String product_description = '';
  String productImageURL = '';
  String singleProductPrice = '';
  bool isFeaturedSwitch = false;

  List<String> productSizes = List<String>.filled(4, '', growable: false);
  List<String> productPrices = List<String>.filled(4, '', growable: false);
  int? discount;

  bool isFetching = false;
  bool isSelecting = false;
  bool imageUplaoding = false;
  bool isSelected = false;
  bool settingDetails = false;

  File imageFile = File("");
  String imageName = '';
  String _selectedItemCategory = '';
  String uploadError = '';
  // String firebase_url = '';

  String get selectedCategory {
    return _selectedItemCategory;
  }

  bool get getisSelected {
    return isSelected;
  }

  bool get getisFeatured {
    return isFeaturedSwitch;
  }

  void clearProviders() async {
    imageFile = File("");
    changeIsSelected();
    imageName = '';
    product_name = '';
    product_description = '';
    productImageURL = '';
    imageUplaoding = false;
    isFeaturedSwitch = false;
    singleProductPrice = '';
    productSizes = List<String>.filled(4, '', growable: false);
    productPrices = List<String>.filled(4, '', growable: false);
    // notifyListeners();
  }

  void selectItem(String item_category) async {
    isSelecting = true;
    var category = item_category;
    _selectedItemCategory = category;
    isSelecting = false;
    if (getisSelected == false) changeIsSelected();
    notifyListeners();
  }

  // void clearImagePath() async {
  //   imageUplaoding = false;
  //   _selectedItemCategory = '';

  //   notifyListeners();
  // }

  void changeIsSelected() async {
    isSelected = !isSelected;

    notifyListeners();
  }

  void uploadImage() async {
    imageUplaoding = true;
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );
    if (results == null) {
      uploadError = ('No File Selected');
      return null;
    }
    final path = results.files.single.path!;
    final fileName = results.files.single.name;

    imageFile = File(path);
    imageName = fileName;

    final firebase_url =
        await storage_service.uploadImageToDefaultBucket(imageFile, imageName);
    productImageURL = firebase_url;

    notifyListeners();
  }

  void setProductDetails(
    String productName,
    String productDescription,
  ) async {
    product_name = productName;
    product_description = productDescription;
    // notifyListeners();
  }

  void createPizza(String productType, String restaurant_id) {
    newProduct = new Product(
      product_name: this.product_name,
      product_type: productType,
      product_description: this.product_description,
      isFeatured: isFeaturedSwitch,
      base_price: productPrices[0],
      product_sizes: productSizes,
      product_prices: productPrices,
      restaurantID: restaurant_id,
      product_image_url: productImageURL,
    );
    // notifyListeners();
  }

  void createProduct(String productType, String restaurant_id) {
    newProduct = new Product(
      product_name: product_name,
      product_type: productType,
      product_description: product_description,
      isFeatured: false,
      base_price: singleProductPrice,
      restaurantID: restaurant_id,
      product_image_url: productImageURL,
    );
    // notifyListeners();
  }

  void setProductPrice(String price) async {
    singleProductPrice = price;
    notifyListeners();
  }

  void markasFeatured() async {
    isFeaturedSwitch = !isFeaturedSwitch;
  }

  void addSize(String size) async {
    if (size == 'small') {
      productSizes[0] = size;
    }
    if (size == 'regular') {
      productSizes[1] = size;
    }
    if (size == 'large') {
      productSizes[2] = size;
    }
    if (size == 'jumbo') {
      productSizes[3] = size;
    }
    // print(productSizes);
  }

  void removeSize(String size) async {
    if (size == 'small') {
      productSizes[0] = '';
    }
    if (size == 'regular') {
      productSizes[1] = '';
    }
    if (size == 'large') {
      productSizes[2] = '';
    }
    if (size == 'jumbo') {
      productSizes[3] = '';
    }
  }

  void addPrice(String size, String price) async {
    if (size == 'small') {
      productPrices[0] = price;
    }
    if (size == 'regular') {
      productPrices[1] = price;
    }
    if (size == 'large') {
      productPrices[2] = price;
    }
    if (size == 'jumbo') {
      productPrices[3] = price;
    }
  }

  void removePrice(String size, String price) async {
    if (size == 'small') {
      productPrices[0] = '0';
    }
    if (size == 'regular') {
      productPrices[1] = '0';
    }
    if (size == 'large') {
      productPrices[2] = '0';
    }
    if (size == 'jumbo') {
      productPrices[3] = '0';
    }
  }
}
