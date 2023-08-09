import 'package:cached_network_image/cached_network_image.dart';
import 'package:chef_panel/helper/constant/styles.dart';
import 'package:flutter/material.dart';

import '../../../helper/assets/assets_util.dart';
import '../../../helper/responsive.dart';
import '../../../models/order_details_model.dart';

class CartItemsWidget extends StatelessWidget {
  const CartItemsWidget({super.key, this.cartItems});
  final CartItems? cartItems;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: wp(1, context), vertical: hp(1, context)),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: cartItems?.itemImage ?? "",
              fit: BoxFit.cover,
              width: wp(18, context),
              height: hp(9, context),
              placeholder: (context, url) =>
                  Image.asset(AssetsUtils.ASSETS_PLACEHOLDER_IMAGE),
              // Show a placeholder while loading
              errorWidget: (context, url, error) =>
                  Image.asset(AssetsUtils.ASSETS_ERROR_IMAGE),
            ),
            SizedBox(
              width: wp(3, context),
            ),
            Text(
              "${cartItems?.quantity ?? 0}x",
              style: textBodyStyle,
            ),
            SizedBox(
              width: wp(2, context),
            ),
            Text(
              cartItems?.itemName ?? "",
              style: textRegularStyle,
            ),
            SizedBox(
              width: wp(2, context),
            ),
          ],
        ),
      ),
    );
  }
}
