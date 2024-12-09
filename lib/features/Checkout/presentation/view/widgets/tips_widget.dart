import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

Widget tipsWidget({
  required String text,
  required void Function() onTap,
  required bool isChossen,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isChossen
                ? MyColors.mainColor
                : const Color.fromRGBO(81, 81, 81, 1),
          ),
        ),
        child: Text(
          text,
          style: Styles.styles10w300interFamily.copyWith(
            color: isChossen
                ? MyColors.mainColor
                : const Color.fromRGBO(40, 40, 40, 1),
          ),
        ),
      ),
    ),
  );
}
