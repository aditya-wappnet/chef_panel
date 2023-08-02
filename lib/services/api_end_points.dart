class ApiEndPoint {
  static const String baseUrl = "http://192.168.10.79:8001/api/";

  static _AuthEndPoint authEndPoint = _AuthEndPoint();

  static _Orders orders = _Orders();

  static _Notification notification = _Notification();
}

class _AuthEndPoint {
  final String login = "chef/chef_login/";
}

class _Orders {
  final String getOrders = "chef/all_orders/";

  final String updateOrderStatus = "chef/order/update/";

  final String cancelOrder = "chef/order/delete/";
}

class _Notification {
  final String getNotifications = "notifications/";

  final String deleteNotifications = "notifications/";
}
