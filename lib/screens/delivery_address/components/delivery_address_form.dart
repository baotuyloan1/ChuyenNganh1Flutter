import 'package:flutter/material.dart';
import 'package:furniture_app/components/custom_suffix_icon.dart';
import 'package:furniture_app/components/default_button.dart';
import 'package:furniture_app/components/form_error.dart';
import 'package:furniture_app/models/billing_model.dart';
import 'package:furniture_app/provider/init_provider.dart';
import 'package:furniture_app/readAPI/postData/post_billing.dart';
import 'package:furniture_app/screens/checkout/checkout_screen.dart';
import 'package:furniture_app/screens/complete_profile/complete_profile_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:provider/provider.dart';

class DeliveryAddressForm extends StatefulWidget {
  const DeliveryAddressForm({Key? key}) : super(key: key);

  @override
  _DeliveryAddressForm createState() => _DeliveryAddressForm();
}

class _DeliveryAddressForm extends State<DeliveryAddressForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? phone;
  String? address;
  final List<String?> errors = [];
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int customer_id = context.watch<InitProvider>().accountModel.id!;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFullNameFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildPhoneFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildDeliveryAddressFormField(),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(40),
          ),
          DefaultButton(
              text: "Add",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  int statusPost = await PostBilling().postBilling(
                      customer_id: customer_id.toString(),
                      billing_name: name!,
                      billing_address: address!,
                      billing_phone: phone!);
                  if (statusPost == 1) {
                    Navigator.pushNamed(context, CheckoutScreen.routeName);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      backgroundColor: kPrimaryColor,
                      content: const Text(
                        "Add delivery address success",
                        style: TextStyle(color: Colors.white),
                      ),
                      duration: const Duration(seconds: 2),
                    ));
                  }
                }
              })
        ],
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone",
        hintText: "Enter your Phone",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Full Name",
        hintText: "Enter your name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildDeliveryAddressFormField() {
    return TextFormField(
      maxLines: null,
      keyboardType: TextInputType.multiline,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Address",
        hintText: "Enter your delivery address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Location point.svg",
        ),
      ),
    );
  }
}
