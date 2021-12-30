import 'package:furniture_app/config.dart';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class PostOrder {
  Future<int> postOrder(
      {required String customer_id,
      required String billing_id,
      required String payment_id,
      required String order_total,
      required String order_note}) async {
    final response = await http.post(Uri.parse(postOrderUrl), body: {
      "customer_id": customer_id,
      "billing_id": billing_id,
      "payment_id": payment_id,
      "order_total": order_total,
      "order_note": order_note
    });
    return json.decode(response.body);
  }
}
