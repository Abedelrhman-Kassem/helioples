import 'package:flutter/material.dart';

Widget buttonWidget({
  required Widget child,
  required void Function() onTap,
  double? width,
  EdgeInsets? padding,
  EdgeInsets? margin,
  Border? border,
  double? borderRadius,
  Color? color,
  Color? splashColor,
}) {
  return Container(
    margin: margin,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: splashColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            border: border,
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            color: color,
          ),
          child: child,
        ),
      ),
    ),
  );
}
