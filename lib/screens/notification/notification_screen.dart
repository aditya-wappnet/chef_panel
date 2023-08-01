// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';

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
          appBar: AppBar(),
          body: notificationProvider.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : notificationProvider.notificationList.isEmpty
                  ? const Center(
                      child: Text("No notification"),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: LoadMore(
                            isFinish: notificationProvider
                                    .notificationList.length >=
                                notificationProvider.notification_model!.count!,
                            onLoadMore: () {
                              return notificationProvider
                                  .getMoreNotifications();
                            },
                            delegate: const DefaultLoadMoreDelegate(),
                            textBuilder: DefaultLoadMoreTextBuilder.english,
                            child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      "${notificationProvider.notificationList[index].title!} ${notificationProvider.notificationList[index].id.toString()}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    subtitle: Text(
                                      notificationProvider
                                          .notificationList[index].body!,
                                      style: TextStyle(
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount:
                                  notificationProvider.notificationList.length,
                            ),
                          ),
                        ),
                      ],
                    ),
        );
      },
    );
  }
}
