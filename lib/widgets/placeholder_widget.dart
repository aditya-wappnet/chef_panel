import 'package:flutter/material.dart';

import '../helper/assets/assets_util.dart';
import '../helper/constant/styles.dart';
import '../helper/responsive.dart';

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Image.asset(
            AssetsUtils.ASSETS_EMPTY_MENU_IMAGE,
            height: hp(30, context),
            width: wp(50, context),
            fit: BoxFit.fill,
          ),
          Text(
            title,
            style: smallTitleTextStyle,
          ),
        ],
      ),
    );
  }
}
