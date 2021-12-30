import 'package:floor/floor.dart';
import 'package:furniture_app/dao/cart_dao.dart';
import '../entity/cart.dart';

//hỗ trợ chạy bất đồng bộ làm nhiều thread cũng 1 lúc
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;


//tạo code
//flutter packages pub run build_runner build
part 'database.g.dart'; 


@Database(version: 1, entities: [Cart])
abstract class AppDatabase extends FloorDatabase {

  CartDAO get cartDao;
}
