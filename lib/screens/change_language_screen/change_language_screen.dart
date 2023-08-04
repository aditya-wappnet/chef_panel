import 'package:chef_panel/helper/constant/styles.dart';
import 'package:chef_panel/helper/responsive.dart';
import 'package:chef_panel/provider/AppLanguage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLanguage>(
      builder: (context, appLanguage, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).translate('change_language'),
              style: titleTextStyle,
            ),
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: wp(2.5, context), vertical: hp(2, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      AppLocalizations.of(context).translate('select_language'),
                      style: textRegularStyle),
                  const Divider(),
                  SizedBox(
                    height: hp(1, context),
                  ),
                  GestureDetector(
                    onTap: () {
                      appLanguage.changeLanguage(const Locale('en', 'US'));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "English (US)",
                          style: textBodyStyle,
                        ),
                        const Spacer(),
                        appLanguage.appLocal == const Locale('en', 'US')
                            ? const Icon(
                                Icons.check_rounded,
                                color: Colors.black,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: hp(1, context),
                  ),
                  const Divider(),
                  SizedBox(
                    height: hp(1, context),
                  ),
                  GestureDetector(
                    onTap: () {
                      appLanguage.changeLanguage(const Locale("ar"));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Arabic",
                          style: textBodyStyle,
                        ),
                        const Spacer(),
                        appLanguage.appLocal == const Locale("ar")
                            ? const Icon(
                                Icons.check_rounded,
                                color: Colors.black,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: hp(1, context),
                  ),
                  const Divider(),
                  SizedBox(
                    height: hp(1, context),
                  ),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
