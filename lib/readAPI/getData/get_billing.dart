import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:furniture_app/config.dart';
import 'package:furniture_app/models/billing_model.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class GetBilling {
  List<BillingModel> parseBilling(String resonseBody) {
    var list = json.decode(resonseBody) as List<dynamic>;
    List<BillingModel> billings =
        list.map((model) => BillingModel.fromJson(model)).toList();
    return billings;
  }

  Future<List<BillingModel>> fetchBilling() async {
    final response = await http.get(Uri.parse(getBillingUrl));
    if (response.statusCode == 200) {
      return compute(parseBilling, response.body);
    } else {
      throw Exception("Request API Error");
    }
  }
}
