// ignore_for_file: unnecessary_this, prefer_collection_literals

import 'dart:ffi';

class Orders {
  bool? status;
  String? message;
  List<Data>? data;

  Orders({this.status, this.message, this.data});

  Orders.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? user;
  String? customerName;
  int? tableNo;
  List<CartItems>? cartItems;
  String? orderStatus;
  String? paymentStatus;
  String? createdAt;
  String? totalPrice;

  Data(
      {this.id,
      this.user,
      this.customerName,
      this.tableNo,
      this.cartItems,
      this.orderStatus,
      this.paymentStatus,
      this.createdAt,
      this.totalPrice});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    customerName = json['customer_name'];
    tableNo = json['table_no'];
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['customer_name'] = this.customerName;
    data['table_no'] = this.tableNo;
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    data['order_status'] = this.orderStatus;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    data['total_price'] = this.totalPrice;
    return data;
  }
}

class CartItems {
  String? itemName;
  dynamic itemPrice;
  int? quantity;
  dynamic total;

  CartItems({this.itemName, this.itemPrice, this.quantity, this.total});

  CartItems.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    itemPrice = json['item_price'];
    quantity = json['quantity'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['item_price'] = this.itemPrice;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    return data;
  }
}
