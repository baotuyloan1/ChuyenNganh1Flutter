import 'package:flutter/material.dart';
import 'package:furniture_app/dao/cart_dao.dart';
import 'package:furniture_app/models/account_model.dart';

class InitProvider extends ChangeNotifier {
  int _quantity = 1;

  InitProvider({required this.accountModel , required this.cartDao});

  CartDAO cartDao;
  AccountModel accountModel;
  String? email;
  String? password;
  int get quantity => _quantity;



  void setAccountModel(AccountModel account) {
    accountModel = account;
    notifyListeners();
  }

  void increaseItem() {
    _quantity++;
    notifyListeners();
  }

  void decreaseItem() {
    _quantity--;
    notifyListeners();
  }

  double? _subTotal = 0;
  setSubTotal(double? subtotal) {
    _subTotal = subtotal;
    notifyListeners();
  }

  double? get getSubTotal => _subTotal;


}
