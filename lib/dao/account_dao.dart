import '../entity/cart.dart';
import 'package:floor/floor.dart';



@dao
abstract class AccountDAO{
  @Query('SELECT * FROM Cart WHERE uid=:uid')
  Stream<List<Cart>> getAllItemInCartAllByUid(String uid);
}