import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

Widget tipsWidget({
  required String text,
  required void Function() onTap,
  required int value,
  required int tipsValue,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: tipsValue == value
              ? const Color.fromARGB(71, 158, 158, 158)
              : null,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: const Color.fromRGBO(81, 81, 81, 1),
          ),
        ),
        child: Text(
          text,
          style: Styles.styles10w300interFamily,
        ),
      ),
    ),
  );
}
