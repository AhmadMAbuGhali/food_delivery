import 'dart:convert';

import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_models.dart';

class CartRepo{
  final  SharedPreferences sharedPreferences;
CartRepo({required this.sharedPreferences});

List<String> cart=[];
List<String> cartHistory=[];
void addToCartList(List<CartModel> cartList){
  // sharedPreferences.remove(AppConstants.CART_List);
  // sharedPreferences.remove(AppConstants.CART_HISTORY_List);
  cart = [];
  /*
  * convert object because sharedPreferences Only accept String
  * */

  cartList.forEach((element) =>cart.add(jsonEncode(element)));

  sharedPreferences.setStringList(AppConstants.CART_List, cart);
  getCartList();

 print(sharedPreferences.getStringList(AppConstants.CART_List));
}

List<CartModel> getCartList(){
  List<String> carts =[];
  if(sharedPreferences.containsKey(AppConstants.CART_List)){
   carts =  sharedPreferences.getStringList(AppConstants.CART_List)!;

  }
  List<CartModel> cartList = [];


  carts.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
  return cartList;
}

List<CartModel> getCartHistoryList(){

  if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_List)){
    cartHistory=[];
    cartHistory =  sharedPreferences.getStringList(AppConstants.CART_HISTORY_List)!;
  }
  List<CartModel> cartListHistory = [];
  cartHistory.forEach((element) => cartListHistory.add(CartModel.fromJson(jsonDecode(element))) );
  return cartListHistory;
}

void addToCartHistoryList(){

  if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_List)){
    cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_List)!;
  }
  for(int i=0;i<cart.length;i++){
    cartHistory.add(cart[i]);
  }
  removeCart();
  sharedPreferences.setStringList(AppConstants.CART_HISTORY_List, cartHistory);
  getCartHistoryList();

  print("the lenght of history list is " + getCartHistoryList().length.toString());

}

  void removeCart() {
  cart = [];
    sharedPreferences.remove(AppConstants.CART_List);

  }
}