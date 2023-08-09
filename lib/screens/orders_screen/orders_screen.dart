// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chef_panel/helper/responsive.dart';
import 'package:chef_panel/provider/order_provider.dart';
import 'package:chef_panel/routes/routes_const.dart';
import 'package:chef_panel/screens/orders_screen/widget/order_item_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';
import '../../helper/assets/assets_util.dart';
import '../../helper/constant/styles.dart';
import '../../widgets/custom_confirmation_dialog_widget.dart';
import '../../widgets/placeholder_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().getOrders(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            scrolledUnderElevation: 0.0,
            automaticallyImplyLeading: false,
            title: Text(
              AppLocalizations.of(context).translate('orders'),
              style: titleTextStyle,
            ),
          ),
          body: SafeArea(
            child: Center(
              child: Consumer<OrderProvider>(
                builder: (context, orderProvider, __) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: wp(2, context), vertical: hp(2, context)),
                    child: orderProvider.loading
                        ? Center(
                            child: Lottie.asset(
                              AssetsUtils.ASSETS_LOADING_ANIMATION,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Column(
                            children: [
                              Expanded(
                                child: (orderProvider.orderList.isEmpty)
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            PlaceholderWidget(
                                                title: AppLocalizations.of(
                                                        context)
                                                    .translate('no_orders')),
                                          ],
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount:
                                            orderProvider.orderList.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          var order =
                                              orderProvider.orderList[index];
                                          return OrderItemCardWidget(
                                            orderData: order,
                                            cancelCallback: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return CustomConfirmationDialog(
                                                    title: AppLocalizations.of(
                                                            context)
                                                        .translate(
                                                            'cancel_order'),
                                                    message: AppLocalizations
                                                            .of(context)
                                                        .translate(
                                                            'cancel_order_message'),
                                                    onConfirm: () async {
                                                      orderProvider.cancelOrder(
                                                          order.id!, context);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            viewDetailsCallback: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  RoutesName
                                                      .ORDER_DETAILS_SCREEN_ROUTE,
                                                  arguments: order.id);
                                            },
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
