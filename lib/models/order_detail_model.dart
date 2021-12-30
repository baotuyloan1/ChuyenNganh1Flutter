class OrderDetailModel {
  String? productName;
  String? orderId;
  String? productId;
  double? productPrice;
  int? quantity;
  OrderDetailModel(
      {required this.productId,
      required this.productName,
      required this.orderId,
      required this.productPrice,
      this.quantity});

  Map<String, dynamic> toJson() {
    return {
      "order_id": orderId,
      "product_id": productId,
      "product_name": productName,
      "product_price": productPrice,
      "product_sales_quantity": quantity
    };
  }
}
