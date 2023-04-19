// ignore_for_file: unused_field, prefer_final_fields, must_be_immutable

import 'package:chef_panel/screens/completed_order_screen.dart/completed_order.dart';
import 'package:chef_panel/screens/home_screen/home_screen.dart';
import 'package:chef_panel/widgets/custom_dailog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  final List<Widget> _pages = [HomeScreen(), CompletedOrder()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                heading: 'Exit App',
                icon: const Icon(Icons.exit_to_app),

                title: 'Are you sure want to exit app ?',
                descriptions: "", //
                btn1Text: 'Exit',
                btn2Text: 'Cancel',
                onClicked: () {
                  SystemNavigator.pop();
                  //_showRatingPrompt();
                },
              );
            });
        return Future.value(true);
      },
      child: Scaffold(
          bottomNavigationBar: ValueListenableBuilder(
              valueListenable: _currentIndex,
              builder: (context, value, child) {
                return SalomonBottomBar(
                  currentIndex: _currentIndex.value,
                  onTap: (i) => _currentIndex.value = i,
                  items: [
                    /// Home
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.food_bank),
                      title: Text(
                        'Orders',
                      ),
                      selectedColor: Colors.black,
                    ),

                    SalomonBottomBarItem(
                      icon: const Icon(Icons.done_rounded),
                      title: Text(
                        'Completed Orders',
                      ),
                      selectedColor: Colors.black,
                    ),
                  ],
                );
              }),
          body: ValueListenableBuilder(
              valueListenable: _currentIndex,
              builder: (context, value, child) {
                return _pages[_currentIndex.value];
              })),
    );
  }
}
