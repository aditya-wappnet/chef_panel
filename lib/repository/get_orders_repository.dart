// ignore_for_file: prefer_final_fields

import 'package:chef_panel/network/base_api_services.dart';
import 'package:chef_panel/network/network_api_services.dart';
import 'package:chef_panel/services/api_end_points.dart';

class OrderRepository {
  final BaseApiService _apiServices = NetworkApiService();

  getOrders() {
    try {
      return _apiServices.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.orders.getOrders);
    } catch (e) {
      rethrow;
    }
  }

  updateOrderStatus(dynamic param, String status) async {
    var data = {};
    try {
      dynamic response = await _apiServices.getPatchApiResponse(
          '${ApiEndPoint.baseUrl + ApiEndPoint.orders.updateOrderStatus + param.toString()}/?status=$status',
          data);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  cancelOrder(int id) async {
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          '${ApiEndPoint.baseUrl}${ApiEndPoint.orders.cancelOrder}$id/');

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
