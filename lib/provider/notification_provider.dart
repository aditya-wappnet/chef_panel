import 'package:flutter/cupertino.dart';

import '../helper/helpers.dart';
import '../models/notification_model.dart';
import '../repository/notification_repository.dart';
import '../widgets/custom_flush_bar_widget.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationRepository notificationRepository = NotificationRepository();

  List<Results> notificationList = [];

  bool _loading = false;

  bool get loading => _loading;

  int _currentPage = 1;
  int _totalCount = 0;
  bool _hasMoreData = true;

  bool get hasMoreData => _hasMoreData;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // get list of notification

  // get list of notification
  getAllNotification(BuildContext context) {
    if (!_hasMoreData) return; // Return if there is no more data to fetch
    setLoading(true);
    notificationRepository.getNotification(page: _currentPage).then((response) {
      setLoading(false);
      if (response != null) {
        if (response.statusCode == 200) {
          NotificationModel notificationModel =
              NotificationModel.fromJson(response.data);
          if (_currentPage == 1) {
            // If it's the first page, replace the data
            notificationList = notificationModel.results!;
            _totalCount = notificationModel.count!;
          } else {
            // If it's not the first page, append the data
            notificationList.addAll(notificationModel.results!);
          }

          // Update pagination variables
          if (notificationList.length >= _totalCount) {
            _hasMoreData = false;
          } else {
            _currentPage++;
          }

          notifyListeners();
        } else {
          CustomFlushbar.showError(context, response.data["message"],
              onDismissed: () {});
        }
      } else {
        // CustomFlushbar.showError(
        //     context,
        //     AppLocalizations.of(context)
        //         .translate('error_occurred_error_message'),
        //     onDismissed: () {});
      }
    }).catchError((error) {
      handleDioException(context, error);
    });
  }

  // delete notification

  deleteSingleNotification(int id, BuildContext context) {
    notificationRepository.deleteSingleNotification(id).then((response) {
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
        // CustomFlushbar.showError(
        //     context,
        //     AppLocalizations.of(context)
        //         .translate('error_occurred_error_message'),
        //     onDismissed: () {});
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }

  // delete all notification

  deleteAllNotification(BuildContext context) {
    notificationRepository.deleteAllNotification().then((response) {
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
        // CustomFlushbar.showError(
        //     context,
        //     AppLocalizations.of(context)
        //         .translate('error_occurred_error_message'),
        //     onDismissed: () {});
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }
}
