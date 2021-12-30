import 'package:flutter/material.dart';
import 'package:furniture_app/models/product_model.dart';

import '../../../config.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(8)),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(getImageDetailProductUrl +
                  widget.productModel.productImages![selectedImage]['name']),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.productModel.productImages!.length,
                (index) => buildSmallPreview(index))
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(15)),
        padding: EdgeInsets.all(getProportionateScreenHeight(8)),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
            border: Border.all(
                color: selectedImage == index
                    ? kPrimaryColor
                    : Colors.transparent),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Image.network(getImageDetailProductUrl +
            widget.productModel.productImages![index]['name']),
      ),
    );
  }
}
