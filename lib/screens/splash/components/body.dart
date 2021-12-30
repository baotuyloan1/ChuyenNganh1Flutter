import 'package:flutter/material.dart';

import 'package:furniture_app/constants.dart';
import 'package:furniture_app/models/account_model.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/provider/login_provider.dart';
import 'package:furniture_app/readAPI/getData/get_infor_account.dart';
import 'package:furniture_app/screens/home/home_screen.dart';
import 'package:furniture_app/screens/sign_in/sign_in_screen.dart';
import 'package:furniture_app/screens/sign_up/sign_up_screen.dart';
import 'package:furniture_app/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/splash_content.dart';
import '../../../components/default_button.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  dynamic finalEmail;
  dynamic finalPassword;
  @override
  initState() {
    getValidationData().whenComplete(() async {
      if (finalEmail != null) {
        dynamic getAccount = await GetInforAccount()
            .getInfor(email: finalEmail, password: finalPassword);
        if (getAccount.runtimeType == AccountModel) {
          context.read<InitProvider>().accountModel = await GetInforAccount()
              .getInfor(email: finalEmail, password: finalPassword);
        }

        var accountModel = context.read<InitProvider>().accountModel;
      } else {}
    });
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    var obtainedPassword = sharedPreferences.getString('password');
    finalEmail = obtainedEmail;
    finalPassword = obtainedPassword;
    context.read<InitProvider>().email = obtainedEmail;
    context.read<InitProvider>().password = obtainedPassword;
  }

  int curentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Furniture, Let's shop!",
      "image": "assets/images/splash_1.png",
    },
    {
      "text": "We help people connect with store \nFuniture",
      "image": "assets/images/splash_2.png",
    },
    {
      "text": "We show the easy way to shop.\nJust stay at home with us",
      "image": "assets/images/splash_3.png",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      curentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    text: splashData[index]["text"].toString(),
                    image: splashData[index]["image"].toString(),
                  ),
                )), // Expanded là 1 widget giúp mở rộng không gian cho 1 widget con của Row hoặc Column theo trục chính (main axis)
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(splashData.length,
                            (index) => buildDot(index: index)),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      DefaultButton(
                        text: "Continute",
                        press: () async {
                          if (finalEmail != null) {
                            dynamic getAccount = await GetInforAccount()
                                .getInfor(
                                    email: finalEmail, password: finalPassword);
                            if (getAccount.runtimeType == AccountModel) {
                              context.read<InitProvider>().accountModel =
                                  await GetInforAccount().getInfor(
                                      email: finalEmail,
                                      password: finalPassword);
                              context.read<InitProvider>().email = finalEmail;
                              context.read<InitProvider>().password =
                                  finalPassword;

                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                            } else {
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                            }
                          } else {
                            Navigator.pushNamed(
                                context, SignInScreen.routeName);
                          }
                        },
                      ),
                      Spacer()
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: curentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: curentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
      duration: kAnimationDuration,
    );
  }
}
