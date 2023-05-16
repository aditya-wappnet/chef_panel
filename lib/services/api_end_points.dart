// ignore_for_file: library_private_types_in_public_api

class ApiEndPoint {
  static const String baseUrl = "http://192.168.10.179:8001/api/";

  static _AuthEndPoint authEndPoint = _AuthEndPoint();

  static _Orders orders = _Orders();
}

class _AuthEndPoint {
  final String login = "chef/chef_login/";
}

class _Orders {
  final String getOrders = "chef/all_orders/";

  final String updateOrderStatus = "chef/order/update/";
}
