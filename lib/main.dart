import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furniture_app/database/database.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/provider/login_provider.dart';
import 'package:furniture_app/screens/home/home_screen.dart';
import 'package:furniture_app/screens/sign_up/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'models/account_model.dart';
import 'routes.dart';
import 'screens/splash/splash_screen.dart';
import 'theme.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// async : bất đồng bộ
Future<void> main() async {
  // Khởi tạo để sử dụng bất đồng bộ
  WidgetsFlutterBinding.ensureInitialized();
  // sử dụng await để lấy dữ liệu await, await phải đặt trong async
  final database =
      await $FloorAppDatabase.databaseBuilder('cart_system.db').build();
  final dao = database.cartDao;
  AccountModel account = new AccountModel();
  runApp(ChangeNotifierProvider(
      create: (context) => InitProvider(accountModel: account, cartDao: dao),
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic finalEmail;

  dynamic finalPassword;

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    var obtainedPassword = sharedPreferences.getString('password');
    finalEmail = obtainedEmail;
    finalPassword = obtainedPassword;
  }

  // @override
  // initState() {
  //   getValidationData().whenComplete(() async {
  //     if (finalEmail != null) {
  //       LoginProvider(email: finalEmail, password: finalPassword);
  //       Navigator.pushNamed(context, SignUpScreen.routeName);
  //     } else {
  //       Navigator.pushNamed(context, SplashScreen.routeName);
  //     }
  //   });
  //   super.initState();
  // }

//   Future<dynamic> loginStatus({
//     String? email,
//     String? password,
//   }) async {
//     AccountModel _account = AccountModel();
//     final response = await http.post(Uri.parse(postLoginUrl),
//         body: {"email": email, "password": password});
// // // 0 : không tồn tại tài khoản
// // // 1 : đăng nhập thành công
// // // 2 : sai mật khẩu
//     switch (response.statusCode) {
//       case 200:
//         switch (response.body) {
//           case "0":
//             return 0;
//           case "2":
//             return 2;
//           default:
//             _account = AccountModel.fromJson(jsonDecode(response.body));
//             return _account;
//         }
//       case 401:
//         print("401 Error" + json.decode(response.body));
//         break;
//       default:
//         print("errors: " + json.decode(response.body));
//         break;
//     }
//     return _account;
//   }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen()
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
