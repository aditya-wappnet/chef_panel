import 'package:chef_panel/routes/routes_const.dart';
import 'package:chef_panel/screens/change_language_screen/change_language_screen.dart';
import 'package:chef_panel/screens/home_screen.dart';
import 'package:chef_panel/screens/login_screen/login_screen.dart';
import 'package:chef_panel/screens/notification/notification_screen.dart';
import 'package:chef_panel/screens/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localizations.dart';
import '../helper/helpers.dart';
import '../provider/connectivity_provider.dart';
import '../screens/no_internet_screen.dart';
import '../screens/order_detail_screen/order_detail_screen.dart';
import '../screens/orders_screen/orders_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic arguments = settings.arguments;
    BuildContext? context = AppContext.navigatorKey.currentContext;
    switch (settings.name) {
      case RoutesName.LOGIN_SCREEN_ROUTE:
        return _buildPageRoute(const LoginScreen());

      case RoutesName.HOME_SCREEN_ROUTE:
        return _buildPageRoute(const HomeScreen());

      case RoutesName.ORDERS_SCREEN_ROUTE:
        return _buildPageRoute(const OrdersScreen());

      case RoutesName.NOTIFICATION_SCREEN_ROUTE:
        return _buildPageRoute(const NotificationScreen());

      case RoutesName.ORDER_DETAILS_SCREEN_ROUTE:
        return _buildPageRoute(OrderDetailScreen(orderId: arguments));

      case RoutesName.SETTINGS_SCREEN_ROUTE:
        return _buildPageRoute(const SettingsScreen());

      case RoutesName.CHANGE_LANGUAGE_SCREEN_ROUTE:
        return _buildPageRoute(const ChangeLanguageScreen());

      default:
        return _buildPageRoute(Scaffold(
          body: Center(
              child: Text(
                  AppLocalizations.of(context!).translate("no_route_defined"))),
        ));
    }
  }

  static PageRouteBuilder<Object> _buildPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final isInternetAvailable =
            Provider.of<ConnectivityProvider>(context).isInternetAvailable;
        if (!isInternetAvailable) {
          return const NoInternetScreen();
        } else {
          return page;
        }
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        final Animation<Offset> slideAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
        return SlideTransition(
          position: slideAnimation,
          child: child,
        );
      },
      transitionDuration:
          const Duration(milliseconds: 600), // Adjust the duration as needed
    );
  }
}
