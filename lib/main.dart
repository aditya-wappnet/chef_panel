import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:chef_panel/firebase_options.dart';
import 'package:chef_panel/provider/log_in_provider.dart';
import 'package:chef_panel/routes/app_route.dart';
import 'package:chef_panel/screens/login_screen/login_screen.dart';
import 'package:chef_panel/widgets/bottom_nav.dart';

import 'provider/get_all_order.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final isLoggedIn = await LoginInProvider.checkUserLogin();

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
          create: (_) => LoginInProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetOrders(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(820, 1180),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Chef Panel',
                theme: ThemeData(
                  useMaterial3: true,
                  colorSchemeSeed: Colors.purple,
                ),
                onGenerateRoute: Routes.generateRoute,
                home: AnimatedSplashScreen(
                  duration: 3000,
                  splashTransition: SplashTransition.scaleTransition,
                  backgroundColor: Colors.white,
                  animationDuration: const Duration(seconds: 2),
                  splashIconSize: 600.sp,
                  splash: Center(
                    child: Lottie.asset(
                      'assets/images/ic_chef.json',
                      height: 500.h,
                      width: 500.w,
                    ),
                  ),
                  nextScreen:
                      widget.isLoggedIn! ? const BottomNavBar() : LoginScreen(),
                ));
          }),
    );
  }
}
