import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:furniture_app/size_config.dart';
import '../../../components/product_cart.dart';
import 'category.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_products.dart';
import 'section_title.dart';
import 'special_ofers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            HomeHeader(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            DiscountBanner(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            Categories(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            SpecialOffers(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
            const PopularProducts(),
            SizedBox(
              height: getProportionateScreenWidth(30),
            ),
          ],
        ),
      ),
    );
  }
}
