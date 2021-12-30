import 'package:furniture_app/models/order_detail_model.dart';

class OrderDetailList {
  List<OrderDetailModel> orderDetails;
  OrderDetailList({required this.orderDetails});

  Map<String, dynamic> toJson({required int order_id}) =>
      <String, dynamic>{'order_id': orderDetails ,
      };

  factory OrderDetailList.fromJson(Map<String, dynamic> json) => OrderDetailList(orderDetails: json["orderDetails"]);


}
