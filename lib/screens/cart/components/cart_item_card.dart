import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:furniture_app/entity/cart.dart';
import 'package:furniture_app/provider/init_provider.dart';

import '../../../config.dart';
import '../../../constants.dart';
import '../../../models/cart_model.dart';
import '../../../size_config.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({Key? key, required this.cart}) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(88),
          child: AspectRatio(
            aspectRatio: 0.88, // chieu rong / chieu dai
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15)),
              child: Image.network(getImageProductUrl + cart.imageUrl),
            ),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(20),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cart.productName,
                style: TextStyle(fontSize: 16, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                        text: "\$${cart.price}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: kPrimaryColor),
                        children: []),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElegantNumberButton(
                      initialValue: cart.quantity,
                      decimalPlaces: 0,
                      minValue: 1,
                      maxValue: 100,
                      buttonSizeHeight: 20,
                      buttonSizeWidth: 25,
                      color: kPrimaryColor,
                      onChanged: (value) async {
                        cart.quantity = value.toInt();
                        await context
                            .read<InitProvider>()
                            .cartDao
                            .updateCart(cart);
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
