import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_icon.dart';
import 'appcolors.dart';
import 'dimentions.dart';

class TextFieldWidget extends StatefulWidget {
  AppIcon preIcon;
  AppIcon? suffIcon;
  String placeHolder;
  var controller;
  var validator;
  bool obSecure;
  TextInputType? keyBoardType;

  TextFieldWidget(
      {super.key,
      required this.preIcon,
      this.suffIcon,
      required this.placeHolder,
      required this.controller,
      this.obSecure = false,
      this.validator,
      this.keyBoardType});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: Dimentions.width10, horizontal: Dimentions.height10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimentions.height20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 8,
                offset: Offset(1, 5),
                spreadRadius: 0.1,
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: TextFormField(
        obscureText: widget.obSecure,
        keyboardType: widget.keyBoardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: widget.preIcon,
          suffixIcon: widget.suffIcon,
          hintText: widget.placeHolder,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimentions.height20),
              borderSide: BorderSide(width: 1.0, color: Colors.red)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimentions.height20),
              borderSide: BorderSide(width: 1.0, color: AppColors.mainColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimentions.height20),
              borderSide: BorderSide(width: 1.0, color: Colors.white)),
        ),
      ),
    );
  }
}
