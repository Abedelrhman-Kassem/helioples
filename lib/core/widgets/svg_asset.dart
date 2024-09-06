import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

SvgPicture svgIcon({
  required String path,
  required double width,
  required double height,
  required Color color,
}) {
  return SvgPicture.asset(
    path,
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color,
      BlendMode.srcIn,
    ),
  );
}
