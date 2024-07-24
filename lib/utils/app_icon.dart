import 'package:flutter/cupertino.dart';

class AppIcon extends StatelessWidget {
  final IconData iconData;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  const AppIcon(
      {super.key,
      required this.iconData,
      this.backgroundColor = const Color(0xFFfcf4e4),
      this.iconColor = const Color(0xFF756d54),
      this.size = 40,
      this.iconSize = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor,
        ),
        child: Icon(iconData, size: iconSize, color: iconColor));
  }
}
