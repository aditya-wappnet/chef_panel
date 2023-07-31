// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chef_panel/helper/colors/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:chef_panel/models/order_model.dart';
import 'package:chef_panel/provider/get_all_order.dart';
import 'package:chef_panel/screens/order_detail_screen/order_detail_screen.dart';

import '../../provider/log_in_provider.dart';
import '../../widgets/custom_dailog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginInProvider>(context, listen: false);
    final orderProvider = Provider.of<GetOrders>(context, listen: false);

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
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  heading: 'Logout',
                                  icon: const Icon(
                                      Icons.power_settings_new_outlined),
                                  title: 'Are you sure want to logout app ?',
                                  descriptions: "", //
                                  btn1Text: 'Logout',
                                  btn2Text: 'Cancel',
                                  onClicked: () {
                                    provider.logout(context);
                                  },
                                );
                              });
                        },
                        child: Image.asset(
                          'assets/images/ic_logout.png',
                          height: 60.h,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: StreamBuilder<List<Data>>(
                      stream: orderProvider.orderStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Data>> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return snapshot.data!.isEmpty
                            ? Center(
                                child: Text(
                                'No orders',
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: SecondaryColor.cardBackgroundColor),
                              ))
                            : ListView.builder(
                                itemCount: snapshot.data!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data![index];

                                  var cartItem =
                                      snapshot.data![index].cartItems;

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrderDetailScreen(
                                              id: data.id,
                                              orderStatus: data.orderStatus,
                                              itemList: cartItem,
                                            ),
                                          ));
                                    },
                                    child: SizedBox(
                                      height: 180.h,
                                      width: double.infinity,
                                      child: Card(
                                        elevation: 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Image.asset(
                                                      'assets/images/ic_cook_new.png',
                                                      height: 100.h),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'Table No : ${data.tableNo.toString()}',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize:
                                                                    34.sp),
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      Text(
                                                        'Order Timing  :${data.createdAt!.split("T")[1].split(".")[0]}',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize:
                                                                    34.sp),
                                                      )
                                                    ],
                                                  ),
                                                  Center(
                                                    child: Icon(
                                                      Icons.arrow_circle_right,
                                                      size: 80.sp,
                                                      color: Colors.black12,
                                                    ),
                                                  )
                                                ])
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
