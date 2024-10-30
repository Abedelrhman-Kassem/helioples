import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/button_widget.dart';

Widget exitOrderBottomSheet(BuildContext context) {
  return Wrap(
    children: [
      Container(
        // height: 200.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Column(
          children: [
            Text(
              'Exit Order',
              style: Styles.styles20w600Black,
            ),
            SizedBox(height: 10.h),
            Text(
              'Are you sure you want to exit order?',
              style: Styles.styles17w400interFamily,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25.h),
            Row(
              children: [
                Expanded(
                  child: buttonWidget(
                    color: MyColors.mainColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 20.h,
                    ),
                    borderRadius: 53.r,
                    child: Text(
                      'Exit Order',
                      style: Styles.styles17w600White,
                    ),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        homeLayout,
                        (route) => false,
                      );
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: buttonWidget(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 20.h,
                    ),
                    borderRadius: 53.r,
                    border: Border.all(
                      color: MyColors.mainColor,
                      width: 1.5.r,
                    ),
                    child: Text(
                      'Cancel',
                      style: Styles.styles17w600White.copyWith(
                        color: MyColors.mainColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
