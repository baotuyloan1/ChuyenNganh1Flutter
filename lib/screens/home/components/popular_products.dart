import 'package:flutter/material.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:furniture_app/readAPI/getData/product_json.dart';
import 'package:furniture_app/screens/details/details_screen.dart';

import '../../../size_config.dart';
import 'section_title.dart';
import '../../../components/product_cart.dart';
import '../../../config.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(text: "New Products", press: () {}),
        SizedBox(
          height: getProportionateScreenWidth(20),
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder<List<ProductModel>>(
                future: GetProductAPI().getNewProduct(getDataUrl),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    return Row(
                      children: [
                        ...List.generate(snapshot.data!.length, (index) {
                          if (snapshot.data![index].productStatus == 1) {
                            return Row(
                              children: [
                                ProductCard(
                                  product: snapshot.data![index],
                                  press: () => Navigator.pushNamed(
                                      context, DetailsScreen.routeName,
                                      arguments: ProductDetailsArguments(
                                          productModel: snapshot.data![index])),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(20),
                                ),
                              ],
                            );
                          }
                          return const SizedBox(
                            width: 0,
                            height: 0,
                          );
                        }),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
      ],
    );
  }
}
