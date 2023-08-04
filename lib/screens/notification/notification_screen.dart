// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:chef_panel/helper/responsive.dart';
import 'package:chef_panel/widgets/placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';
import '../../helper/constant/styles.dart';
import '../../helper/functions/time_format_function.dart';
import '../../provider/notification_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().getAllNotification(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, notificationProvider, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            scrolledUnderElevation: 0.0,
            automaticallyImplyLeading: false,
            title: Text(
              AppLocalizations.of(context).translate('notification'),
              style: titleTextStyle,
            ),
            actions: [
              InkWell(
                onTap: () async {
                  notificationProvider.deleteAllNotification(context);
                },
                child: notificationProvider.notificationList.isNotEmpty
                    ? Text(
                        AppLocalizations.of(context).translate('clear_all'),
                        style: textBodyStyle.copyWith(color: Colors.red),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(
                width: 20.0,
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: wp(2, context), vertical: hp(2, context)),
            child: notificationProvider.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : notificationProvider.notificationList.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PlaceholderWidget(
                              title: AppLocalizations.of(context)
                                  .translate('no_notification')),
                        ],
                      ))
                    : Column(
                        children: [
                          Expanded(
                            child: LoadMore(
                              isFinish: notificationProvider
                                      .notificationList.length >=
                                  notificationProvider
                                      .notification_model!.count!,
                              onLoadMore: () {
                                return notificationProvider
                                    .getMoreNotifications();
                              },
                              delegate: const DefaultLoadMoreDelegate(),
                              textBuilder: DefaultLoadMoreTextBuilder.english,
                              child: ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  var notification = notificationProvider
                                      .notificationList[index];
                                  return Slidable(
                                    key: UniqueKey(),
                                    closeOnScroll: true,
                                    endActionPane: ActionPane(
                                      extentRatio: 0.2,
                                      motion: const BehindMotion(),
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            notificationProvider
                                                .deleteSingleNotification(
                                                    notification.id!, context);
                                          },
                                          child: Container(
                                            height: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: wp(5, context),
                                            ),
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(12.0),
                                                  bottomRight:
                                                      Radius.circular(12.0)),
                                            ),
                                            child: const Icon(
                                                Icons.delete_outlined),
                                          ),
                                        )
                                      ],
                                    ),
                                    child: Card(
                                      elevation: 3.0,
                                      color: notification.readStatus == true
                                          ? Colors.grey.shade300
                                          : Colors.white,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.circle_notifications_outlined,
                                          size: 40,
                                          color: Colors.purple.shade200,
                                        ),
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0),
                                          child: Text(
                                            notification.title!,
                                            style: textBodyStyle,
                                          ),
                                        ),
                                        subtitle: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(notification.body!,
                                                style: textSmallRegularStyle
                                                    .copyWith(
                                                  color:
                                                      const Color(0xff848285),
                                                )),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              getTimeAgo(
                                                  notification.createdAt!),
                                              style: smallRegularStyle.copyWith(
                                                color: const Color(0xff848285),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: notificationProvider
                                    .notificationList.length,
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
        );
      },
    );
  }
}
