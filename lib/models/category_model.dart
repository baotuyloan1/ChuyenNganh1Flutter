import 'package:flutter/material.dart';

class CategoryModel {
  int? categoryId;
  String? categoryName;
  String? metaKeyword;
  String? categoryImage;
  String? categoryDesc;
  int? categoryStatus;
  CategoryModel();

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryId = json["categor_id"];
    categoryName = json["categor_name"];
    metaKeyword = json["meta_keywords"];
    categoryImage = json["categor_image"];
    categoryDesc = json["categor_desc"];
    categoryStatus = json["categor_status"];
  }
}
