// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_final_fields, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:chef_panel/models/order_model.dart';
import 'package:chef_panel/widgets/app_button.dart';

import '../../provider/get_all_order.dart';
import '../../widgets/custom_dailog.dart';

class Item {
  dynamic itemName;
  dynamic itemPrice;
  dynamic quantity;
  dynamic total;

  Item({
    required this.itemName,
    required this.itemPrice,
    required this.quantity,
    required this.total,
  });
}

class OrderDetailScreen extends StatelessWidget {
  int? id;
  String? orderStatus;
  final List<CartItems>? itemList;
  OrderDetailScreen({
    Key? key,
    this.id,
    this.orderStatus,
    this.itemList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<GetOrders>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white, // Set the color of the icon
          ),
        ),
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
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Table No : 5',
                    style: GoogleFonts.roboto(
                        fontSize: 44.sp, color: Colors.white),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itemList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = itemList![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.sp, vertical: 10.sp),
                        child: Card(
                          child: ListTile(
                            leading: Image.asset('assets/images/ic_cook.png'),
                            title: Text(
                              item.itemName!,
                              style: GoogleFonts.roboto(
                                  color: Colors.black, fontSize: 40.sp),
                            ),
                            subtitle: Text(
                                'item price: ${item.itemPrice}, Quantity: ${item.quantity}',
                                style: GoogleFonts.roboto(
                                    color: Colors.black, fontSize: 34.sp)),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (orderStatus != "preparing")
                          GestureDetector(
                            onTap: () {
                              orderProvider.ispreparing
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogBox(
                                            heading: "Preparing",
                                            title:
                                                "Are you sure you want to update Order status to preparing ?",
                                            descriptions: "",
                                            btn1Text: "Yes",
                                            btn2Text: "Cancel",
                                            icon: const Icon(Icons.clear),
                                            onClicked: () {
                                              orderProvider.updatePreparing(
                                                  id, 'preparing', context);
                                              Navigator.pop(context);
                                            });
                                      });
                            },
                            child: AppButton(
                                sizes: 30.sp,
                                height: 70.h,
                                width: 200.w,
                                text: 'Preparing'),
                          ),
                        AppButton(
                            sizes: 30.sp,
                            height: 70.h,
                            width: 220.w,
                            text: 'Completed'),
                        AppButton(
                            sizes: 30.sp,
                            height: 70.h,
                            width: 220.w,
                            text: 'Cancel Order'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
