import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:furniture_app/config.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:http/http.dart' as http;

List<ProductModel> parseProduct(String resonseBody) {
  var list = json.decode(resonseBody) as List<dynamic>;
  List<ProductModel> products =
      list.map((model) => ProductModel.fromJson(model)).toList();
  return products;
}

Future<List<ProductModel>> fetchProduct() async {
  final response = await http.get(Uri.parse(getDataUrl));
  if(response.statusCode == 200){
    return compute(parseProduct , response.body);
  }else {
    throw Exception("Request API Error");
  }
}
