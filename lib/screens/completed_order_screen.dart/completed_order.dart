import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.white],
            stops: [0.4, 1],
            begin: AlignmentDirectional(0, -1),
            end: AlignmentDirectional(-1, 1),
          ),
        ),
      )),
    );
  }
}
