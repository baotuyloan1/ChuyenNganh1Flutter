import 'package:flutter/material.dart';

class ProductModel {
  int? productId;
  int? categoryId;
  String? productName;
  String? productDesc;
  String? productSpec;
  String? productImage;
  int? productPrice;
  int? productStatus;
  List<dynamic>? productImages;
  List<Color>? colors;

  ProductModel(
      {required this.productId,
      required this.categoryId,
      required this.productName,
      required this.productDesc,
      required this.productSpec,
      required this.productImage,
      required this.productPrice,
      required this.productStatus,
      required this.productImages});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json["product_id"];
    categoryId = json["categor_id"];
    productName = json["product_name"];
    productDesc = json["product_desc"];
    productSpec = json["product_spec"];
    productImage = json["product_image"];
    productPrice = json["product_price"];
    productStatus = json["product_status"];
    productImages = json["images_detail"];
  }
}
