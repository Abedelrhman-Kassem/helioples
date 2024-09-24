import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/radio_animated_widget.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';

Widget radioItem({
  required String title,
  required String iconPath,
  required int index,
  required int radioValue,
  required Function() onTap,
}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: radioValue == index
          ? const Color.fromRGBO(248, 147, 31, 0.1)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(
        width: 0.5,
        color: radioValue == index
            ? const Color.fromRGBO(248, 147, 31, 1)
            : const Color.fromRGBO(150, 150, 150, 1),
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: const Color.fromRGBO(248, 147, 31, 0.1),
        child: ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              svgIcon(
                path: 'assets/svg_icons/$iconPath.svg',
                width: 32.12.w,
                height: 32.12.h,
                color: const Color.fromRGBO(41, 41, 41, 1),
              ),
              SizedBox(width: 20.w),
              Text(
                title,
                style: Styles.styles15w400Black,
              )
            ],
          ),
          trailing: radioAnimatedWidget(radioValue == index),
        ),
      ),
    ),
  );
}
