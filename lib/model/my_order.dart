

import 'order_status.dart';

class MyOrder {
  String id = '';
  String productImage = '';
  String productName = '';
  double productPrice = 0;
  String customerName = '';
  String customerEmail = '';
  String phoneNumber = '';
  String address = '';
  String status = OrderStatus.NEW.toShortString();
  String createDate = DateTime.now().toString();
  String updateDate = DateTime.now().toString();

  MyOrder(
      {required this.id,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.customerName,
      required this.customerEmail,
      required this.phoneNumber,
      required this.address,
      required this.status,
      required this.createDate,
      required this.updateDate});

  MyOrder.empty() {
    id = '';
    productImage = '';
    productName = '';
    productPrice = 0;
    customerName = '';
    customerEmail = '';
    phoneNumber = '';
    address = '';
    status = OrderStatus.NEW.toShortString();
    createDate = DateTime.now().toString();
    updateDate = DateTime.now().toString();
  }

  MyOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productImage = json['product_image'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    customerName = json['customer_name'];
    customerEmail = json['customer_email'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    status = json['status'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
  }
}
