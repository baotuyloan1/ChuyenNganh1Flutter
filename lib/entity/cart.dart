import 'package:floor/floor.dart';

@entity
class Cart {
  @primaryKey
  final int id;

  final int categoryProduct;
  final int price;
  final String uid, productName, imageUrl;
  int quantity;

  Cart(
      {required this.id,
      required this.uid,
      required this.productName,
      required this.categoryProduct,
      required this.imageUrl,
      required this.price,
      required this.quantity});
}
