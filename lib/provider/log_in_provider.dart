import 'dart:developer';

import 'package:chef_panel/repository/auth_repository.dart';
import 'package:chef_panel/routes/routes_const.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../network/db_provider.dart';
import '../widgets/custom_flush_bar_widget.dart';

class LoginInProvider with ChangeNotifier {
  TextEditingController signemailController = TextEditingController();
  TextEditingController signpassController = TextEditingController();

  final AuthRepository _authRepository = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  loginApi(String email, String password, BuildContext context) async {
    setLoading(true);
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcmToken = await messaging.getToken();
    var data = {"email": email, "password": password, "fcmToken": fcmToken};
    log(data.toString());
    _authRepository.loginApi(data).then((response) {
      log("response : " + response.toString());
      if (response != null) {
        if (response.statusCode == 200) {
          setLoading(false);
          String token = response.data['data']['token'];
          DatabaseProvider().saveToken(token);
          Navigator.popAndPushNamed(context, RoutesName.bottomBar);
          clearText();
          signemailController.clear();
          notifyListeners();
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(context, response.data['message'],
              onDismissed: () {});
          setLoading(false);
        }
      } else {
        // CustomFlushbar.showError(
        //     context,
        //     AppLocalizations.of(context)
        //         .translate('error_occurred_error_message'),
        //     onDismissed: () {});
        setLoading(false);
      }
    }).catchError((error) {
      // handleDioException(context, error);
      setLoading(false);
    });
  }

  //Function to Remove token got during logout
  Future<void> logout(BuildContext context) async {
    DatabaseProvider().clear();
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.siginView,
      (_) => false,
    );
  }

  //Function to Store token got during login
  static Future<bool> checkUserLogin() async {
    String? token = await DatabaseProvider().getToken();
    if (token.isEmpty) {
      return false;
    }

    return true;
  }

  void clearText() {
    signpassController.clear();
  }
}
