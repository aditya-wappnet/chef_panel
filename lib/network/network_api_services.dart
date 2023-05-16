import 'dart:convert';
import 'dart:io';

import 'package:chef_panel/network/base_api_services.dart';
import 'package:chef_panel/response/app_exception.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkApiService extends BaseApiServices {
  @override
  // to make HTTP requests to an API.
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      };

      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }
    return responseJson;
  }

  @override
  // to make HTTP requests to an API.
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getUpdateApiResponse(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Token $token'
      };
      print(url);
      final response = await http
          .patch(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      print(response.statusCode);
      return response;
    } on SocketException {
      throw FetchDataExceptions('No Internet Connection');
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataExceptions(
            'Error Occured While Communicating with Server');
    }
  }
}
