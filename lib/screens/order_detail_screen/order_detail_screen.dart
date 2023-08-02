import 'package:chef_panel/helper/constant/styles.dart';
import 'package:chef_panel/models/order_model.dart';
import 'package:chef_panel/provider/get_all_order.dart';
import 'package:chef_panel/screens/order_detail_screen/widget/cart_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              "Order Details",
              style: titleTextStyle,
            ),
            scrolledUnderElevation: 0.0,
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: wp(2, context), vertical: hp(2, context)),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: wp(2, context), vertical: hp(1.5, context)),
                  child: SizedBox(
                    width: wp(100, context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Items",
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
                          "Order Instructions",
                          style: textBodyStyle,
                        ),
                        const Divider(),
                        Text(orderData.orderInstructions!),
                      ],
                    ),
                  ),
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
                  } else {
                    orderProvider.updatePreparing(
                        orderData.id, "completed", context);
                  }
                },
                child: Text(
                  orderData.orderStatus == "pending"
                      ? "Start Preparing"
                      : "Complete Order",
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
