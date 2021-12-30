import 'package:furniture_app/arguments/complete_profile_argument.dart';

class OTPRegisterArguments {
  final CompleteProfileArguments completeProfileArguments;
  final String firstName, lastName, phoneNumer, address;

  OTPRegisterArguments(
      {required this.completeProfileArguments,
      required this.lastName,
      required this.firstName,
      required this.phoneNumer,
      required this.address});
}
