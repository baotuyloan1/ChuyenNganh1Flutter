import 'package:flutter/material.dart';

class PriceProvider extends ChangeNotifier {
  double? _subTotal = 0;
  setSubTotal(double? subtotal) {
    _subTotal = subtotal;
    notifyListeners();
  }

  double? get getSubTotal => _subTotal;
}
