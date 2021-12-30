import 'package:furniture_app/models/billing_model.dart';

class OrderModel {
  String? orderId;
  int? customerId;
  int? billingId;
  int? paymentId;
  double? orderTotal;
  String? orderStatus;
  String? createdAt;
  List<dynamic>? billingModel;

  OrderModel(
      {this.orderId,
      this.customerId,
      this.billingId,
      this.paymentId,
      this.orderTotal,
      this.orderStatus,
      this.billingModel});

  // Map<String, dynamic> toJson() {
  //   return {
  //     "order_id": orderId,
  //     "customer_id": customerId,
  //     "billing_id": billingId,
  //     "payment_id": paymentId,
  //     "order_total": orderTotal,
  //     "order_status": orderStatus,
  //     "created_at": createdAt
  //   };
  // }

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json["order_id"].toString();
    customerId = json["customer_id"];
    billingId = json["billing_id"];
    paymentId = json["payment_id"];
    orderTotal = double.parse(json["order_total"].toString());
    orderStatus = json["order_status"];
    createdAt = json["created_at"];
    billingModel = json["billing"];
  }
}
