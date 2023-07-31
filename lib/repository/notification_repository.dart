import '../network/base_api_services.dart';
import '../network/network_api_services.dart';
import '../services/api_end_points.dart';

class NotificationRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getNotification() async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.notification.getNotifications);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteNotification(
    dynamic param,
  ) async {
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          '${ApiEndPoint.baseUrl}${ApiEndPoint.notification.deleteNotifications}$param/');

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
