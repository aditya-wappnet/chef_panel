// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:chef_panel/helper/fonts/font_family.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().getAllNotification(context);
    });

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final notificationProvider = context.read<NotificationProvider>();
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (notificationProvider.hasMoreData) {
        notificationProvider.getAllNotification(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, notificationProvider, __) {
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            child: LoadMore(
              isFinish: !notificationProvider.hasMoreData,
              onLoadMore: () async {
                await notificationProvider.getAllNotification(context);
                return true;
              },
              delegate: DefaultLoadMoreDelegate(),
              textBuilder: (LoadMoreStatus status) {
                String text;
                switch (status) {
                  case LoadMoreStatus.fail:
                    text = "Failed";
                    break;
                  case LoadMoreStatus.idle:
                    text = "Wait";
                    break;
                  case LoadMoreStatus.loading:
                    text = "Loading";
                    break;
                  case LoadMoreStatus.nomore:
                    text = "";
                    break;
                  default:
                    text = "";
                }
                return text;
              },
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var notification =
                      notificationProvider.notificationList[index];
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: UniqueKey(),
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onDismissed: (direction) {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          notification.title!,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: FontFamliy.LATO_BOLD,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        subtitle: Text(
                          "",
                          style: TextStyle(
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: FontFamliy.LATO_BLACK,
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: notificationProvider.notificationList.length,
              ),
            ),
          ),
        );
      },
    );
  }
}
