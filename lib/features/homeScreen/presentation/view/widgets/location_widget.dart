import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/boxshadow.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svgAsset.dart';

Widget locationWidget() {
  return FractionalTranslation(
    translation: const Offset(0, 0.5),
    child: Container(
      width: 375.w,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 49.w),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.8),
        boxShadow: [
          MyBoxShadows.locationBoxShadow,
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              svgIcon(
                path: 'assets/svg_icons/location.svg',
                width: 18,
                height: 18,
                color: MyColors.mainColor,
              ),
              Text(
                'Delivery Duration: ',
                style: Styles.styles13w300interFamily,
              ),
              Text(
                '35 min',
                style: Styles.styles13w400interFamily,
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Home, ',
                style: Styles.styles17w700interFamily,
              ),
              Text(
                'Cairo Salah Salem 12518',
                style: Styles.styles17w400interFamily,
              ),
              SizedBox(width: 4.w),
              svgIcon(
                path: 'assets/svg_icons/arrow-bottom.svg',
                width: 13,
                height: 6,
                color: const Color.fromRGBO(115, 115, 115, 1),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
