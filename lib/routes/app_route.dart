import 'package:chef_panel/models/order_model.dart';
import 'package:chef_panel/routes/routes_const.dart';
import 'package:chef_panel/screens/home_screen.dart';
import 'package:chef_panel/screens/login_screen/login_screen.dart';
import 'package:chef_panel/screens/notification/notification_screen.dart';
import 'package:flutter/material.dart';

import '../screens/order_detail_screen/order_detail_screen.dart';
import '../screens/orders_screen/orders_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.siginView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.bottomBar:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesName.homeView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const OrdersScreen());

      case RoutesName.completedOrder:
        return MaterialPageRoute(
            builder: (BuildContext context) => const NotificationScreen());

      case RoutesName.orderDetailView:
        return MaterialPageRoute(
            builder: (BuildContext context) => OrderDetailScreen(
                  orderData: OrderData(),
                ));

      default:
        // SystemNavigator.pop();
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text('No route defined')),
          );
        });
    }
  }
}
