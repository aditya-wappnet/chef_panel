// ignore_for_file: use_build_context_synchronously, unused_field, prefer_final_fields, avoid_print

import 'package:chef_panel/helper/colors/custom_colors.dart';
import 'package:chef_panel/repository/auth_repository.dart';
import 'package:chef_panel/routes/routes_const.dart';
import 'package:chef_panel/widgets/custom_dailog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginInProvider with ChangeNotifier {
  TextEditingController signemailController = TextEditingController();
  TextEditingController signpassController = TextEditingController();

  void onInit() {
    signemailController.text = "chef@gmail.com";
    signpassController.text = "admin@123";
  }

  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    print(data);
    setLoading(true);
    _myRepo.loginApi(data).then((value) async {
      setLoading(false);
      if (kDebugMode) {
        print(value.toString());
        print(value['status']);
      }

      if (value['status'] == true) {
        String token = value['data']['token'];
        print(token);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        showDialog(
            barrierDismissible: true,
            barrierLabel: '',
            barrierColor: Colors.black38,
            builder: (BuildContext context) {
              return const CustomDialogBox(
                heading: "Success",
                icon: Icon(Icons.done),
                backgroundColor: AccentColor.lightGreenColor,
                title: "Login Successfull",
                descriptions: "", //
                btn1Text: "",
                btn2Text: "",
              );
            },
            context: context);
        await Future.delayed(const Duration(milliseconds: 2000)).then((value) =>
            Navigator.popAndPushNamed(context, RoutesName.bottomBar));
        clearText();
        signemailController.clear();
      } else if (value['status'] == false) {
        showDialog(
            barrierDismissible: true,
            barrierLabel: '',
            barrierColor: Colors.black38,
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                heading: "Verification",
                icon: const Icon(Icons.not_listed_location),
                backgroundColor: SematicColor.redColor,
                title: value['message']['errors'][0].toString(),
                descriptions: "", //
                btn1Text: "",
                btn2Text: "",
              );
            });
        await Future.delayed(const Duration(seconds: 3))
            .then((value) => Navigator.of(context).pop());
        clearText();
      }
    }).onError((error, stackTrace) async {
      setLoading(false);
      clearText();
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  //Function to Remove token got during logout
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.siginView,
      (_) => false,
    );
  }

  //Function to Store token got during login
  static Future<bool> checkUserLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null || token.isEmpty) {
      return false;
    }

    return true;
  }

  void clearText() {
    signpassController.clear();
  }
}
