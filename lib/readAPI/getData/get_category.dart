import 'dart:convert';

import 'package:furniture_app/config.dart';
import 'package:furniture_app/models/category_model.dart';
import 'package:http/http.dart' as http;

class GetCategoryAPI {
  Future<List<CategoryModel>> getAllCategory() async {
    final response = await http.get(Uri.parse(getCategoryUrl));
    final list = ((json.decode(response.body)) as List<dynamic>)
        .map((value) => CategoryModel.fromJson(value))
        .toList();
    return list;
  }
}
