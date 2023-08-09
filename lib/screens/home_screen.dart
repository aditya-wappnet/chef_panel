// ignore_for_file: unused_field, prefer_final_fields, must_be_immutable

import 'package:chef_panel/helper/responsive.dart';
import 'package:chef_panel/screens/notification/notification_screen.dart';
import 'package:chef_panel/screens/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localizations.dart';
import '../provider/nav_provider.dart';
import 'orders_screen/orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _widgetOptions = <Widget>[
    const OrdersScreen(),
    const NotificationScreen(),
    const SettingsScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: hp(0.5, context), horizontal: wp(0.5, context)),
          child: Center(
            child: _widgetOptions.elementAt(navProvider.index),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        useLegacyColorScheme: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.fastfood_outlined),
            label: AppLocalizations.of(context).translate('orders'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications_none_outlined),
            label: AppLocalizations.of(context).translate('notification'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context).translate('settings'),
          ),
        ],
        currentIndex: navProvider.index,
        onTap: (int index) async {
          navProvider.changeIndex(index);
        },
      ),
    );
  }
}
