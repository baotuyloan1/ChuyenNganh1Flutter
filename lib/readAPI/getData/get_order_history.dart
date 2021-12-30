import 'package:furniture_app/config.dart';
import 'package:furniture_app/models/order_detail_history.dart';
import 'package:furniture_app/models/order_detail_model.dart';
import 'package:furniture_app/models/order_model.dart';
import 'package:http/http.dart' as http;

import 'dart:async'; // cho load du lieu
import 'dart:convert'; // su ly jn

class GetOrderHistory {
  Future<dynamic> getOrderHistory({
    String? customer_id,
  }) async {
    final response = await http.post(Uri.parse(getOrderHistoryByCustomerId),
        body: {"customer_id": customer_id});
    switch (response.statusCode) {
      case 200:
        switch (response.body) {
          case "2":
            return 2;
          case "0":
            return 0;
          default:
            final orderModel = ((json.decode(response.body)) as List<dynamic>)
                .map((value) => OrderModel.fromJson(value))
                .toList();
            return orderModel;
        }
      case 401:
        print("401 Error" + json.decode(response.body));
        break;
      default:
        print("errors: " + json.decode(response.body));
        break;
    }
    return 0;
  }

  Future<dynamic> getOrderHistoryByStatus(int idCustomer, int status) async {
    final response = await http.post(Uri.parse(getOrderHistoryByStatus1),
        body: {
          "customer_id": idCustomer.toString(),
          "status": status.toString()
        });
    switch (response.statusCode) {
      case 200:
        switch (response.body) {
          case "2":
            return 2;
          case "0":
            return 0;
          default:
            final orderModel = ((json.decode(response.body)) as List<dynamic>)
                .map((value) => OrderModel.fromJson(value))
                .toList();
            return orderModel;
        }
      case 401:
        print("401 Error" + json.decode(response.body));
        break;
      default:
        print("errors: " + json.decode(response.body));
        break;
    }
    return 0;
  }

  Future<dynamic> getOrderDetail(String idOrder) async {
    final response = await http.post(Uri.parse(getOrderDetailByOrderId),
        body: {"order_id": idOrder.toString()});
    switch (response.statusCode) {
      case 200:
        switch (response.body) {
          case "0":
            return 0;
          default:
            final orderDetailModel = ((json.decode(response.body)) as List<dynamic>)
                .map((value) => OrderDetailHistoryModel.fromJson(value))
                .toList();
            return orderDetailModel;
        }
    }
  }
}
