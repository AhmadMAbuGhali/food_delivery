import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expendable_text.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetailPage extends StatelessWidget {
  int pageId;

  PopularFoodDetailPage({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>(), product);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOADS +
                          product.img!))),
            )),
        Positioned(
          top: Dimensions.height45,
          left: Dimensions.width20,
          right: Dimensions.width20,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.initial);
                },
                child: AppIcon(icon: Icons.arrow_back_ios)),
            GetBuilder<PopularProductController>(builder: (controller) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.cartPage);
                },
                child: Stack(
                  children: [
                    AppIcon(icon: Icons.shopping_cart_outlined),
                    Get.find<PopularProductController>().totalItem >= 1
                        ? Positioned(
                            right: 0,
                            top: 0,
                            child: AppIcon(
                              icon: Icons.circle,
                              size: 20,
                              iconColor: Colors.transparent,
                              backgroundColor: AppColors.mainColor,
                            ))
                        : Container(),
                    Get.find<PopularProductController>().totalItem >= 1
                        ? Positioned(
                            right: 3,
                            top: 3,
                            child: BigText(
                              text: Get.find<PopularProductController>()
                                  .totalItem
                                  .toString(),
                              size: 12,
                              color: Colors.white,
                            ))
                        : Container()
                  ],
                ),
              );
            })
          ]),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: Dimensions.popularFoodImgSize - 20,
          child: Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppColumn(
                  text: product.name!,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                BigText(
                  text: 'Introduce',
                  size: Dimensions.font20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                      child: ExpendableText(text: product.description!)),
                ),
              ],
            ),
          ),
        )
      ]),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
          height: 120,
          padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white),
              child: Row(children: [
                GestureDetector(
                  onTap: () {
                    popularProduct.setQuantity(false);
                  },
                  child: Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width10 / 2,
                ),
                BigText(text: popularProduct.inCartItem.toString()),
                SizedBox(
                  width: Dimensions.width10 / 2,
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.setQuantity(true);
                  },
                  child: Icon(
                    Icons.add,
                    color: AppColors.signColor,
                  ),
                )
              ]),
            ),
            GestureDetector(
              onTap: () {
                popularProduct.addItem(product);
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                height: Dimensions.bottomBarHeight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor),
                child: BigText(
                    text: "\$ ${product.price} | Add to cart",
                    color: Colors.white),
              ),
            ),
          ]),
        );
      }),
    );
  }
}
