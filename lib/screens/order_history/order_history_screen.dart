import 'package:flutter/material.dart';

import 'components/body.dart';

class OrderHistory extends StatelessWidget {
  static String routeName = "/order_history";

  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
      ),
      body: Body(),
    );
  }
}
