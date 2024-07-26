import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:validators/validators.dart';

import 'app_icon.dart';
import 'appcolors.dart';
import 'dimentions.dart';

class PasswordTextField extends StatefulWidget {
  String placeHolder;
  var controller;
  Color suffIconFalseColor;
  Color suffIconTrueColor;
  Color mainBorderColor;
  Color errorBorderColor;

  IconData suffIconTrue;
  IconData suffIconFalse;
  IconData prefIcon;

  PasswordTextField(
      {super.key,
      required this.controller,
      required this.placeHolder,
      this.suffIconFalse = Icons.close,
      this.suffIconTrue = Icons.done,
      this.suffIconFalseColor = Colors.red,
      this.suffIconTrueColor = Colors.blue,
      this.mainBorderColor = Colors.blue,
      this.errorBorderColor = Colors.red,
      this.prefIcon = Icons.add});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  void dispose() {
    super.dispose();
  }

  bool isObsecure = true;
  bool isValid = false;
  bool isTextEmpty = true;
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
        onChanged: (val) {
          setState(() {
            if (widget.controller.text == "") {
              //print("Empty");
              isValid = false;
              isTextEmpty = true;
            } else {
              isValid = true;
              isTextEmpty = false;
            }
          });
        },
        obscureText: isObsecure,
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            hintText: widget.placeHolder,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimentions.height20),
                borderSide: BorderSide(
                    width: 1.0,
                    color: isTextEmpty
                        ? widget.mainBorderColor
                        : isValid
                            ? widget.mainBorderColor
                            : widget.errorBorderColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimentions.height20),
                borderSide: BorderSide(width: 1.0, color: Colors.white)),
            prefixIcon: AppIcon(
              iconData: widget.prefIcon,
              iconColor: AppColors.mainColor,
              backgroundColor: Colors.transparent,
            ),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isObsecure = !isObsecure;
                    //print(isObsecure);
                  });
                },
                icon: AppIcon(
                  backgroundColor: Colors.transparent,
                  iconData:
                      !isObsecure ? Icons.visibility : Icons.visibility_off,
                  iconColor:
                      !isObsecure ? AppColors.mainColor : AppColors.paraColor,
                ))),
      ),
    );
  }
}
