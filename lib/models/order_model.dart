class OrdersModel {
  bool? status;
  String? message;
  List<OrderData>? orderData;

  OrdersModel({this.status, this.message, this.orderData});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      orderData = <OrderData>[];
      json['data'].forEach((v) {
        orderData!.add(OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orderData != null) {
      data['data'] = orderData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderData {
  int? id;
  int? user;
  String? customerName;
  int? tableNo;
  List<CartItems>? cartItems;
  String? orderStatus;
  String? paymentStatus;
  String? createdAt;
  String? totalPrice;
  dynamic remainingDuration;
  String? orderInstructions;

  OrderData(
      {this.id,
      this.user,
      this.customerName,
      this.tableNo,
      this.cartItems,
      this.orderStatus,
      this.paymentStatus,
      this.createdAt,
      this.totalPrice,
      this.remainingDuration,
      this.orderInstructions});

  OrderData.fromJson(Map<String, dynamic> json) {
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
    remainingDuration = json['remaining_duration'];
    orderInstructions = json['order_instructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['customer_name'] = customerName;
    data['table_no'] = tableNo;
    if (cartItems != null) {
      data['cart_items'] = cartItems!.map((v) => v.toJson()).toList();
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
  dynamic? total;
  int? quantity;
  String? itemName;
  String? itemImage;
  dynamic? itemPrice;
  int? itemId;

  CartItems(
      {this.total,
      this.quantity,
      this.itemName,
      this.itemImage,
      this.itemPrice,
      this.itemId});

  CartItems.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    quantity = json['quantity'];
    itemName = json['item_name'];
    itemImage = json['item_image'];
    itemPrice = json['item_price'];
    itemId = json['item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['quantity'] = quantity;
    data['item_name'] = itemName;
    data['item_image'] = itemImage;
    data['item_price'] = itemPrice;
    data['item_id'] = itemId;
    return data;
  }
}
