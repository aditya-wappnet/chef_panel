// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:chef_panel/provider/log_in_provider.dart';
import 'package:chef_panel/widgets/app_button.dart';
import 'package:chef_panel/widgets/build_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../helper/validation/validation.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    final provider = Provider.of<LoginInProvider>(context, listen: false);
    provider.onInit();

    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _unfocusNode = FocusNode();

  ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);

  GlobalKey<FormState> logininFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginInProvider>(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            key: scaffoldKey,
            body: SingleChildScrollView(
              child: Form(
                key: logininFormKey,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.sp),
                    width: size.width,
                    height: size.height,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.white],
                        stops: [0.4, 1],
                        begin: AlignmentDirectional(0, -1),
                        end: AlignmentDirectional(0, 1),
                      ),
                    ),
                    alignment: const AlignmentDirectional(0, 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                maxWidth: 750.w,
                              ),
                              decoration: const BoxDecoration(),
                              child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.sp),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/ic_chef.png',
                                              width: 270.w,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          ' Welcome!',
                                          style: GoogleFonts.roboto(
                                              fontSize: 58.sp,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          'Use the form below to access your account.',
                                          style: GoogleFonts.roboto(
                                              fontSize: 32.sp,
                                              color: Colors.white),
                                        ),
                                        BuildTextFormField(
                                          errorTextColor: Colors.white,
                                          isObserve: false,
                                          controller:
                                              provider.signemailController,
                                          leftIcon: Icon(
                                              Icons.person_outline_rounded,
                                              color: Colors.white),
                                          txtHint: 'Enter Email',
                                          validation: emailValidator,
                                        ),
                                        ValueListenableBuilder(
                                            valueListenable: obsecurePassword,
                                            builder: (context, value, child) {
                                              return BuildTextFormField(
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  errorTextColor: Colors.white,
                                                  controller: provider
                                                      .signpassController,
                                                  validation: passwordValidator,
                                                  isObserve:
                                                      obsecurePassword.value,
                                                  leftIcon: const Icon(
                                                      Icons.lock_outlined,
                                                      color: Colors.white),
                                                  txtHint: 'Enter Password',
                                                  icon: IconButton(
                                                      onPressed: () {
                                                        obsecurePassword.value =
                                                            !obsecurePassword
                                                                .value;
                                                      },
                                                      icon: obsecurePassword
                                                              .value
                                                          ? const Icon(
                                                              Icons
                                                                  .visibility_off,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : const Icon(
                                                              Icons.visibility,
                                                              color:
                                                                  Colors.white,
                                                            )));
                                            }),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (logininFormKey.currentState!
                                                .validate()) {
                                              Map data = {
                                                'email': provider
                                                    .signemailController.text
                                                    .toString(),
                                                'password': provider
                                                    .signpassController.text
                                                    .toString(),
                                              };
                                              provider.loginApi(data, context);
                                            }
                                          },
                                          child: provider.loading == true
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : AppButton(
                                                  sizes: 20,
                                                  height: 60.h,
                                                  text: 'SignIn'),
                                        )
                                      ])))
                        ])),
              ),
            )));
  }
}
