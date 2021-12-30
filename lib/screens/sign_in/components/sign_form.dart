import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furniture_app/database/database.dart';
import 'package:furniture_app/models/account_model.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/provider/login_provider.dart';

import 'package:furniture_app/screens/login_success/login_success_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../components/custom_suffix_icon.dart';
import '../../forgot_password/forgot_password_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                dynamic a = await loginStatus(email: email, password: password);
                if (a.runtimeType == AccountModel) {
                  if (remember!) {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setString('email', email!);
                    sharedPreferences.setString('password', password!);
                  }
                  AccountModel accountModel = a;
                  context.read<InitProvider>().accountModel = accountModel;
                  final database = await $FloorAppDatabase
                      .databaseBuilder('cart_system.db')
                      .build();
                  final dao = database.cartDao;
                  context.read<InitProvider>().cartDao = dao;
                  context.read<InitProvider>().email = email;
                  context.read<InitProvider>().password = password;
                  Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                }
                // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> loginStatus({
    String? email,
    String? password,
  }) async {
    AccountModel _account = AccountModel();
    final response = await http.post(Uri.parse(postLoginUrl),
        body: {"email": email, "password": password});
// // 0 : không tồn tại tài khoản
// // 1 : đăng nhập thành công
// // 2 : sai mật khẩu
    switch (response.statusCode) {
      case 200:
        switch (response.body) {
          case "0":
            removeError(error: kInvalidEmailError);
            addError(error: kEmailNotExistError);
            return 0;
          case "2":
            removeError(error: kEmailNotExistError);
            addError(error: kIncorrectPassError);
            return 2;
          default:
            removeError(error: kIncorrectPassError);
            _account = AccountModel.fromJson(jsonDecode(response.body));
            return _account;
        }
      case 401:
        print("401 Error" + json.decode(response.body));
        break;
      default:
        print("errors: " + json.decode(response.body));
        break;
    }
    return _account;
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
