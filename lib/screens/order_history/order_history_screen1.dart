import 'package:flutter/material.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/models/order_model.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/readAPI/getData/get_order_history.dart';
import 'package:furniture_app/screens/order_detail/order_detail_screen.dart';
import 'package:furniture_app/screens/order_history/order_history_screen.dart';
import 'package:furniture_app/size_config.dart';

import 'components/body.dart';
import 'package:provider/provider.dart';

class OrderHistory1 extends StatelessWidget {
  static String routeName = "/order_history1";

  const OrderHistory1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int customerId = context.watch<InitProvider>().accountModel.id!;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Order History"),
          bottom: TabBar(
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(0), color: kPrimaryColor),
            labelColor: Colors.white,
            unselectedLabelColor: kSecondaryColor,
            tabs: const [
              Tab(
                child: Text(
                  "Placed",
                ),
              ),
              Tab(
                  child: Text(
                "Delivered",
              )),
              Tab(
                  child: Text(
                "Cancelled",
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _orderPlacedWidget(context, 1, customerId),
            _orderPlacedWidget(context, 2, customerId),
            _orderPlacedWidget(context, 3, customerId),
          ],
        ),
      ),
    );
  }
}

Widget _orderPlacedWidget(BuildContext context, int status, int idCustomer) {
  return FutureBuilder(
      future: GetOrderHistory().getOrderHistoryByStatus(idCustomer, status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data == "0") {
            return const Center(
              child: Text("Order History empty"),
            );
          } else {
            var orders = snapshot.data as List<OrderModel>;
            if (orders.isEmpty) {
              return const Center(
                child: Text("Order History empty"),
              );
            } else {
              return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, OrderDetailScreen.routeName,
                            arguments:
                                OrderArgument(orderModel: orders[index])),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${orders[index].billingModel![0]["billing_name"]}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("Order Time: ${orders[index].createdAt}"),
                                const Divider(
                                  thickness: 2,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Order Id",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "#${orders[index].orderId.toString().padLeft(6, "0")}",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                      VerticalDivider(
                                        thickness: 1,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Order Amount",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "\$${orders[index].orderTotal.toString()}",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                      VerticalDivider(
                                        thickness: 1,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Payment",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Cash on delivery",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: 2,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: kSecondaryColor,
                                    ),
                                    SizedBox(
                                      width: getProportionateScreenWidth(10),
                                    ),
                                    Text(
                                        "Address: ${orders[index].billingModel![0]["billing_address"]}")
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
      });
}
