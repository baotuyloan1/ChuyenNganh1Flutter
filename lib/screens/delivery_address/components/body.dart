import 'package:flutter/material.dart';

import 'package:furniture_app/screens/delivery_address/components/delivery_address_form.dart';
import 'package:furniture_app/size_config.dart';

import '../../../components/socal_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key, double? subtotal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: SizeConfig.screenHeight * 0.03), //8% of total height
              DeliveryAddressForm(),
              SizedBox(
                  height: SizeConfig.screenHeight * 0.07), //8% of total height
              Text(
                "By continuing your confirm that you agree to \nwith our Term and Condition",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
