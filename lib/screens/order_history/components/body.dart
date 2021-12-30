import 'package:flutter/material.dart';
import 'package:furniture_app/config.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/models/order_model.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/readAPI/getData/get_order_history.dart';
import 'package:furniture_app/size_config.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'dart:async'; // cho load du lieu
import 'dart:convert'; // su ly jn

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getProportionateScreenWidth(10)),
      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      child: FutureBuilder<dynamic>(
          future: GetOrderHistory().getOrderHistory(
              customer_id:
                  context.watch<InitProvider>().accountModel.id.toString()),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              if (snapshot.data == 0) {
                return Text("Order history is empty");
              }
              var orders = snapshot.data as List<OrderModel>;
              return SingleChildScrollView(
                child: Column(children: [
                  ...List.generate(orders.length, (index) {
                    return buildOrderItem(orders[index]);
                  })
                ]),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}

Column buildOrderItem(OrderModel orderModel) {
  return Column(
    children: [
      Divider(
        color: Colors.grey,
      ),
      SizedBox(
        height: getProportionateScreenWidth(10),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconText(
              const Icon(
                Icons.verified_user,
                color: kPrimaryColor,
              ),
              const Text(
                "Order Name",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          Text(
            orderModel.billingModel![0]["billing_name"],
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      SizedBox(
        height: getProportionateScreenWidth(10),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconText(
              Icon(
                Icons.today,
                color: kPrimaryColor,
              ),
              Text(
                "Order Date",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          Text(
            orderModel.createdAt.toString(),
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      SizedBox(
        height: getProportionateScreenWidth(10),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconText(
              const Icon(
                Icons.attach_money,
                color: kPrimaryColor,
              ),
              const Text(
                "Order Total",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          Text(
            "\$${orderModel.orderTotal}",
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconText(
              const Icon(
                Icons.attach_money,
                color: kPrimaryColor,
              ),
              const Text(
                "Adress",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          Text(
            "${orderModel.billingModel![0]["billing_address"]}",
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          orderStatus(orderModel.orderStatus.toString()),
          textButton(
              Row(
                children: [
                  Text(
                    "Order Details",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: kPrimaryColor,
                  ),
                ],
              ),
              () {})
        ],
      ),
    ],
  );
}

Widget orderStatus(String status) {
  Icon icon;
  Color? color;
  String? text;
  if (status == "0" || status == "processing" || status == "on-hold") {
    icon = const Icon(
      Icons.timer,
      color: kPrimaryColor,
    );
    color = Colors.orange;
    text = "processing";
  } else if (status == "1" || status == "completed") {
    icon = const Icon(
      Icons.check,
      color: Colors.orange,
    );
    color = Colors.green;
  } else if (status == "cancelled" ||
      status == "refunded" ||
      status == "failed") {
    icon = const Icon(
      Icons.clear,
      color: Colors.redAccent,
    );
  } else {
    icon = const Icon(
      Icons.clear,
      color: Colors.redAccent,
    );
    color = Colors.redAccent;
  }
  return iconText(
      icon,
      Text(
        "Order ${text}",
        style:
            TextStyle(fontSize: 15, color: color, fontWeight: FontWeight.bold),
      ));
}

Widget iconText(Icon iconWidget, Text textWidget) {
  return Row(
    children: [
      iconWidget,
      SizedBox(
        width: getProportionateScreenWidth(5),
      ),
      textWidget
    ],
  );
}

Widget textButton(Widget iconText, VoidCallback? onPressed) {
  return TextButton(
    onPressed: onPressed,
    child: iconText,
    style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: kPrimaryColor)))),
  );
}


