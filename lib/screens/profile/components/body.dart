import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_app/screens/order_history/order_history_screen.dart';
import 'package:furniture_app/screens/order_history/order_history_screen1.dart';
import 'package:furniture_app/screens/sign_in/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        const SizedBox(
          height: 20,
        ),
        ProfileMenu(
          icon: "assets/icons/User Icon.svg",
          text: "My Account",
          press: () {},
        ),
        ProfileMenu(
          icon: "assets/icons/Bell.svg",
          text: "Notifications",
          press: () {},
        ),
        ProfileMenu(
          icon: "assets/icons/Settings.svg",
          text: "Settings",
          press: () {},
        ),
        ProfileMenu(
          icon: "assets/icons/Question mark.svg",
          text: "Order History",
          press: () {
            Navigator.pushNamed(context, OrderHistory1.routeName);
          },
        ),
        ProfileMenu(
          icon: "assets/icons/Log out.svg",
          text: "Logout",
          press: () async {
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.remove('email');
            sharedPreferences.remove('password');
            Navigator.pushNamed(context, SignInScreen.routeName);
          },
        )
      ],
    );
  }
}
