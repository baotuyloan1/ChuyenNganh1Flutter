import 'package:furniture_app/config.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:http/http.dart' as http;

import 'dart:async'; // cho load du lieu
import 'dart:convert'; // su ly json

class SendOrderMail {
  Future<dynamic> sendMail(
      {required String order_id, required String billing_id}) async {
    final response = await http.post(Uri.parse(sendMailUrl), body: {
      "order_id": order_id,
      "billing_id": billing_id,
    });
    return json.decode(response.body);
  }
}
