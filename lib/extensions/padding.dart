import 'package:flutter/material.dart';
import 'package:get/get.dart';
extension PaddingToWidget on Widget {
  Widget addPadding(EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget addPaddingAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget addAnimatedPadding(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(
          bottom: context.mediaQueryViewInsets.bottom + 12, top: 8, right: 16, left: 16),
      duration: Duration(milliseconds: 200),
      child: this,
    );
  }

  Widget addPaddingOnly(
      {double top = 0.0,
      double bottom = 0.0,
      double left = 0.0,
      double right = 0.0}) {
    return Padding(
      padding:
          EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
      child: this,
    );
  }

  Widget addPaddingHorizontalVertical({
    double vertical = 0.0,
    double horizontal = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
            left: horizontal,
            right: horizontal,
            top: vertical,
            bottom: vertical),
        child: this,
      );

  Widget addBorderRadius(double borderRadius) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius), child: this);
  }
}
