import 'package:flutter/material.dart';

import 'package:furniture_app/arguments/otp_register_arguments.dart';
import 'package:furniture_app/readAPI/postData/post_sign_up.dart';
import 'package:furniture_app/screens/sign_in/sign_in_screen.dart';
import 'package:furniture_app/screens/sign_up/sign_up_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';

class OtpForm extends StatefulWidget {
  OtpForm({Key? key}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

// Đây là phương thức đầu tiên được gọi khi widget được tạo.

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  // dispose() được gọi khi đối tượng State bị xóa vĩnh viễn.
  @override
  void dispose() {
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    super.dispose();
  }

  void nextField({String? value, FocusNode? focusNode}) {
    if (value!.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final OTPRegisterArguments agrs =
        ModalRoute.of(context)!.settings.arguments as OTPRegisterArguments;
    return Form(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(60),
              child: TextFormField(
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 24),
                decoration: otpInputDecoration,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  nextField(value: value, focusNode: pin2FocusNode);
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(60),
              child: TextFormField(
                focusNode: pin2FocusNode,
                obscureText: true,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 24),
                decoration: otpInputDecoration,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  nextField(value: value, focusNode: pin3FocusNode);
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(60),
              child: TextFormField(
                focusNode: pin3FocusNode,
                obscureText: true,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 24),
                decoration: otpInputDecoration,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  nextField(value: value, focusNode: pin4FocusNode);
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(60),
              child: TextFormField(
                focusNode: pin4FocusNode,
                obscureText: true,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 24),
                decoration: otpInputDecoration,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  pin4FocusNode!.unfocus();
                },
              ),
            )
          ],
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.15,
        ),
        DefaultButton(
            text: "Continue",
            press: () async {
              int statusSignUp = await PostSignUp().postSignUp(
                  email: agrs.completeProfileArguments.email,
                  password: agrs.completeProfileArguments.password,
                  address: agrs.address,
                  firstName: agrs.firstName,
                  lastName: agrs.lastName,
                  phone: agrs.phoneNumer);
              if (statusSignUp == 1) {
                Navigator.pushNamed(context, SignInScreen.routeName);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  backgroundColor: kPrimaryColor,
                  content: const Text(
                    "Sign Up Success",
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: const Duration(seconds: 2),
                ));
              } else if (statusSignUp == 2) {
                Navigator.pushNamed(context, SignUpScreen.routeName);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  backgroundColor: kPrimaryColor,
                  content: const Text(
                    "Email already exists",
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: const Duration(seconds: 2),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  backgroundColor: kPrimaryColor,
                  content: const Text(
                    "Error",
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: const Duration(seconds: 2),
                ));
              }
            })
      ],
    ));
  }
}
