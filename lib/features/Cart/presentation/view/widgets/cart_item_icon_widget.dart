import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

Widget cartItemIconWidget({
  required String svgPath,
  required void Function() onTap,
  bool isBiggerThanOne = false,
  String? minusSvgPath,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(39.55.r),
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 9.84.w,
        vertical: 6.56.h,
      ),
      width: 56.84.w,
      height: 30.61.h,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 126, 143, 0.2),
        borderRadius: BorderRadius.circular(39.55.r),
      ),
      child: svgIcon(
        path: isBiggerThanOne ? minusSvgPath ?? svgPath : svgPath,
        width: 17.49,
        height: 17.49,
        color: MyColors.mainColor,
      ),
    ),
  );
}
