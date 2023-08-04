import 'package:chef_panel/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';
import '../../helper/assets/assets_util.dart';
import '../../helper/constant/styles.dart';
import '../../helper/responsive.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_textform_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _unfocusNode = FocusNode();

  ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);

  GlobalKey<FormState> logininFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: wp(4, context), vertical: hp(2, context)),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: wp(40, context), // Adjust the percentage as needed
                      height: wp(40,
                          context), // Using the same percentage to maintain aspect ratio
                      child: Image.asset(AssetsUtils.ASSETS_MOBILE_LOGIN_IMAGE),
                    ),
                    Text(
                      AppLocalizations.of(context).translate('chef_login'),
                      style: titleTextStyle,
                    ),
                    SizedBox(height: hp(2, context)),
                    Text(
                      AppLocalizations.of(context)
                          .translate('enter_your_credentials'),
                      style: textRegularStyle.copyWith(
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: hp(2, context)), // Use hp() for height
                    Form(
                      key: logininFormKey,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            CustomTextFormField().getCustomEditTextArea(
                              labelValue: AppLocalizations.of(context)
                                  .translate('label_email'),
                              hintValue: AppLocalizations.of(context)
                                  .translate('hint_email'),
                              obscuretext: false,
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              prefixicon: const Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                              ),
                              textInputAction: TextInputAction.next,
                              controller: authProvider.signemailController,
                              onchanged: (newValue) {},
                              validator: (p0) {
                                return null;
                              },
                            ),
                            SizedBox(
                                height: hp(2, context)), // Use hp() for height
                            ValueListenableBuilder(
                              valueListenable: obsecurePassword,
                              builder: (context, value, child) {
                                return CustomTextFormField()
                                    .getCustomEditTextArea(
                                        labelValue: AppLocalizations.of(context)
                                            .translate('label_password'),
                                        hintValue: AppLocalizations.of(context)
                                            .translate('hint_password'),
                                        obscuretext: obsecurePassword.value,
                                        maxLines: 1,
                                        validator: (p0) {
                                          return null;
                                        },
                                        textInputAction: TextInputAction.done,
                                        prefixicon: const Icon(
                                          Icons.password_outlined,
                                          color: Colors.black,
                                        ),
                                        controller:
                                            authProvider.signpassController,
                                        onchanged: (newValue) {},
                                        icon: InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            obsecurePassword.value =
                                                !obsecurePassword.value;
                                          },
                                          child: obsecurePassword.value
                                              ? const Icon(
                                                  Icons.visibility_off_outlined,
                                                  color: Colors.black,
                                                )
                                              : const Icon(
                                                  Icons.visibility_outlined,
                                                  color: Colors.black,
                                                ),
                                        ));
                              },
                            ),
                            SizedBox(
                                height: hp(1, context)), // Use hp() for height
                            SizedBox(
                                height: hp(1, context)), // Use hp() for height
                            SizedBox(
                              height: hp(7.5, context), // Use hp() for height
                              width: double.infinity,
                              child: CustomButton(
                                onPressed: () async {
                                  if (logininFormKey.currentState!.validate()) {
                                    authProvider.loginApi(
                                      authProvider.signemailController.text,
                                      authProvider.signpassController.text,
                                      context,
                                    );
                                  }
                                },
                                child: authProvider.loading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        AppLocalizations.of(context)
                                            .translate('login'),
                                        style: textBodyStyle.copyWith(
                                            color: Colors.white),
                                      ),
                              ),
                            ),
                            SizedBox(height: hp(1, context)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
