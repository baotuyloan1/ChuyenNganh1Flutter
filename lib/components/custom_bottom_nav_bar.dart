import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_app/models/category_model.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/readAPI/getData/get_category.dart';
import 'package:furniture_app/readAPI/getData/product_json.dart';
import 'package:furniture_app/screens/category/category_screen.dart';
import 'package:furniture_app/screens/map/map.dart';
import 'package:provider/src/provider.dart';

import '../constants.dart';
import '../enums.dart';
import '../screens/home/home_screen.dart';
import '../screens/profile/profile_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key, required this.selectedMenu})
      : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              icon: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",
                color: MenuState.home == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              )),
          FutureBuilder<List<CategoryModel>>(
            future: GetCategoryAPI().getAllCategory(),
            builder: (context, snapshotCategory) {
              if (snapshotCategory.hasData) {
                return FutureBuilder<List<ProductModel>>(
                    future: GetProductAPI().getProductFromCategory(
                        snapshotCategory.data![0].categoryId!),
                    builder: (context, snapshotProduct) {
                      if (snapshotProduct.hasData) {
                        return IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, CategoryScreen.routeName,
                                  arguments: ProductsCategoryArguments(
                                      products: snapshotProduct.data!,
                                      categories: snapshotCategory.data!,
                                      categoryModel:
                                          snapshotCategory.data![0]));
                            },
                            icon: Icon(
                              Icons.category_outlined,
                              color: MenuState.category == selectedMenu
                                  ? kPrimaryColor
                                  : inActiveIconColor,
                            ));
                      } else if (snapshotProduct.hasError) {
                        return const Center(
                            child: Text("Error snapshotProduct"));
                      } else {
                        return const CircularProgressIndicator();
                      }
                    });
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          IconButton(
              onPressed: () {
                MapUtils.openMap(15.97491775834772, 108.25309792326044);
              },
              icon: Icon(
                Icons.map_outlined,
                color: MenuState.map == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              )),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/icons/Chat bubble Icon.svg",
                color: MenuState.message == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              )),
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, ProfileScreen.routeName),
            icon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              color: MenuState.profile == selectedMenu
                  ? kPrimaryColor
                  : inActiveIconColor,
            ),
          )
        ],
      ),
    );
  }
}
