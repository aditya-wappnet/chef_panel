import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chef_panel/firebase_options.dart';
import 'package:chef_panel/helper/assets/assets_util.dart';
import 'package:chef_panel/provider/AppLanguage.dart';
import 'package:chef_panel/provider/auth_provider.dart';
import 'package:chef_panel/provider/connectivity_provider.dart';
import 'package:chef_panel/provider/nav_provider.dart';
import 'package:chef_panel/provider/notification_provider.dart';
import 'package:chef_panel/routes/app_route.dart';
import 'package:chef_panel/routes/routes_const.dart';
import 'package:chef_panel/screens/home_screen.dart';
import 'package:chef_panel/screens/login_screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'app_localizations.dart';
import 'helper/constant/strings.dart';
import 'helper/helpers.dart';
import 'network/network_api_services.dart';
import 'provider/order_provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  log('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  NetworkApiService().setupInterceptors();
  final isLoggedIn = await AuthProvider.checkUserLogin();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(isLoggedIn: isLoggedIn, appLanguage: appLanguage));
}

/// push notification configuration

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.high,
    enableLights: true,
    enableVibration: true,
    showBadge: true,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget {
  final bool? isLoggedIn;
  final AppLanguage appLanguage;
  const MyApp({Key? key, this.isLoggedIn, required this.appLanguage})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.purple,
                enableLights: true,
                enableVibration: true,
                importance: Importance.high,
                playSound: true,
                ledOnMs: 1,
                ledOffMs: 2,
                ledColor: Colors.green,
                priority: Priority.high,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: "@mipmap/ic_launcher",
                channelShowBadge: true,
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        showDialog(
            // context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            },
            context: context);
      }
    });

    getToken();
  }

  late String token;

  getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
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
        ChangeNotifierProvider<AppLanguage>(
          create: (_) => widget.appLanguage,
        ),
      ],
      child: Consumer<AppLanguage>(
        builder: (context, model, child) {
          return ChangeNotifierProvider<AppLanguage>.value(
            value: model,
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
                    locale: model.appLocal,
                    supportedLocales: const [
                      Locale('en', 'US'),
                      Locale('ar', ''),
                    ],
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate
                    ],
                  );
                }),
          );
        },
      ),
    );
  }
}
