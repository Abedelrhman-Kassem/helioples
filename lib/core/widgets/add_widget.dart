import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

Widget addWidget({
  required String text,
  required Function() onTap,
  TextStyle? style,
  double? iconWidth,
  double? iconHeight,
  Color? mainColor,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      child: Row(
        children: [
          svgIcon(
            path: 'assets/svg_icons/empty-plus.svg',
            width: iconWidth ?? 18.w,
            height: iconHeight ?? 18.h,
            color: mainColor ?? MyColors.mainColor,
          ),
          SizedBox(width: 5.w),
          Text(text, style: style ?? Styles.styles12w800MainColor),
        ],
      ),
    ),
  );
}
