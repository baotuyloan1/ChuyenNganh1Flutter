import 'package:flutter/material.dart';
import 'package:furniture_app/dao/cart_dao.dart';

class QuantityDetailProvider extends ChangeNotifier {
  int _quantity = 1;

  int get quantity => _quantity;

  void increaseItem() {
    _quantity++;
    notifyListeners();
  }

  void decreaseItem() {
    _quantity--;
    notifyListeners();
  }
}
