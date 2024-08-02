import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final TextStyle textStyle;
  final Duration duration;
  final SnackBarAction? action;

  const CustomSnackbar({
    Key? key,
    required this.message,
    this.backgroundColor = Colors.white,
    this.textStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      fontFamily: 'Roboto',
    ),
    this.duration = const Duration(seconds: 3),
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textStyle,
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
      ),
    );
  }
}
