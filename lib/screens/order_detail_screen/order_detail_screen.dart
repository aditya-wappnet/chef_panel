import 'package:chef_panel/helper/constant/styles.dart';
import 'package:chef_panel/models/order_model.dart';
import 'package:chef_panel/provider/order_provider.dart';
import 'package:chef_panel/screens/order_detail_screen/widget/cart_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../app_localizations.dart';
import '../../helper/assets/assets_util.dart';
import '../../helper/responsive.dart';
import '../../widgets/custom_button_widget.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderData orderData;
  const OrderDetailScreen({Key? key, required this.orderData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).translate('order_details'),
              style: titleTextStyle,
            ),
            scrolledUnderElevation: 0.0,
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: wp(2, context), vertical: hp(2, context)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: wp(2, context),
                            vertical: hp(1.5, context)),
                        child: SizedBox(
                          width: wp(100, context),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate('order_items'),
                                style: textBodyStyle,
                              ),
                              const Divider(),
                              SizedBox(
                                height: hp(1, context),
                              ),
                              SizedBox(
                                child: ListView.builder(
                                  itemCount: orderData.cartItems?.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return CartItemsWidget(
                                      cartItems: orderData.cartItems![index],
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: hp(2, context),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate('label_cooking_instruction'),
                                style: textBodyStyle,
                              ),
                              const Divider(),
                              Text(orderData.orderInstructions!),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: hp(2, context),
                    ),
                    orderData.orderStatus == "preparing" ||
                            orderProvider.showAnimation
                        ? ShowUpAnimation(
                            animationDuration: const Duration(seconds: 1),
                            direction: Direction.vertical,
                            delayStart: const Duration(seconds: 1),
                            curve: Curves.easeIn,
                            offset: 0.5,
                            child: Lottie.asset(
                              AssetsUtils.ASSETS_FOOD_PREPARING_ANIMATION,
                              width: wp(75, context),
                              height: hp(35, context),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: wp(1.5, context), vertical: hp(1.5, context)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: hp(7.5, context),
              child: CustomButton(
                onPressed: () {
                  if (orderData.orderStatus == "pending") {
                    orderProvider.updatePreparing(
                        orderData.id, "preparing", context);
                    orderProvider.setAnimation(true);
                  } else {
                    orderProvider.updatePreparing(
                        orderData.id, "completed", context);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  orderData.orderStatus == "pending"
                      ? AppLocalizations.of(context)
                          .translate('start_preparing')
                      : AppLocalizations.of(context)
                          .translate('complete_order'),
                  style: textBodyStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
