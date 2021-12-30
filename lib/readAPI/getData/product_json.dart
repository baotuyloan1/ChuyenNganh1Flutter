import 'package:furniture_app/config.dart';
import 'package:furniture_app/models/product_model.dart';
import 'package:http/http.dart' as http;

import 'dart:async'; // cho load du lieu
import 'dart:convert'; // su ly json

class GetProductAPI {
  Future<List<ProductModel>> getNewProduct(String dataURL) async {
    final response = await http.get(Uri.parse(dataURL));
    final list = ((json.decode(response.body)) as List<dynamic>)
        .map((value) => ProductModel.fromJson(value))
        .toList();
    return list;
  }

    Future<List<ProductModel>> getProductFromCategory(int categoryId) async {
    final response = await http.post(Uri.parse(getProductByCategoryId),
        body: {"categor_id": categoryId.toString()});
    final list = ((json.decode(response.body)) as List<dynamic>)
        .map((value) => ProductModel.fromJson(value))
        .toList();
    return list;
  }
}
