import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';
import '../models/cart_models.dart';
import '../models/products_models.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class RecommendedProductController extends GetxController{

  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<ProductModel> _recommendedProductList= [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  late CartController _cart;



  int _quantity = 0;

  int get quantity => _quantity;

  int _inCartItem = 0;

  int get inCartItem => _inCartItem + quantity;


  Future<void> getRecommendedProductList()async{
    Response response = await recommendedProductRepo.getRecommendedProductRepo();
    if(response.statusCode==200){
      _isLoaded =true;
      _recommendedProductList=[];
      _recommendedProductList.addAll(Product .fromJson(response.body).products);
      print(_recommendedProductList);
      update();
    }else{

    }
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