import 'package:flutter/material.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'components/body.dart';

import 'package:provider/provider.dart';

class DeliveryAddressScreen extends StatelessWidget {
  static String routeName = "/delivery_address";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Address"),
      ),
      body: const Body(),
    );
  }
}
