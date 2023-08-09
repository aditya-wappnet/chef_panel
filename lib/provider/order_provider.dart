import 'dart:developer';

import 'package:chef_panel/models/order_details_model.dart';
import 'package:chef_panel/models/order_model.dart';
import 'package:chef_panel/repository/orders_repository.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';
import '../helper/helpers.dart';
import '../widgets/custom_flush_bar_widget.dart';

class OrderProvider with ChangeNotifier {
  final OrderRepository _orderRepository = OrderRepository();
//store  order data from api fetch
  List<OrderData> orderList = [];

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _showAnimation = false;
  bool get showAnimation => _showAnimation;

  setAnimation(bool value) {
    _showAnimation = value;
    notifyListeners();
  }

  // get all customer orders
  getOrders(BuildContext context) {
    _orderRepository.getOrders().then((response) async {
      setLoading(true);
      if (response != null) {
        if (response.data['status'] == true) {
          setLoading(false);
          var getOrders = OrdersModel.fromJson(response.data);
          orderList = getOrders.orderData!;
          notifyListeners();
        } else {
          setLoading(false);
        }
      } else {
        setLoading(false);
      }
    }).catchError((error) {
      setLoading(false);
      log(error.toString());
      handleDioException(context, error);
    });
  }

  updatePreparing(dynamic param, String status, BuildContext context) async {
    setLoading(true);
    await _orderRepository.updateOrderStatus(param, status).then((response) {
      if (response != null) {
        if (response.data['status'] == true) {
          getOrders(context);
          CustomFlushbar.showSuccess(context, response.data['message']);
          setLoading(false);
          // Navigator.popAndPushNamed(context, RoutesName.HOME_SCREEN_ROUTE);
        } else if (response.data['status'] == false) {
          setLoading(false);
          CustomFlushbar.showError(context, response.data['message'],
              onDismissed: () {});
        }
      } else {
        setLoading(false);
        CustomFlushbar.showError(
            context,
            AppLocalizations.of(context)
                .translate('error_occurred_error_message'),
            onDismissed: () {});
        notifyListeners();
      }
    }).catchError((error) {
      log(error.toString());
      setLoading(false);
      // handleDioException(context, error);
    });
  }

  cancelOrder(int id, BuildContext context) {
    _orderRepository.cancelOrder(id).then((response) {
      if (response != null) {
        if (response.data['status'] == true) {
          getOrders(context);
          orderList.removeWhere((item) => item.id == id);
          CustomFlushbar.showSuccess(context, response.data['message'],
              onDismissed: () {});
          notifyListeners();
        } else if (response.data['status'] == false) {
          CustomFlushbar.showError(context, response.data['message'],
              onDismissed: () {});
          notifyListeners();
        }
      } else {
        CustomFlushbar.showError(
            context,
            AppLocalizations.of(context)
                .translate('error_occurred_error_message'),
            onDismissed: () {});
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }

  // get single order by id
  OrderDetail? orderDetail;
  getOrderDetail(BuildContext context, int id) {
    _orderRepository.getOrderDetails(id).then((response) async {
      setLoading(true);
      if (response != null) {
        if (response.data['status'] == true) {
          setLoading(false);
          OrderDetailsModel orderDetailsModel =
              OrderDetailsModel.fromJson(response.data);
          orderDetail = orderDetailsModel.orderDetails!.first;
          notifyListeners();
        } else {
          CustomFlushbar.showError(context, response.data['message'],
              onDismissed: () {});
          setLoading(false);
        }
      } else {
        CustomFlushbar.showError(
            context,
            AppLocalizations.of(context)
                .translate('error_occurred_error_message'),
            onDismissed: () {});
        setLoading(false);
      }
    }).catchError((error) {
      CustomFlushbar.showError(
          context,
          AppLocalizations.of(context)
              .translate('error_occurred_error_message'),
          onDismissed: () {});
      setLoading(false);
      log(error.toString());
      handleDioException(context, error);
    });
  }
}
