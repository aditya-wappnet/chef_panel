class OrderDetailsModel {
  bool? status;
  String? message;
  List<OrderDetail>? orderDetails;

  OrderDetailsModel({this.status, this.message, this.orderDetails});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      orderDetails = <OrderDetail>[];
      json['data'].forEach((v) {
        orderDetails!.add(OrderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.orderDetails != null) {
      data['data'] = this.orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetail {
  int? id;
  int? user;
  String? customerName;
  int? tableNo;
  List<CartItems>? cartItem;
  String? orderStatus;
  String? paymentStatus;
  String? createdAt;
  String? totalPrice;
  dynamic remainingDuration;
  String? orderInstructions;

  OrderDetail(
      {this.id,
      this.user,
      this.customerName,
      this.tableNo,
      this.cartItem,
      this.orderStatus,
      this.paymentStatus,
      this.createdAt,
      this.totalPrice,
      this.remainingDuration,
      this.orderInstructions});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    customerName = json['customer_name'];
    tableNo = json['table_no'];
    if (json['cart_items'] != null) {
      cartItem = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItem!.add(CartItems.fromJson(v));
      });
    }
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    totalPrice = json['total_price'];
    remainingDuration = json['remaining_duration'];
    orderInstructions = json['order_instructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['customer_name'] = customerName;
    data['table_no'] = tableNo;
    if (cartItem != null) {
      data['cart_items'] = cartItem!.map((v) => v.toJson()).toList();
    }
    data['order_status'] = orderStatus;
    data['payment_status'] = paymentStatus;
    data['created_at'] = createdAt;
    data['total_price'] = totalPrice;
    data['remaining_duration'] = remainingDuration;
    data['order_instructions'] = orderInstructions;
    return data;
  }
}

class CartItems {
  int? itemId;
  String? itemName;
  double? itemPrice;
  int? quantity;
  String? itemImage;
  double? total;

  CartItems(
      {this.itemId,
      this.itemName,
      this.itemPrice,
      this.quantity,
      this.itemImage,
      this.total});

  CartItems.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemName = json['item_name'];
    itemPrice = json['item_price'];
    quantity = json['quantity'];
    itemImage = json['item_image'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['item_name'] = itemName;
    data['item_price'] = itemPrice;
    data['quantity'] = quantity;
    data['item_image'] = itemImage;
    data['total'] = total;
    return data;
  }
}
