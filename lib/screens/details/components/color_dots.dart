import 'package:flutter/material.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/provider/quantity_detail_provider.dart';

import '../../../constants.dart';
import '../../../models/product_model.dart';
import '../../../components/rounded_icon_btn.dart';
import '../../../size_config.dart';
import 'package:provider/provider.dart';

class ColorDots extends StatelessWidget {
  const ColorDots({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    int selectedColor = 3;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ...List.generate(
              productModel.colors!.length,
              (index) => ColorDot(
                    color: productModel.colors![index],
                    isSelected: selectedColor == index,
                  )),
          Spacer(),
          if (context.watch<QuantityDetailProvider>().quantity > 1)
            RoundedIconBtn(
              icon: Icons.remove,
              press: () {
                context.read<QuantityDetailProvider>().decreaseItem();
              },
            ),
          const SizedBox(
            width: 15,
          ),
          Text(context.watch<QuantityDetailProvider>().quantity.toString()),
          const SizedBox(
            width: 15,
          ),
          RoundedIconBtn(
              icon: Icons.add,
              press: () {
                context.read<QuantityDetailProvider>().increaseItem();
              })
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({Key? key, required this.color, this.isSelected = false})
      : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 2),
      padding: const EdgeInsets.all(8),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
          // color: productModel.colors![0],
          shape: BoxShape.circle,
          border: Border.all(
              color: isSelected ? kPrimaryColor : Colors.transparent)),
      child: DecoratedBox(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
