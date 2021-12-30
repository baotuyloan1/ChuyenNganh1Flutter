import 'package:flutter/material.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:furniture_app/provider/quantity_detail_provider.dart';
import 'package:provider/provider.dart';
import 'components/custom_app_bar.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return ChangeNotifierProvider(
      create: (_) => QuantityDetailProvider(),
      child: Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: CustomAppBar(
              rating: double.parse(agrs.productModel.productId!.toString())),
        ),
        body: Body(
          productModel: agrs.productModel,
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final ProductModel productModel;

  ProductDetailsArguments({required this.productModel});
}
