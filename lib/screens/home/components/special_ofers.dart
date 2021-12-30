import 'package:flutter/material.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/models/category_model.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:furniture_app/readAPI/getData/product_json.dart';
import 'package:furniture_app/screens/category/category_screen.dart';

import '../../../size_config.dart';
import 'section_title.dart';

import 'dart:async'; // cho load du lieu
import 'dart:convert'; // su ly json
import 'package:http/http.dart' as http;
import '../../../config.dart';

class SpecialOffers extends StatelessWidget {
  Future<List<CategoryModel>> getCategory() async {
    final response = await http.get(Uri.parse(getCategoryUrl));
    final list = ((json.decode(response.body)) as List<dynamic>)
        .map((value) => CategoryModel.fromJson(value))
        .toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          text: "Special for you",
          press: () {},
        ),
        SizedBox(
          height: getProportionateScreenWidth(20),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<List<CategoryModel>>(
            future: getCategory(),
            builder: (context, snapshotCategory) {
              if (snapshotCategory.hasError) {}
              if (snapshotCategory.hasData) {
                return Row(
                  children: [
                    ...List.generate(snapshotCategory.data!.length, (index) {
                      if (snapshotCategory.data![index].categoryStatus == 1) {
                        return FutureBuilder<List<ProductModel>>(
                            future: GetProductAPI().getProductFromCategory(
                                snapshotCategory.data![index].categoryId!),
                            builder: (context1, snapshotProduct) {
                              if (snapshotProduct.hasError) {
                                return Center(
                                  child: Text(snapshotProduct.error.toString()),
                                );
                              }
                              if (snapshotProduct.hasData) {
                                List<ProductModel>? products = [];
                                for (var item in snapshotProduct.data!) {
                                  if (item.productStatus == 1) {
                                    products.add(item);
                                  }
                                }
                                return Row(
                                  children: [
                                    SpecialOfferCard(
                                      category: snapshotCategory.data![index],
                                      press: () async {
                                        Navigator.pushNamed(
                                            context, CategoryScreen.routeName,
                                            arguments:
                                                ProductsCategoryArguments(
                                                    products: products,
                                                    categories:
                                                        snapshotCategory.data!,
                                                    categoryModel:
                                                        snapshotCategory
                                                            .data![index]));
                                      },
                                      numOfBrands: products.length,
                                      image: "",
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(20),
                                    ),
                                  ],
                                );
                              }
                              return const CircularProgressIndicator();
                            });
                      }
                      return const SizedBox(
                        width: 0,
                        height: 0,
                      );
                    })
                    // SpecialOfferCard(
                    //   image: "assets/images/Image Banner 2.png",
                    //   category: "Table",
                    //   numOfBrands: 16,
                    //   press: () {},
                    // ),

                    // SizedBox(
                    //   width: getProportionateScreenWidth(20),
                    // )
                  ],
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);
  final String image;
  final int numOfBrands;
  final GestureTapCallback press;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(242),
        height: getProportionateScreenWidth(100),
        child: GestureDetector(
          onTap: press,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Image.network(
                          getImageCategoryUrl + category.categoryImage!),
                    )),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color(0xFF686868).withOpacity(0.4),
                        Color(0xB7929191).withOpacity(0.15)
                      ])),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15),
                      vertical: getProportionateScreenWidth(10)),
                  child: Text.rich(
                    TextSpan(style: TextStyle(color: Colors.white), children: [
                      TextSpan(
                          text: "${category.metaKeyword}\n",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.bold)),
                      TextSpan(text: "${numOfBrands} Brands"),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
