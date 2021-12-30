import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/components/custom_bottom_nav_bar.dart';
import 'package:furniture_app/components/product_cart.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/entity/cart.dart';
import 'package:furniture_app/enums.dart';
import 'package:furniture_app/models/category_model.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/screens/cart/cart_screen.dart';
import 'package:furniture_app/screens/category/components/product_grid.dart';
import 'package:furniture_app/screens/home/components/icon_btn_with_counter.dart';
import 'package:furniture_app/size_config.dart';

import 'components/bottom_bar.dart';
import 'package:http/http.dart' as http;
import '../../../config.dart';
import 'dart:async'; // cho load du lieu
import 'dart:convert'; // su ly json
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  static String routeName = "/category";

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  Future<List<ProductModel>> getProductFromCategory(int categoryId) async {
    final response = await http.post(Uri.parse(getProductByCategoryId),
        body: {"categor_id": categoryId.toString()});
  
    final list = ((json.decode(response.body)) as List<dynamic>)
        .map((value) => ProductModel.fromJson(value))
        .toList();
    return list;
  }

  TabController? _tabController;
  ProductsCategoryArguments? agrs;
  int? indexx = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final ProductsCategoryArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductsCategoryArguments;
    _tabController = TabController(length: agrs.categories.length, vsync: this);
    int index = 0;
    for (var item in agrs.categories) {
      if (item.categoryId == agrs.categoryModel.categoryId) {
        _tabController!.animateTo(index);
      } else {
        index++;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Category",
              style: TextStyle(color: Colors.black),
            ),
            const Spacer(),
            StreamBuilder(
              stream: context
                  .watch<InitProvider>()
                  .cartDao
                  .getAllItemInCartAllByUid("bao"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var list = snapshot.data as List<Cart>;
                  return IconBtnWithCounter(
                    svgSrc: "assets/icons/Cart Icon.svg",
                    numOfItems: list.length > 0
                        ? list
                            .map<int>((e) => e.quantity)
                            .reduce((value, element) => value + element)
                        : 0,
                    press: () => Navigator.pushNamed(
                        context, CartScreen.routeName,
                        arguments: list.length > 0
                            ? list
                                .map<int>((e) => e.quantity)
                                .reduce((value, element) => value + element)
                            : 0),
                  );
                }
                return Text("x");
              },
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
              left: getProportionateScreenWidth(10),
              right: getProportionateScreenWidth(10)),
          children: <Widget>[
            TabBar(
              onTap: (index) {},
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: kPrimaryColor,
              isScrollable: true,
              labelPadding:
                  EdgeInsets.only(right: getProportionateScreenWidth(20)),
              unselectedLabelColor: kSecondaryColor,
              tabs: [
                ...List.generate(agrs.categories.length, (index) {
                  if (agrs.categories[index].categoryStatus == 1) {
                    return Tab(
                      child: Text(
                        "${agrs.categories[index].categoryName!}",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(16)),
                      ),
                    );
                  } else {
                    return const SizedBox(
                      width: 0,
                      height: 0,
                    );
                  }
                })
              ],
            ),
            Container(
              height:
                  SizeConfig.screenHeight - getProportionateScreenWidth(100),
              width: double.infinity,
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ...List.generate(agrs.categories.length, (index) {
                    print(agrs.categories[index].categoryId);
                    return FutureBuilder<List<ProductModel>>(
                        future: getProductFromCategory(
                            agrs.categories[index].categoryId!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ProductGrid(
                              products: snapshot.data,
                            );
                          }
                          if (snapshot.hasError) {}
                          return const CircularProgressIndicator();
                        });
                  })
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.category),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.category,
      ),
    );
  }
}

class ProductsCategoryArguments {
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final CategoryModel categoryModel;

  ProductsCategoryArguments(
      {required this.products,
      required this.categories,
      required this.categoryModel});
}
