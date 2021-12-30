import 'package:flutter/material.dart';
import 'package:furniture_app/components/custom_suffix_icon.dart';
import 'package:furniture_app/entity/cart.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:provider/src/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

StreamBuilder PaymentCost(BuildContext context, double total) {
  return StreamBuilder<Object>(
      stream:
          context.read<InitProvider>().cartDao.getAllItemInCartAllByUid("bao"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var list = snapshot.data as List<Cart>;
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Sub Total"),
                    Text(
                      "\$${list.isNotEmpty ? list.map<double>((e) => double.parse((e.price * e.quantity).toString())).reduce((value, element) => value + element) : 0}",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenWidth(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Delivery Cost"),
                    Text(
                      "\$${list.isNotEmpty ? list.map<double>((e) => double.parse((e.price * e.quantity * (1 / 100)).toStringAsFixed(2).toString())).reduce((value, element) => value + element).toStringAsFixed(2) : 0}",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenWidth(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Discount"),
                    Text(
                      "\$0",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenWidth(10),
                ),
                Divider(
                  height: getProportionateScreenWidth(10),
                  color: kSecondaryColor.withOpacity(0.25),
                  thickness: 2,
                ),
                SizedBox(
                  height: getProportionateScreenWidth(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total"),
                    Text(
                      "\$${total.toString()}",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
      });
}
