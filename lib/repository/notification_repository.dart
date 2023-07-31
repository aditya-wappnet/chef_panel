import '../network/base_api_services.dart';
import '../network/network_api_services.dart';
import '../services/api_end_points.dart';

class NotificationRepository {
  final BaseApiService _apiServices = NetworkApiService();

  getNotification({int? page}) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.notification.getNotifications);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  deleteSingleNotification(int id) async {
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          '${ApiEndPoint.baseUrl}${ApiEndPoint.notification.deleteNotifications}$id/');

      return response;
    } catch (e) {
      rethrow;
    }
  }

  deleteAllNotification() async {
    try {
      dynamic response = await _apiServices.getDeleteApiResponse(
          '${ApiEndPoint.baseUrl}${ApiEndPoint.notification.deleteNotifications}');

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
