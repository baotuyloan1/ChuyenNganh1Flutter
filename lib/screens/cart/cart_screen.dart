import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_app/components/default_button.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/entity/cart.dart';

import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/provider/price_provider.dart';
import 'package:furniture_app/screens/checkout/checkout_screen.dart';
import 'package:furniture_app/screens/checkout/components/order_details_argument.dart';

import 'package:furniture_app/size_config.dart';

import 'components/body.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PriceProvider(),
      child: StreamBuilder<Object>(
          stream: context
              .read<InitProvider>()
              .cartDao
              .getAllItemInCartAllByUid("bao"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var list = snapshot.data as List<Cart>;
              return Scaffold(
                appBar: buildAppBar(context, list),
                body: Body(
                  list: list,
                ),
                bottomNavigationBar: CheckOurCard(list: list),
              );
            } else {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          }),
    );
  }

  AppBar buildAppBar(BuildContext context, List<Cart> list) {
    return AppBar(
      title: Column(
        children: [
          const Text(
            "Your cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${list.isNotEmpty ? list.map<int>((e) => e.quantity).reduce((value, element) => value + element) : 0} items",
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}

class CheckOurCard extends StatelessWidget {
  List<Cart> list;
  CheckOurCard({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double total = 0;
    if (list.length > 0) {
      total = list
          .map<double>((e) => double.parse((e.price * e.quantity).toString()))
          .reduce((value, element) => value + element);
    }
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, -15),
                blurRadius: 20,
                color: const Color(0xFFDADADA).withOpacity(0.15))
          ]),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Container(
                padding: EdgeInsets.all(10),
                height: getProportionateScreenWidth(40),
                width: getProportionateScreenWidth(40),
                decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10)),
                child: SvgPicture.asset("assets/icons/receipt.svg"),
              ),
              const Spacer(),
              const Text("Add voucher code"),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: kTextColor,
              )
            ]),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(text: "Total:\n", children: [
                  TextSpan(
                      text: "\$${list.length > 0 ? total : 0}",
                      style: TextStyle(fontSize: 16, color: Colors.black))
                ])),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () async {
                      await context.read<InitProvider>().setSubTotal(total);
                      Navigator.pushNamed(context, CheckoutScreen.routeName,
                          arguments: total);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
