// ignore_for_file: prefer_final_fields, must_be_immutable

import 'package:chef_panel/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderedFoodItem {
  final String category;
  final String menuItem;
  final int quantity;

  OrderedFoodItem(
      {required this.category, required this.menuItem, required this.quantity});
}

class OrderDetailScreen extends StatelessWidget {
  OrderDetailScreen({super.key});

  List<OrderedFoodItem> _orderedFoodItems = [
    OrderedFoodItem(category: 'Appetizers', menuItem: 'Nachos', quantity: 2),
    OrderedFoodItem(
        category: 'Entrees', menuItem: 'Chicken Alfredo', quantity: 1),
    OrderedFoodItem(category: 'Drinks', menuItem: 'Soda', quantity: 3),
    OrderedFoodItem(category: 'Appetizers', menuItem: 'Nachos', quantity: 2),
    OrderedFoodItem(
        category: 'Entrees', menuItem: 'Chicken Alfredo', quantity: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(
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
                    itemCount: _orderedFoodItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      OrderedFoodItem orderedFoodItem =
                          _orderedFoodItems[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.sp, vertical: 10.sp),
                        child: Card(
                          child: ListTile(
                            leading: Image.asset('assets/images/ic_cook.png'),
                            title: Text(
                              orderedFoodItem.menuItem,
                              style: GoogleFonts.roboto(
                                  color: Colors.black, fontSize: 40.sp),
                            ),
                            subtitle: Text(
                                'Category: ${orderedFoodItem.category}, Quantity: ${orderedFoodItem.quantity}',
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
                  AppButton(
                      sizes: 30.sp,
                      height: 70.h,
                      width: 300.w,
                      text: 'Preparing'),
                  SizedBox(
                    height: 30.h,
                  ),
                  AppButton(
                      sizes: 30.sp,
                      height: 70.h,
                      width: 300.w,
                      text: 'Completed'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
