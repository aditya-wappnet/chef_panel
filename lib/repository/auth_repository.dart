import 'dart:developer';

import 'package:chef_panel/network/base_api_services.dart';
import 'package:chef_panel/network/network_api_services.dart';
import 'package:chef_panel/services/api_end_points.dart';

class AuthRepository {
  BaseApiService apiServices = NetworkApiService();

  loginApi(dynamic data) async {
    try {
      dynamic response = await apiServices.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoint.login, data);
      log(response.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
