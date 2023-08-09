import 'package:chef_panel/helper/constant/strings.dart';
import 'package:chef_panel/helper/responsive.dart';
import 'package:chef_panel/provider/auth_provider.dart';
import 'package:chef_panel/routes/routes_const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';
import '../../helper/constant/styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).translate('settings'),
              style: titleTextStyle,
            ),
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0.0,
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: hp(2, context), horizontal: wp(2, context)),
              child: SizedBox(
                child: Column(
                  children: [
                    const Divider(),
                    SizedBox(
                      height: hp(1, context),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutesName.CHANGE_LANGUAGE_SCREEN_ROUTE);
                      },
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('change_language'),
                            style: textBodyStyle,
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_outlined),
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
                        authProvider.logout(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).translate('logout'),
                            style: textSmallRegularStyle.copyWith(
                                color: Colors.red, fontFamily: fontSemiBold),
                          ),
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
            ),
          ),
        );
      },
    );
  }
}
