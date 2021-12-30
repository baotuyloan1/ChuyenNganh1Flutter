import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({Key? key, required Widget widget})
      : _widget = widget,
        super(key: key);

  final Widget _widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Container(
        height: getProportionateScreenWidth(50),
        width: double.infinity,
        padding: EdgeInsets.only(
            left: getProportionateScreenWidth(30),
            right: getProportionateScreenWidth(20)),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: kSecondaryColor.withOpacity(0.09)),
            ),
            color: kSecondaryColor.withOpacity(0.1)),
        child: _widget,
      ),
    );
  }
}
