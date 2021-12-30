class BillingModel {
  int? id;
  int? idCustomer;
  String? billingName;
  String? billingAddress;
  String? billingPhone;
  String? billingEmail;
  String? createdAt;
  String? updatedAt;

  BillingModel();

  BillingModel.fromJson(dynamic json) {
    id = json["billing_id"];
    idCustomer = json["customer_id"];
    billingName = json["billing_name"];
    billingAddress = json["billing_address"];
    billingPhone = json["billing_phone"];
    billingEmail = json["billing_email"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }
}
