import 'package:cash_book_app4/widgets/big_text.dart';
import 'package:flutter/material.dart';

import 'app_icon.dart';
import 'appcolors.dart';
import 'dimentions.dart';

class NumButtonWidget extends StatefulWidget {
  TextEditingController priceController;
  Color? forgroundColor;
  Color? backgroundColor;
  Widget? child;
  String numValue;
  NumButtonWidget(
      {super.key,
      this.backgroundColor,
      this.forgroundColor,
      this.child,
      required this.numValue,
      required this.priceController});

  @override
  State<NumButtonWidget> createState() => _NumButtonWidgetState();
}

class _NumButtonWidgetState extends State<NumButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (widget.priceController.text == '0') {
          widget.priceController.text = widget.numValue;
        } else if (widget.numValue == '') {
          widget.priceController.text = widget.numValue;
        } else {
          widget.priceController.text += widget.numValue;
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: widget.forgroundColor == null
            ? Colors.white
            : widget.forgroundColor,
        backgroundColor: widget.backgroundColor == null
            ? Colors.blue
            : widget.backgroundColor, // Text color
        shadowColor: Colors.black, // Shadow color
        elevation: 5, // Elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimentions.radius15),
        ),
        padding: EdgeInsets.all(Dimentions.height10),
      ),
      child: widget.child == null ? BigText(text: "0") : widget.child,
    );
  }
}
