// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:chef_panel/routes/routes_const.dart';
import 'package:chef_panel/widgets/app_button.dart';
import 'package:chef_panel/widgets/build_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Scaffold(
              key: scaffoldKey,
              body: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.sp),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.white],
                      stops: [0.4, 1],
                      begin: AlignmentDirectional(0, -1),
                      end: AlignmentDirectional(0, 1),
                    ),
                  ),
                  alignment: const AlignmentDirectional(0, 0),
                  child: SingleChildScrollView(
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            fontSize: 44.sp,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        'Use the form below to access your account.',
                                        style: GoogleFonts.roboto(
                                            fontSize: 32.sp,
                                            color: Colors.white),
                                      ),
                                      BuildTextFormField(
                                        isObserve: false,
                                        //controller: authViewModel.emailLoginPageController,
                                        leftIcon: Icon(
                                            Icons.person_outline_rounded,
                                            color: Colors.white),
                                        txtHint: 'Enter Email',
                                        // validation: emailValidator,
                                      ),
                                      ValueListenableBuilder(
                                          valueListenable: obsecurePassword,
                                          builder: (context, value, child) {
                                            return BuildTextFormField(
                                                isObserve:
                                                    obsecurePassword.value,
                                                leftIcon: const Icon(
                                                    Icons.lock_outlined,
                                                    color: Colors.white),
                                                txtHint: 'Enter Password',
                                                // validation: passwordValidator,
                                                icon: IconButton(
                                                    onPressed: () {
                                                      obsecurePassword.value =
                                                          !obsecurePassword
                                                              .value;
                                                    },
                                                    icon: obsecurePassword.value
                                                        ? const Icon(
                                                            Icons
                                                                .visibility_off,
                                                            color: Colors.white,
                                                          )
                                                        : const Icon(
                                                            Icons.visibility,
                                                            color: Colors.white,
                                                          )));
                                          }),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.popAndPushNamed(
                                              context, RoutesName.bottomBar);
                                        },
                                        child: AppButton(
                                            sizes: 20,
                                            height: 60.h,
                                            text: 'SignIn'),
                                      )
                                    ])))
                      ]))))),
    );
  }
}
