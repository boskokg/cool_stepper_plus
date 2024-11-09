library round_corner_container;

import 'package:flutter/material.dart';

class RoundedCornerContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final Color outsideColor;
  final Color insideColor;
  final BorderRadius borderRadius;

  RoundedCornerContainer({
    required this.child,
    this.padding,
    this.height,
    this.width,
    this.insideColor = Colors.transparent,
    this.outsideColor = Colors.white,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(
        40.0,
      ),
      topRight: Radius.circular(
        40.0,
      ),
      bottomLeft: Radius.zero,
      bottomRight: Radius.zero,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: outsideColor,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? MediaQuery.of(context).size.height * 0.2,
          color: insideColor,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
