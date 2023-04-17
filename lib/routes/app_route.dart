import 'package:get/get.dart';
import 'package:resturant_menu/routes/routes_const.dart';

import '../screens/login_screen/login_binding.dart';
import '../screens/login_screen/login_screen.dart';

class AppRoute {
  AppRoute._();
  static final route = [
    GetPage(
        name: LOGIN_SCREEN_ROUTE,
        page: () => LoginScreen(),
        binding: LoginBinding()),
  ];
}
