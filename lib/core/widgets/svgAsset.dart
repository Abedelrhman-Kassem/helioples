import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

SvgPicture svgIcon({
  required String path,
  required double width,
  required double height,
  required Color color,
}) {
  return SvgPicture.asset(
    path,
    width: width.w,
    height: height.h,
    colorFilter: ColorFilter.mode(
      color,
      BlendMode.srcIn,
    ),
  );
}
