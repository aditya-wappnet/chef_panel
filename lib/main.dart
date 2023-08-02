import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chef_panel/firebase_options.dart';
import 'package:chef_panel/helper/assets/assets_util.dart';
import 'package:chef_panel/provider/auth_provider.dart';
import 'package:chef_panel/provider/connectivity_provider.dart';
import 'package:chef_panel/provider/nav_provider.dart';
import 'package:chef_panel/provider/notification_provider.dart';
import 'package:chef_panel/routes/app_route.dart';
import 'package:chef_panel/routes/routes_const.dart';
import 'package:chef_panel/screens/home_screen.dart';
import 'package:chef_panel/screens/login_screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'helper/constant/strings.dart';
import 'helper/helpers.dart';
import 'network/network_api_services.dart';
import 'provider/get_all_order.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NetworkApiService().setupInterceptors();
  final isLoggedIn = await AuthProvider.checkUserLogin();

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatefulWidget {
  final bool? isLoggedIn;
  const MyApp({
    Key? key,
    this.isLoggedIn,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavProvider(),
        ),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(820, 1180),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: APPNAME,
              theme: ThemeData(
                  useMaterial3: true,
                  colorSchemeSeed: Colors.purple,
                  fontFamily: 'Roboto'),
              onGenerateRoute: Routes.generateRoute,
              home: AnimatedSplashScreen(
                duration: 3000,
                nextRoute: widget.isLoggedIn!
                    ? RoutesName.HOME_SCREEN_ROUTE
                    : RoutesName.LOGIN_SCREEN_ROUTE,
                splashTransition: SplashTransition.scaleTransition,
                backgroundColor: Colors.white,
                animationDuration: const Duration(seconds: 2),
                splashIconSize: 600.sp,
                splash: Center(
                  child: Lottie.asset(
                    AssetsUtils.ASSETS_COOKING_ANIMATION,
                    height: 500.h,
                    width: 500.w,
                  ),
                ),
                nextScreen: widget.isLoggedIn!
                    ? const HomeScreen()
                    : const LoginScreen(),
              ),
              navigatorKey: AppContext.navigatorKey,
            );
          }),
    );
  }
}
