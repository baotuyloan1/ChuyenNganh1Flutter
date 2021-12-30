import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/models/account_model.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/readAPI/getData/get_infor_account.dart';
import 'package:furniture_app/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../enums.dart';
import 'components/body.dart';
import '../../components/custom_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<String?>(
    //     future: getValidationData(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         return Center(child: Text("${snapshot.error}"));
    //       }
    //       if (snapshot.hasData) {
    //         return buildInfoProfile(snapshot);
    //       }
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     });
    return buildInfoProfile();
  }

  FutureBuilder<dynamic> buildInfoProfile() {
    String? email = context.watch<InitProvider>().email;
    String? password = context.watch<InitProvider>().password;
    return FutureBuilder<dynamic>(
      future: GetInforAccount().getInfor(email: email, password: password),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data!.name.toString()),
            ),
            body: Body(),
            bottomNavigationBar: const CustomBottomNavBar(
              selectedMenu: MenuState.profile,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
