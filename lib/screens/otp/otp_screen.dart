import 'package:flutter/material.dart';
import 'components/body.dart';

class OtpScreen extends StatelessWidget {

  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Verification"),
      ),
      body: const Body(),
    );
  }
}
