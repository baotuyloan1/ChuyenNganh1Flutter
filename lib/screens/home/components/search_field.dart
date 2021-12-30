import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/config.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:furniture_app/readAPI/postData/network.dart';
import 'package:furniture_app/screens/details/details_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  List<ProductModel> products = [];

  List<ProductModel> productsDisplay = [];

  ProductSearch _delegate = ProductSearch(products: []);

  @override
  void initState() {
    // TODO: implement initState
    fetchProduct().then((value) {
      setState(() {
        products.addAll(value);
        productsDisplay = products;
        _delegate = ProductSearch(products: products);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      // height: 50,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () async {
          await showSearch(
              context: context, delegate: ProductSearch(products: products));
        },
        child: TextField(
            onTap: () async {
              await showSearch(
                  context: context,
                  delegate: ProductSearch(products: products));
            },
            enabled: false,
            onChanged: (value) async {
              // setState(() {
              //     _productsDisplay = _products.where((element) {
              //       var productName = element.productName!.toLowerCase();
              //       return productName.contains(value);
              //     }).toList();
              //   });
              value = value.toLowerCase();
              setState(() {
                if (value.isEmpty) {
                } else {
                  showSearch(
                      context: context,
                      delegate: ProductSearch(products: products));
                }
              });
            },
            decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "Search Product",
                prefixIcon: const Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(9)))),
      ),
    );
  }
}

class ProductSearch extends SearchDelegate<String> {
  List<ProductModel> products;

  ProductSearch({required List<ProductModel> this.products});

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, '');
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_city,
            size: 120,
          ),
          Text(
            query,
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 64,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? products
        : products.where((element) {
            final productLower = element.productName!.toLowerCase();
            final queryLower = query.toLowerCase();

            return productLower.startsWith(queryLower);
          }).toList();
    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<ProductModel> suggestions) =>
      ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return ListTile(
              onTap: () {
                Navigator.pushNamed(context, DetailsScreen.routeName,
                    arguments:
                        ProductDetailsArguments(productModel: suggestion));
              },
              leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      fit: BoxFit.contain,
                      imageUrl: getImageProductUrl +
                          suggestion.productImage.toString())),
              title: Text(suggestion.productName.toString()),
            );
          });
}
