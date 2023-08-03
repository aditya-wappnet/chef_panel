// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:chef_panel/helper/responsive.dart';
import 'package:chef_panel/widgets/placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';

import '../../helper/constant/styles.dart';
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
              "Notifications",
              style: titleTextStyle,
            ),
            actions: [
              InkWell(
                onTap: () async {
                  notificationProvider.deleteAllNotification(context);
                },
                child: notificationProvider.notificationList.isNotEmpty
                    ? Text(
                        "Clear All",
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
                    ? const Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PlaceholderWidget(title: "No notification"),
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
                                                    notificationProvider
                                                        .notificationList[index]
                                                        .id!,
                                                    context);
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
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          notificationProvider
                                              .notificationList[index].title!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        subtitle: Text(
                                          notificationProvider
                                              .notificationList[index].body!,
                                          style: const TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w100,
                                          ),
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
