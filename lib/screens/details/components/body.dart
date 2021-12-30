import 'package:flutter/material.dart';
import 'package:furniture_app/components/default_button.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/entity/cart.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/screens/home/home_screen.dart';
import 'package:furniture_app/size_config.dart';

import '../../../models/product_model.dart';
import 'color_dots.dart';
import 'top_rounded_container.dart';
import 'product_description.dart';
import 'product_images.dart';
import 'package:provider/provider.dart';
import '../../../provider/quantity_detail_provider.dart';

class Body extends StatelessWidget {
  final ProductModel productModel;
  const Body({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    productModel.colors = [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImages(productModel: productModel),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  productModel: productModel,
                  pressOnSeeMore: () {},
                ),
                TopRoundedContainer(
                    color: const Color(0xFFF6F7F9),
                    child: Column(
                      children: [
                        ColorDots(productModel: productModel),
                        TopRoundedContainer(
                            color: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.15,
                                  right: SizeConfig.screenWidth * 0.15,
                                  top: getProportionateScreenWidth(15),
                                  bottom: getProportionateScreenWidth(40)),
                              child: DefaultButton(
                                  text: "Add to card",
                                  press: () async {
                                    var cartProduct = await context
                                        .read<InitProvider>()
                                        .cartDao
                                        .getItemInCartByUid(
                                            "bao", productModel.productId!);
                                    if (cartProduct != null) {
                                      cartProduct.quantity = cartProduct
                                              .quantity +
                                          context
                                              .read<QuantityDetailProvider>()
                                              .quantity
                                              .toInt();
                                      await context
                                          .read<InitProvider>()
                                          .cartDao
                                          .updateCart(cartProduct);
                                    } else {
                                      Cart cart = Cart(
                                          id: productModel.productId!,
                                          uid: "bao",
                                          productName:
                                              productModel.productName!,
                                          categoryProduct:
                                              productModel.categoryId!,
                                          imageUrl: productModel.productImage!,
                                          price: productModel.productPrice!,
                                          quantity: context
                                              .read<QuantityDetailProvider>()
                                              .quantity);
                                      await context
                                          .read<InitProvider>()
                                          .cartDao
                                          .insertCart(cart);
                                    }
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      backgroundColor: kPrimaryColor,
                                      content: const Text(
                                        "Add product success",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ));
                                  }),
                            ))
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
