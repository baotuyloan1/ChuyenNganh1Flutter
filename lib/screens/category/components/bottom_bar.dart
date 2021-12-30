import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/size_config.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: getProportionateScreenWidth(75),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
                color: Colors.white),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: getProportionateScreenWidth(40),
                  width: SizeConfig.screenWidth / 2 -
                      getProportionateScreenWidth(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const <Widget>[
                      Icon(
                        Icons.home,
                        color: kPrimaryColor,
                      ),
                      Icon(
                        Icons.person_outline,
                        color: kSecondaryColor,
                      )
                    ],
                  ),
                ),
                Container(
                  height: getProportionateScreenWidth(50),
                  width: SizeConfig.screenWidth / 2 -
                      getProportionateScreenWidth(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const <Widget>[
                      Icon(
                        Icons.home,
                        color: kPrimaryColor,
                      ),
                      Icon(
                        Icons.person_outline,
                        color: kSecondaryColor,
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
