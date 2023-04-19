// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildTextFormField extends StatefulWidget {
  final Icon? leftIcon;
  final String? txtHint;
  bool isObserve = false;
  bool? readOnly = false;
  bool? enabled = true;
  bool? autofocus = false;
  final IconButton? icon;
  String? Function(String?)? validation;
  TextEditingController? controller;
  final VoidCallback? onClicked;
  TextCapitalization? textCapitalization;

  //Text Form Widget
  BuildTextFormField({
    Key? key,
    this.leftIcon,
    this.txtHint,
    required this.isObserve,
    this.icon,
    this.validation,
    this.controller,
    this.onClicked,
    this.readOnly,
    this.autofocus,
    this.enabled,
    this.textCapitalization,
  }) : super(key: key);

  @override
  State<BuildTextFormField> createState() => _BuildTextFormFieldState();
}

class _BuildTextFormFieldState extends State<BuildTextFormField> {
  bool isError = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.sp),
      child: TextFormField(
        onChanged: (value) {
          widget.validation == null;
          setState(() {
            isError = false;
          });
        },
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.words,
        enabled: widget.enabled ?? true,
        autofocus: widget.autofocus ?? false,
        validator: widget.validation,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTap: widget.onClicked,
        readOnly: widget.readOnly ?? false,
        obscureText: widget.isObserve,
        cursorColor: Colors.white,
        controller: widget.controller,
        style: GoogleFonts.roboto(
            fontSize: 28.sp, color: Colors.white, fontWeight: FontWeight.w600),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: widget.icon,
          prefixIcon: widget.leftIcon,
          contentPadding:
              EdgeInsets.only(top: 10.sp, left: 30.sp, bottom: 10.sp),
          border: InputBorder.none,
          isDense: false,
          labelText: widget.txtHint,
          errorStyle: const TextStyle(
            color: Colors.red,
            overflow: TextOverflow.ellipsis,
          ),
          labelStyle: GoogleFonts.roboto(
              fontSize: 28.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.sp),
              borderSide: BorderSide(
                  color: isError ? Colors.grey : Colors.green, width: 1.w)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.sp),
              borderSide: BorderSide(color: Colors.white, width: 1.w)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.sp),
              borderSide: BorderSide(color: Colors.orange, width: 1.w)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.sp),
              borderSide: BorderSide(color: Colors.red, width: 1.w)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.sp),
              borderSide: BorderSide(color: Colors.red, width: 1.w)),
        ),
      ),
    );
  }
}
