import 'package:flutter/widgets.dart';
import 'package:furniture_app/screens/cart/cart_screen.dart';
import 'package:furniture_app/screens/category/category_screen.dart';

import 'package:furniture_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:furniture_app/screens/details/details_screen.dart';
import 'package:furniture_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:furniture_app/screens/home/home_screen.dart';
import 'package:furniture_app/screens/login_success/login_success_screen.dart';
import 'package:furniture_app/screens/order_detail/order_detail_screen.dart';
import 'package:furniture_app/screens/order_history/order_history_screen.dart';
import 'package:furniture_app/screens/order_history/order_history_screen1.dart';
import 'package:furniture_app/screens/otp/otp_screen.dart';
import 'package:furniture_app/screens/profile/profile_screen.dart';
import 'package:furniture_app/screens/sign_in/sign_in_screen.dart';
import 'package:furniture_app/screens/sign_up/sign_up_screen.dart';
import 'package:furniture_app/screens/splash/splash_screen.dart';

import 'screens/checkout/checkout_screen.dart';
import 'screens/delivery_address/delivery_address_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  CheckoutScreen.routeName: (context) => CheckoutScreen(),
  DeliveryAddressScreen.routeName: (context) => DeliveryAddressScreen(),
  CategoryScreen.routeName: (context) => CategoryScreen(),
  OrderHistory.routeName: (context) => OrderHistory(),
  OrderHistory1.routeName: (context) => OrderHistory1(),
  OrderDetailScreen.routeName: (context) => OrderDetailScreen()
};
