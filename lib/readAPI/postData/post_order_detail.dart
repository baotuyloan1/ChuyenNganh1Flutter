import 'package:furniture_app/config.dart';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class PostOrderDetail {
  Future<int> postOrderDetail({
    required String payment_method,
    required String billing_note,
  }) async {
    final response = await http.post(Uri.parse(postPaymentUrl), body: {
      "payment_method": payment_method,
      "billing_note": billing_note,
    });
    return json.decode(response.body);
  }
}
