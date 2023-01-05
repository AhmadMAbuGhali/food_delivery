import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../models/cart_models.dart';
import '../models/products_models.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];

  List<ProductModel> get popularProductList => _popularProductList;

  late CartController _cart;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;

  int get quantity => _quantity;

  int _inCartItem = 0;

  int get inCartItem => _inCartItem + quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductRepo();
    if (response.statusCode == 200) {
      _isLoaded = true;
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList);
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);

    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItem + quantity) < 0) {
      Get.snackbar(
        "item Count",
        "you can't reduce more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItem>0){
        _quantity = -_inCartItem;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItem + quantity) > 20) {
      Get.snackbar("item Count", "you can't add more",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(CartController cart, ProductModel product) {
    _quantity = 0;
    _inCartItem = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    print(exist.toString());
    if (exist) {
      _inCartItem = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    // if (quantity > 0) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItem = _cart.getQuantity(product);


    update();
  }

  int get totalItem {
    return _cart.totalItem;
  }

  List<CartModel> get getItems{
    return  _cart.getItems;
  }
}
