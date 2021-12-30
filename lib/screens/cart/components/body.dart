import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/entity/cart.dart';
import 'package:furniture_app/models/cart_model.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/size_config.dart';

import 'cart_item_card.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  List<Cart> list;
  Body({required this.list});
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: StreamBuilder(
          stream: context
              .read<InitProvider>()
              .cartDao
              .getAllItemInCartAllByUid("bao"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var items = snapshot.data as List<Cart>;
              return ListView.builder(
                  itemCount: widget.list == null ? 0 : widget.list.length,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Dismissible(
                            key: Key(items[index].id.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20)),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFFE6E6),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Spacer(),
                                  SvgPicture.asset("assets/icons/Trash.svg")
                                ],
                              ),
                            ),
                            onDismissed: (direction) async {
                              await context
                                  .read<InitProvider>()
                                  .cartDao
                                  .deleteCart(items[index]);
                            },
                            child: CartItemCard(
                              cart: items[index],
                            )),
                      ));
            } else {
              return Center(
                child: Text('Cart Detail Error'),
              );
            }
          }),
    );
  }
}
