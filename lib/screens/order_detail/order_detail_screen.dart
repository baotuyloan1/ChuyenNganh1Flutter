import 'package:flutter/material.dart';
import 'package:furniture_app/config.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/models/order_detail_history.dart';
import 'package:furniture_app/models/order_detail_model.dart';
import 'package:furniture_app/models/order_model.dart';
import 'package:furniture_app/readAPI/getData/get_order_history.dart';
import 'package:furniture_app/size_config.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);
  static String routeName = "/order_detail";
  @override
  Widget build(BuildContext context) {
    final OrderArgument agrs =
        ModalRoute.of(context)!.settings.arguments as OrderArgument;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Order #${agrs.orderModel.orderId.toString().padLeft(6, '0')}"),
      ),
      body: FutureBuilder(
        future: GetOrderHistory().getOrderDetail(agrs.orderModel.orderId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data == "0") {
              return const Center(
                child: Text("Order History empty"),
              );
            } else {
              var orderDetails = snapshot.data as List<OrderDetailHistoryModel>;
              if (orderDetails.isEmpty) {
                return const Center(
                  child: Text("Order Detail is empty"),
                );
              } else {
                return ListView.builder(
                    itemCount: orderDetails.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${orderDetails[index].productName}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "\$${orderDetails[index].productPrice}",
                                        style: const TextStyle(
                                            color: kPrimaryColor),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(
                                                getImageProductUrl +
                                                    orderDetails[index].image!),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                              'Quantity: ${orderDetails[index].quantity}'),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
            }
          }
          return Text("Error");
        },
      ),
    );
  }
}

class OrderArgument {
  OrderModel orderModel;
  OrderArgument({required this.orderModel});
}
