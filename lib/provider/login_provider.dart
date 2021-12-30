import 'package:flutter/material.dart';
import 'package:furniture_app/dao/cart_dao.dart';
import 'package:furniture_app/models/account_model.dart';

class LoginProvider extends ChangeNotifier {
  late String email ;
  late AccountModel accountModel;
  late String password;
  LoginProvider({required this.accountModel});
}
