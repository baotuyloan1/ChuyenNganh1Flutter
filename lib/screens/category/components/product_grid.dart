import 'package:flutter/material.dart';
import 'package:furniture_app/components/product_cart.dart';
import 'package:furniture_app/config.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/entity/cart.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/provider/quantity_detail_provider.dart';
import 'package:furniture_app/screens/details/details_screen.dart';
import 'package:furniture_app/size_config.dart';

import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductModel>? products;
  const ProductGrid({Key? key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: getProportionateScreenWidth(15),
          ),
          Container(
            width: SizeConfig.screenWidth - getProportionateScreenWidth(30),
            height: SizeConfig.screenHeight - getProportionateScreenHeight(240),
            child: GridView.count(
              crossAxisCount: 2,
              primary: false,
              crossAxisSpacing: getProportionateScreenWidth(10),
              mainAxisSpacing: getProportionateScreenWidth(15),
              childAspectRatio: 0.8,
              children: [
                ...List.generate(products!.length, (index) {
                  return _buildCard(products![index], context);
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(ProductModel productModel, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(10),
          right: getProportionateScreenWidth(5)),
      child: InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3.0,
                      blurRadius: 5.0)
                ],
                color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      productModel.productStatus == 1
                          ? Icon(Icons.favorite, color: kPrimaryColor)
                          : Icon(
                              Icons.favorite_border,
                              color: kSecondaryColor,
                            )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, DetailsScreen.routeName,
                        arguments: ProductDetailsArguments(
                            productModel: productModel));
                  },
                  child: Hero(
                      tag: productModel.productImage!,
                      child: Container(
                        height: getProportionateScreenWidth(75),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(getImageProductUrl +
                                  productModel.productImage!),
                              fit: BoxFit.contain),
                        ),
                      )),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(7),
                ),
                Text(
                  "\$${productModel.productPrice.toString()}",
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "${productModel.productName}",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(8.0)),
                        child: Container(
                          color: kSecondaryColor,
                          height: getProportionateScreenWidth(1.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(5),
                            right: getProportionateScreenWidth(5)),
                        child: GestureDetector(
                          onTap: () async {
                            var cartProduct = await context
                                .read<InitProvider>()
                                .cartDao
                                .getItemInCartByUid(
                                    "bao", productModel.productId!);
                            if (cartProduct != null) {
                              cartProduct.quantity = cartProduct.quantity + 1;
                              await context
                                  .read<InitProvider>()
                                  .cartDao
                                  .updateCart(cartProduct);
                            } else {
                              Cart cart = Cart(
                                  id: productModel.productId!,
                                  uid: "bao",
                                  productName: productModel.productName!,
                                  categoryProduct: productModel.categoryId!,
                                  imageUrl: productModel.productImage!,
                                  price: productModel.productPrice!,
                                  quantity: 1);
                              await context
                                  .read<InitProvider>()
                                  .cartDao
                                  .insertCart(cart);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.shopping_basket,
                                color: kPrimaryColor,
                                size: getProportionateScreenWidth(12),
                              ),
                              Text(
                                'Add to cart',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: getProportionateScreenWidth(12)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
