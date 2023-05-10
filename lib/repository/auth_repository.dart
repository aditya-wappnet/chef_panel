// ignore_for_file: prefer_final_fields

import 'package:chef_panel/network/base_api_services.dart';
import 'package:chef_panel/network/network_api_services.dart';
import 'package:chef_panel/services/api_end_points.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoint.login, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
