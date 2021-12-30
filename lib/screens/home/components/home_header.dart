import 'package:flutter/material.dart';

import 'package:furniture_app/entity/cart.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/screens/cart/cart_screen.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SearchField(),
          StreamBuilder(
            stream: context
                .watch<InitProvider>()
                .cartDao
                .getAllItemInCartAllByUid("bao"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var list = snapshot.data as List<Cart>;
                return IconBtnWithCounter(
                  svgSrc: "assets/icons/Cart Icon.svg",
                  numOfItems: list.length > 0
                      ? list
                          .map<int>((e) => e.quantity)
                          .reduce((value, element) => value + element)
                      : 0,
                  press: () => Navigator.pushNamed(
                      context, CartScreen.routeName,
                      arguments: list.length > 0
                          ? list
                              .map<int>((e) => e.quantity)
                              .reduce((value, element) => value + element)
                          : 0),
                );
              }
              return Text("x");
            },
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfItems: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
