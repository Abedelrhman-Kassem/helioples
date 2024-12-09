import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

SvgPicture svgIcon({
  required String path,
  required double width,
  required double height,
  Color? color,
}) {
  return SvgPicture.asset(
    path,
    width: width,
    height: height,
    colorFilter: color == null
        ? null
        : ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
  );
}
