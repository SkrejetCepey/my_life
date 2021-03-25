import 'package:flutter/material.dart';

class ShadowIcon extends StatelessWidget {

  final IconData iconData;
  final Color shadowColor;
  final Color iconColor;
  final double size;

  ShadowIcon({this.iconData, this.shadowColor = Colors.black54, this.iconColor = Colors.white, this.size = 30.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 1.0,
          top: 2.0,
          child: Icon(iconData, color: shadowColor, size: size),
        ),
        Icon(iconData, color: iconColor, size: size)
      ],
    );
  }
}