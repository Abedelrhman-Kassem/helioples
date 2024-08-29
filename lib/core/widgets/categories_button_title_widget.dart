import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

Widget categoriesButtonTitleWidet({
  required Function() onTap,
  required title,
}) {
  return TextButton(
    onPressed: onTap,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Styles.styles16w700interFamily,
        ),
        SizedBox(width: 5.w),
        svgIcon(
          path: 'assets/svg_icons/categories_arrow.svg',
          width: 11.w,
          height: 5.5.h,
          color: MyColors.mainColor,
        ),
      ],
    ),
  );
}
