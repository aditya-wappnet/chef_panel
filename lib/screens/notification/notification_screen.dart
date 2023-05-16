// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:chef_panel/helper/fonts/font_family.dart';
import 'package:chef_panel/widgets/custom_dailog.dart';
import 'package:chef_panel/widgets/shimmer_effect_notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/get_all_order.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static List getDummyList() {
    List list = List.generate(0, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    List items = NotificationScreen.getDummyList();
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.white],
            stops: [0.4, 1],
            begin: AlignmentDirectional(0, -1),
            end: AlignmentDirectional(-1, 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                                heading: "Delete",
                                title:
                                    "Are you sure you want to clear all notifications ?",
                                descriptions: "",
                                btn1Text: "Yes",
                                icon: const Icon(Icons.clear),
                                btn2Text: "No",
                                onClicked: () {
                                  Navigator.pop(context);
                                });
                          });
                    },
                    child: const Text(
                      'Delete All',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: items.isEmpty
                    ? ShimmerEffect()
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            key: Key(items[index]),
                            background: Container(
                              alignment: AlignmentDirectional.centerEnd,
                              color: Colors.red,
                              child: const Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onDismissed: (direction) {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.circular(10), //<-- SEE HERE
                              ),
                              child: ListTile(
                                  title: Text(
                                    'Order:- Samosha , Table No - 5',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: FontFamliy.LATO_BOLD,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start,
                                  ),
                                  subtitle: Text(
                                    'Time',
                                    style: TextStyle(
                                        color: const Color.fromRGBO(0, 0, 0, 1),
                                        fontFamily: FontFamliy.LATO_BLACK,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w100),
                                  )),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
