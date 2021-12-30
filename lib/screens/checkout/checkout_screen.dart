import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flutter/widgets.dart';
import 'package:furniture_app/components/custom_bottom_nav_bar.dart';
import 'package:furniture_app/components/default_button.dart';
import 'package:furniture_app/config.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/dao/cart_dao.dart';
import 'package:furniture_app/entity/cart.dart';
import 'package:furniture_app/enums.dart';
import 'package:furniture_app/models/billing_model.dart';
import 'package:furniture_app/models/order_detail_model.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/provider/price_provider.dart';
import 'package:furniture_app/readAPI/getData/get_infor_account.dart';
import 'package:furniture_app/readAPI/mail/order_mail.dart';
import 'package:furniture_app/readAPI/postData/post_order.dart';
import 'package:furniture_app/readAPI/postData/post_payment.dart';
import 'package:furniture_app/screens/checkout/components/order_details_argument.dart';
import 'package:furniture_app/screens/checkout/components/payment_cost.dart';
import 'package:furniture_app/screens/delivery_address/delivery_address_screen.dart';
import 'package:furniture_app/screens/home/home_screen.dart';
import 'package:furniture_app/size_config.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'components/payment_cart.dart';

class CheckoutScreen extends StatefulWidget {
  static String routeName = "/checkout";

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int? addressSelected;
  BillingModel? billingModelSelected;
  String? _note;
  double _subTotal = 0;
  double _deliveryCost = 0;
  double _discount = 0;
  double _total = 0;
  TextEditingController noteController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    int customer_id = context.watch<InitProvider>().accountModel.id!;
    _subTotal = context.watch<InitProvider>().getSubTotal!;
    _deliveryCost = _subTotal * (1 / 100);
    _discount = 0;
    _total = _subTotal + _deliveryCost + _discount;
    CartDAO cartDAO = context.watch<InitProvider>().cartDao;
    CartDAO cartDAORead = context.read<InitProvider>().cartDao;
    List<Cart>? carts;
    return StreamBuilder(
      stream: cartDAO.getAllItemInCartAllByUid("bao"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          carts = snapshot.data as List<Cart>;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "CheckOut",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Delivery Address"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, DeliveryAddressScreen.routeName);
                              },
                              child: const Text(
                                "Add",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenWidth(5)),
                    selectDeliveryAddress(context),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: getProportionateScreenWidth(10),
                      width: double.infinity,
                      color: kSecondaryColor.withOpacity(0.1),
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Payment  method"),
                          TextButton(
                              onPressed: () {},
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.add,
                                    color: kPrimaryColor,
                                  ),
                                  Text("Add Card",
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold))
                                ],
                              ))
                        ],
                      ),
                    ),
                    PaymentCard(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Cash on delivery"),
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: kPrimaryColor),
                            width: getProportionateScreenWidth(15),
                            height: getProportionateScreenWidth(15),
                            child: Icon(
                              Icons.check,
                              size: getProportionateScreenWidth(13),
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PaymentCard(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: getProportionateScreenWidth(40),
                                  child:
                                      Image.asset("assets/images/visa1.png")),
                              SizedBox(
                                width: getProportionateScreenWidth(10),
                              ),
                              const Text("**** **** **** 2612"),
                            ],
                          ),
                          Container(
                            width: getProportionateScreenWidth(15),
                            height: getProportionateScreenWidth(15),
                            decoration: const ShapeDecoration(
                                shape: CircleBorder(
                                    side: BorderSide(color: kPrimaryColor))),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PaymentCard(
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: getProportionateScreenWidth(40),
                                  child:
                                      Image.asset("assets/images/paypal.png")),
                              SizedBox(
                                width: getProportionateScreenWidth(10),
                              ),
                              Text(context
                                  .watch<InitProvider>()
                                  .accountModel
                                  .email
                                  .toString()),
                            ],
                          ),
                          Container(
                            width: getProportionateScreenWidth(15),
                            height: getProportionateScreenWidth(15),
                            decoration: const ShapeDecoration(
                                shape: CircleBorder(
                                    side: BorderSide(color: kPrimaryColor))),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                    Container(
                      height: getProportionateScreenWidth(10),
                      width: double.infinity,
                      color: kSecondaryColor.withOpacity(0.1),
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                    PaymentCost(context, _total),
                    Container(
                      height: getProportionateScreenWidth(10),
                      width: double.infinity,
                      color: kSecondaryColor.withOpacity(0.1),
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(10),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: buildNoteFormField(),
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: SizedBox(
                        width: double.infinity,
                        child: DefaultButton(
                          text: "Send order",
                          press: () async {
                            int idPayment = 3;
                            int idOrder = await PostOrder().postOrder(
                                billing_id:
                                    billingModelSelected!.id!.toString(),
                                customer_id: customer_id.toString(),
                                order_total: _total.toString(),
                                payment_id: idPayment.toString(),
                                order_note: _note.toString());
                           
                            List<OrderDetailModel> orderDetails = carts!
                                .map((e) => OrderDetailModel(
                                    productId: e.id.toString(),
                                    productName: e.productName,
                                    orderId: idOrder.toString(),
                                    quantity: e.quantity,
                                    productPrice: e.price.toDouble()))
                                .toList();
                            var body = json.encode(orderDetails);
                            var response = await http.post(
                                Uri.parse(postOrderDetaillUrl),
                                body: body);
                            if (response.body == "1") {
                              cartDAORead.clearCartByUid("bao");
                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                            } else {
                              print("ERROR");
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar:
                const CustomBottomNavBar(selectedMenu: MenuState.home),
          );
        }
        return const Center(
          child: Text("error"),
        );
      },
    );
  }

  StreamBuilder cartDetails() {
    return StreamBuilder(
        stream: context
            .read<InitProvider>()
            .cartDao
            .getAllItemInCartAllByUid("bao"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list = snapshot.data as List<Cart>;
            _subTotal = list
                .map<double>(
                    (e) => double.parse((e.price * e.quantity).toString()))
                .reduce((value, element) => value + element);

            _deliveryCost = list
                .map<double>((e) =>
                    double.parse((e.price * e.quantity * (1 / 100)).toString()))
                .reduce((value, element) => value + element);
          }
          return const Center(
            child: Text('Cart Detail Error'),
          );
        });
  }

  TextFormField buildNoteFormField() {
    return TextFormField(
      controller: noteController,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) => _note = newValue,
      onChanged: (value) {
        _note = value;
      },
      decoration: const InputDecoration(
          labelText: "Note",
          hintText: "Enter your note",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder()),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your note';
        }
        return null;
      },
    );
  }

  FutureBuilder<List<BillingModel>> selectDeliveryAddress(
      BuildContext context) {
    return FutureBuilder<List<BillingModel>>(
      future: GetInforAccount().getBilling(
          idAccount: context.watch<InitProvider>().accountModel.id.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            if (billingModelSelected == null) {
              billingModelSelected = snapshot.data![snapshot.data!.length - 1];
              addressSelected = snapshot.data!.length - 1;
              print(billingModelSelected!.billingName);
            }
          }

          return Column(
            children: [
              ...List.generate(snapshot.data!.length, (index) {
                return buildSelectAddress(
                    index: index, model: snapshot.data![index]);
              })
              // SpecialOfferCard(
              //   image: "assets/images/Image Banner 2.png",
              //   category: "Table",
              //   numOfBrands: 16,
              //   press: () {},
              // ),

              // SizedBox(
              //   width: getProportionateScreenWidth(20),
              // )
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  GestureDetector buildSelectAddress(
      {required int index, required BillingModel model}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          addressSelected = index;
          billingModelSelected = model;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(40)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth * 0.7,
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          "${model.billingName} _ ${model.billingPhone}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("${model.billingAddress}")),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: kPrimaryColor),
              width: getProportionateScreenWidth(15),
              height: getProportionateScreenWidth(15),
              child: Icon(
                addressSelected == index ? Icons.check : Icons.circle,
                size: getProportionateScreenWidth(15),
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
