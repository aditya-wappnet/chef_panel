import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chef_panel/routes/app_route.dart';
import 'package:chef_panel/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
                nextScreen: LoginScreen(),
              ));
        });
  }
}
