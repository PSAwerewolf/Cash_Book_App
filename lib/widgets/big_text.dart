import 'package:flutter/cupertino.dart';

import '../utils/dimentions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow textOverflow;
  BigText(
      {super.key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 0,
      this.textOverflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 1,
      text,
      overflow: textOverflow,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: size == 0 ? Dimentions.font20 : size),
    );
  }
}
