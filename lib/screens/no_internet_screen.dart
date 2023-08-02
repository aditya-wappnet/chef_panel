import 'package:flutter/material.dart';

import '../helper/assets/assets_util.dart';
import '../helper/constant/strings.dart';
import '../helper/constant/styles.dart';
import '../helper/responsive.dart';
import '../widgets/custom_outlined_button.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsUtils.ASSETS_NO_INTERNET_IMAGE,
              height: hp(30, context),
              width: wp(50, context),
            ),
            Text(
              "Woops!",
              style: smallTitleTextStyle.copyWith(fontFamily: fontSemiBold),
            ),
            SizedBox(height: hp(1, context)),
            const Text(
                "No internet connectivity please check your internet connection"),
            SizedBox(height: hp(1, context)),
            CustomOutlinedButton(
                onPressed: () {},
                child: Text(
                  "Try again",
                  style: textSmallMediumStyle,
                )),
          ],
        ),
      ),
    );
  }
}
