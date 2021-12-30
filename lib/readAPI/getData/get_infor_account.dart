import 'package:flutter/material.dart';
import 'package:furniture_app/config.dart';
import 'package:furniture_app/models/account_model.dart';
import 'package:furniture_app/models/billing_model.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:get/get_connect.dart';
import 'package:http/http.dart' as http;

import 'dart:async'; // cho load du lieu
import 'dart:convert'; // su ly json

class GetInforAccount {
  Future<dynamic> getInfor({
    String? email,
    String? password,
  }) async {
    AccountModel _account = AccountModel();
    final response = await http.post(Uri.parse(postLoginUrl),
        body: {"email": email, "password": password});
// // 0 : không tồn tại tài khoản
// // 1 : đăng nhập thành công
// // 2 : sai mật khẩu
    switch (response.statusCode) {
      case 200:
        switch (response.body) {
          case "2":
            return 2;
          default:
            _account = AccountModel.fromJson(jsonDecode(response.body));
            return _account;
        }
      case 401:
        print("401 Error" + json.decode(response.body));
        break;
      default:
        print("errors: " + json.decode(response.body));
        break;
    }
    return _account;
  }
  // static Future<AccountModel> check(
  //     {String? email, String? password, required List<String?> errors , required BuildContext form}) async {
  //   AccountModel _account = AccountModel();
  //   final response = await http.post(Uri.parse(postLoginUrl),
  //       body: {"email": email, "password": password});

  //   switch (response.statusCode) {
  //     case 200:
  //       switch (response.body) {
  //         case "0":
  //           errors.add("Không tồn tại email");
  //           context.set
  //           break;
  //       }
  //       break;

  //     case 401:
  //       print("401 Error" + json.decode(response.body));
  //       break;
  //     default:
  //       print("errors: " + json.decode(response.body));
  //       break;
  //   }
  //   return _account;
  //   //  final list = ((json.decode(response.body)) as List<dynamic>)
  //   //      .map((value) => ProductModel.fromJson(value))
  //   //      .toList();
  //   // final Map account = jsonDecode(response.body);
  //   // final signUp = AccountModel.fromJson(account)
  // }

  Future<List<BillingModel>> getBilling({String? idAccount}) async {
    final response = await http
        .post(Uri.parse(getBillingUrl), body: {"customer_id": idAccount});
    final list = ((json.decode(response.body)) as List<dynamic>)
        .map((value) => BillingModel.fromJson(value))
        .toList();
    return list;
  }
}
