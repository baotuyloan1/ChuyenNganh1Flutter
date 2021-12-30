class OrderDetailHistoryModel {
  String? detailId;
  String? orderId;
  String? productId;
  String? productName;
  String? productPrice;
  String? quantity;
  String? createdAt;
  String? updatedAt;
  String? image;

  OrderDetailHistoryModel({
    required this.detailId,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "order_id": orderId,
      "product_id": productId,
      "product_name": productName,
      "product_price": productPrice,
      "product_sales_quantity": quantity
    };
  }

  OrderDetailHistoryModel.fromJson(Map<String, dynamic> json) {
    detailId = json["detail_id"];
    orderId = json["order_id"];
    productId = json["product_id"];
    productName = json["product_name"];
    productPrice = json["product_price"];
    quantity = json["product_sales_quantity"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    if (json["image"] != null) {
      image = json["image"][0]["name"];
    }
  }
}
