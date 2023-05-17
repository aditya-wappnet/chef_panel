// ignore_for_file: prefer_final_fields

import 'package:chef_panel/network/base_api_services.dart';
import 'package:chef_panel/network/network_api_services.dart';
import 'package:chef_panel/services/api_end_points.dart';

class OrderRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getOrders() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.orders.getOrders);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateOrderStatus(dynamic param, String status) async {
    try {
      dynamic response = await _apiServices.getUpdateApiResponse(
          '${ApiEndPoint.baseUrl + ApiEndPoint.orders.updateOrderStatus + param.toString()}/?status=$status');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> cancelOrder(dynamic param) async {
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          '${ApiEndPoint.baseUrl}${ApiEndPoint.orders.cancelOrder}$param/');

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
