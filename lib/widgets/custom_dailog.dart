import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialogBox extends StatefulWidget {
  final String? heading, title, descriptions, btn1Text, btn2Text;
  final Image? img;
  final Color? backgroundColor;
  final Icon? icon;
  final VoidCallback? onClicked;

  const CustomDialogBox(
      {Key? key,
      this.title,
      this.descriptions,
      this.heading,
      this.btn1Text,
      this.btn2Text,
      this.img,
      this.icon,
      this.onClicked,
      this.backgroundColor})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: 20.sp, top: 50.sp, right: 20.sp, bottom: 20.sp),
          margin: EdgeInsets.only(top: 45.sp),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.sp),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.heading ?? "",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 54.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                widget.title ?? "",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                widget.descriptions!,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 7.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.btn1Text == ""
                      ? const SizedBox()
                      : SizedBox(
                          height: 50.h,
                          width: 200.w,
                          child: ElevatedButton(
                            onPressed: () {
                              widget.onClicked!();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.sp)),
                                backgroundColor:
                                    widget.backgroundColor ?? Colors.red),
                            child: Text(
                              widget.btn1Text!,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    width: 10.w,
                  ),
                  widget.btn2Text == ""
                      ? const SizedBox()
                      : SizedBox(
                          height: 50.h,
                          width: 200.w,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.sp)),
                                backgroundColor: Colors.grey),
                            child: Text(
                              widget.btn2Text!,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
        /*  Positioned(
          top: -20,
          left: 30.sp,
          right: 30.sp,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 100.sp,
            child: CircleAvatar(
              backgroundColor: widget.backgroundColor ?? Colors.red,
              radius: 90.sp,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: widget.icon ??
                    Icon(
                      Icons.delete_forever_rounded,
                      size: 100.sp,
                    ),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
          ),
        ) */
      ],
    );
  }
}
