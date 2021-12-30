import 'package:furniture_app/config.dart';

import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class PostSignUp {
  Future<int> postSignUp(
      {required String email,
      required String password,
      required String address,
      required String firstName,
      required String lastName,
      required String phone}) async {
      String fullName = lastName +" "+ firstName ;
    final response = await http.post(Uri.parse(postSignUpUrl), body: {
      "customer_name": fullName,
      "customer_password": password ,
      "customer_email": email,
      "customer_phone": phone
    });

    return json.decode(response.body);
  }
}
