import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../app_localizations.dart';
import '../helper/helpers.dart';
import '../models/notification_model.dart';
import '../repository/notification_repository.dart';
import '../widgets/custom_flush_bar_widget.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepository _notificationRepository =
      NotificationRepository();

  List<NotificationData> notificationList = [];
  NotificationModel? notification_model;
  bool _loading = false;

  bool get loading => _loading;

  int page = 1;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // get list of notification
  getAllNotification(BuildContext context) {
    _notificationRepository.getNotification(param: "").then((response) {
      log(response.toString());
      setLoading(true);
      if (response != null) {
        if (response.statusCode == 200) {
          log("hiii");
          NotificationModel notificationModel =
              NotificationModel.fromJson(response.data);
          notification_model = notificationModel;
          if (notificationList.isNotEmpty) {
            notificationList.clear();
            page = 1;
          }
          notificationList.addAll(notificationModel.notificationData ?? []);
          notifyListeners();
          setLoading(false);
        } else {
          setLoading(false);
          CustomFlushbar.showError(context, response.data["message"],
              onDismissed: () {});
        }
      } else {
        setLoading(false);
        CustomFlushbar.showError(
            context,
            AppLocalizations.of(context)
                .translate('error_occurred_error_message'),
            onDismissed: () {});
      }
    }).catchError((error) {
      log(error.toString());
      handleDioException(context, error);
      setLoading(false);
    });
  }

  Future<bool> getMoreNotifications() async {
    if (notification_model?.next != null) {
      page++;
    }
    if (notification_model?.next == null) {
      page = 1;
    }
    notifyListeners();
    String param = notification_model?.next != null ? "?page=$page" : "";
    log("param : $param");
    setLoading(false);
    _notificationRepository.getNotification(param: param).then((response) {
      setLoading(true);
      if (response != null) {
        if (notificationList.isEmpty) setLoading(false);
        notifyListeners();
        if (response.statusCode == 200) {
          NotificationModel notificationModel =
              NotificationModel.fromJson(response.data);
          notification_model = notificationModel;
          notificationList.addAll(notification_model!.notificationData ?? []);
          notifyListeners();
          setLoading(false);
        } else {
          setLoading(false);
          notifyListeners();
        }
      } else {
        setLoading(false);
        notifyListeners();
      }
    }).catchError((error) {
      setLoading(false);
    });
    await Future.delayed(const Duration(seconds: 0, milliseconds: 3000));
    return true;
  }

  // delete notification

  deleteSingleNotification(int id, BuildContext context) {
    _notificationRepository.deleteSingleNotification(id).then((response) {
      if (response != null) {
        if (response.data["status"] == true) {
          // notificationList.removeWhere((item) => item. == id);
          CustomFlushbar.showSuccess(context, response.data["message"],
              onDismissed: () {});
          notifyListeners();
        } else if (response.data['status'] == false) {
          CustomFlushbar.showError(context, response.data["message"],
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

  // delete all notification

  deleteAllNotification(BuildContext context) {
    _notificationRepository.deleteAllNotification().then((response) {
      if (response != null) {
        if (response.data["status"] == true) {
          notificationList.clear();
          getAllNotification(context);
          CustomFlushbar.showSuccess(context, response.data["message"],
              onDismissed: () {});
          notifyListeners();
        } else if (response.data['status'] == false) {
          CustomFlushbar.showError(context, response.data["message"],
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
}
