import '../entity/cart.dart';
import 'package:floor/floor.dart';

@dao
abstract class CartDAO {
  @Query('SELECT * FROM Cart WHERE uid=:uid')
  Stream<List<Cart>> getAllItemInCartAllByUid(String uid);

  @Query('SELECT * FROM Cart WHERE uid=:uid AND id=:id')
  Future<Cart?> getItemInCartByUid(String uid, int id);

  @Query('DELETE FROM Cart WHERE uid=:uid')
  Future<Cart?> clearCartByUid(String uid);

  @insert
  Future<void> insertCart(Cart product);

  @update
  Future<void> updateCart(Cart product);

  @delete
  Future<void> deleteCart(Cart product);
}
