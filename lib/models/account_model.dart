class AccountModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? addressList;
  // String createdAt;
  // String updatedAt;

  // AccountModel(
  //     {required this.id,
  //     required this.email,
  //     required this.password,
  //     required this.name,
  //     required this.phone});

  AccountModel();

  AccountModel.fromJson(dynamic json) {
    id = json["customer_id"];
    email = json["customer_email"];
    password = json["customer_password"];
    name = json["customer_name"];
    phone = json["customer_phone"];
  }
}
