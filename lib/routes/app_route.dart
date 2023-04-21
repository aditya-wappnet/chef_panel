import 'package:chef_panel/routes/routes_const.dart';
import 'package:chef_panel/screens/completed_order_screen.dart/completed_order.dart';
import 'package:chef_panel/screens/home_screen/home_screen.dart';
import 'package:chef_panel/screens/login_screen/login_screen.dart';
import 'package:chef_panel/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

import '../screens/order_detail_screen/order_detail_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.siginView:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());

      case RoutesName.bottomBar:
        return MaterialPageRoute(
            builder: (BuildContext context) => const BottomNavBar());

      case RoutesName.homeView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesName.completedOrder:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CompletedOrder());

      case RoutesName.orderDetailView:
        return MaterialPageRoute(
            builder: (BuildContext context) => OrderDetailScreen());

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
