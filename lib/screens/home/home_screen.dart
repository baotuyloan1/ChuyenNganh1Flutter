import 'package:flutter_svg/svg.dart';
import 'package:furniture_app/components/custom_bottom_nav_bar.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/enums.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:provider/src/provider.dart';

import 'components/body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedMenu: MenuState.home,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: SvgPicture.asset(
          "assets/icons/Shop Icon.svg",
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
