// ignore_for_file: unused_field, prefer_collection_literals, avoid_print, use_build_context_synchronously

import 'package:chef_panel/models/order_model.dart';
import 'package:chef_panel/repository/get_orders_repository.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_dailog.dart';

class GetOrders with ChangeNotifier {
  final _myRepo = OrderRepository();

//store  order data from api fetch
  List<Data> orderList = [];

  Set<int> addedIds = {};

  bool ispreparing = false;
  bool get isPreparing => ispreparing;

  setLoading(bool value) {
    ispreparing = value;
    notifyListeners();
  }

  Stream<List<Data>> orderStream() async* {
    print('stream');
    yield await getCustomerOrder(); // Yield the latest data fetched from the server
  }

  Future<List<Data>> getCustomerOrder() async {
    var response = await _myRepo.getOrders();
    try {
      if (response != null) {
        if (response['status'] == true) {
          var getOrder = Orders.fromJson(response);

          if (getOrder.data!.isNotEmpty) {
            var addedIds = Set<int>();

            orderList.clear();
            orderList.addAll(getOrder.data!);

            for (var data in getOrder.data!) {
              // Check if category already exists
              if (!addedIds.contains(data.id)) {
                // categoryList.add(GetCategory(data: [data]));
                addedIds.add(data.id!); // Add categoryId to Set
              }
            }

            print('###$orderList');
            return orderList;
          }
        } else {}
      }
    } catch (e, stackTrace) {
      print(e);
      print('Stack trace: $stackTrace');
    }
    // Return an empty list if there was an error
    return [];
  }

  Future<void> updatePreparing(
      dynamic param, String status, BuildContext context) async {
    var response = await _myRepo.updateOrderStatus(param, status);
    setLoading(true);
    try {
      if (response != null) {
        if (response.statusCode == 200) {
          await getCustomerOrder();
          setLoading(false);
        } else {}
      }
    } catch (e, stackTrace) {
      print(e);
      print('Stack trace: $stackTrace');
    }
    // Return an empty list if there was an error
  }
}
