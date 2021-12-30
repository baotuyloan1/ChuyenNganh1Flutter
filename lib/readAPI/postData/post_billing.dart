import 'package:furniture_app/config.dart';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class PostBilling {
  Future<int> postBilling(
      {required String customer_id,
      required String billing_name,
      required String billing_address,
      required String billing_phone}) async {
    final response = await http.post(Uri.parse(postBillingUrl), body: {
      "customer_id": customer_id,
      "billing_name": billing_name,
      "billing_address": billing_address,
      "billing_phone": billing_phone
    });

    return json.decode(response.body);
  }

  
}
