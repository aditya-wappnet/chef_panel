// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/loading_dialog.dart';
import '../routes/routes_const.dart';

class LoginInProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;

  TextEditingController signemailController = TextEditingController();
  TextEditingController signpassController = TextEditingController();

  signInProvider() {
    _checkCurrentUser();
  }

  User? get user => _user;

  Future<void> _checkCurrentUser() async {
    _user = _auth.currentUser;
    notifyListeners();
  }

  void clearText() {
    signpassController.clear();
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      if (signemailController.text.isNotEmpty &&
          signpassController.text.isNotEmpty) {
        showCustomLoadingDialog(context);
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
                email: signemailController.text,
                password: signpassController.text);
        _user = userCredential.user;
        notifyListeners();

        await Future.delayed(const Duration(seconds: 2)).then((value) {
          clearText();
          closeCustomLoadingDialog(context);
          Navigator.popAndPushNamed(context, RoutesName.bottomBar);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "All field must be filled",
            ),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        clearText();
        closeCustomLoadingDialog(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Email id and password wrong",
            ),
            duration: Duration(seconds: 3),
          ),
        );
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        clearText();
        closeCustomLoadingDialog(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Wrong password please try again..",
            ),
            duration: Duration(seconds: 3),
          ),
        );
        log('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        clearText();
        closeCustomLoadingDialog(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "You mail formate is invalid...",
            ),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        clearText();
        closeCustomLoadingDialog(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Somthing went wrong please try again...",
            ),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    _user = null;
    Navigator.popAndPushNamed(context, RoutesName.siginView);
    notifyListeners();
  }
}
