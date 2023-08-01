import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomFlushbar {
  static void showSuccess(BuildContext context, String message,
      {Function? onDismissed}) {
    Flushbar(
      message: message,
      backgroundColor: Colors.green,
      icon: const Icon(
        Icons.check,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 1),
      animationDuration: const Duration(milliseconds: 500),
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      flushbarPosition: FlushbarPosition.TOP,
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED && onDismissed != null) {
          onDismissed();
        }
      },
    ).show(context);
  }

  static void showError(BuildContext context, String message,
      {Function? onDismissed}) {
    Flushbar(
      message: message,
      backgroundColor: Colors.red,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 1),
      animationDuration: const Duration(milliseconds: 500),
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      flushbarPosition: FlushbarPosition.TOP,
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED && onDismissed != null) {
          onDismissed();
        }
      },
    ).show(context);
  }

  static void showInfo(BuildContext context, String message,
      {Function? onDismissed}) {
    Flushbar(
      message: message,
      backgroundColor: Colors.amberAccent,
      icon: const Icon(
        Icons.info,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 1),
      animationDuration: const Duration(milliseconds: 500),
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      flushbarPosition: FlushbarPosition.TOP,
      onStatusChanged: (status) {
        if (status == FlushbarStatus.DISMISSED && onDismissed != null) {
          onDismissed();
        }
      },
    ).show(context);
  }
}