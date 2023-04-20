import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

//show loading dialog when data processing
void showCustomLoadingDialog(BuildContext context) async {
  SimpleFontelicoProgressDialog dialog =
      SimpleFontelicoProgressDialog(context: context);
  dialog.show(
      backgroundColor: Colors.white,
      indicatorColor: Colors.redAccent,
      message: "Please Wait...",
      radius: 10,
      type: SimpleFontelicoProgressDialogType.hurricane);
}

//hide loading dialog when data processing
Future<void> closeCustomLoadingDialog(BuildContext context) async {
  SimpleFontelicoProgressDialog dialog =
      SimpleFontelicoProgressDialog(context: context);
  Navigator.pop(context);
  dialog.hide();
}
