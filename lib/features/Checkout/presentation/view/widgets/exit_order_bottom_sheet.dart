import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/button_widget.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

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
              LocaleKeys.exit_order_bottom_exit_order.tr(),
              style: Styles.styles20w600Black,
            ),
            SizedBox(height: 10.h),
            Text(
              LocaleKeys.exit_order_bottom_exit_order_confirmation.tr(),
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
                      LocaleKeys.exit_order_bottom_exit_order_button.tr(),
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
                      LocaleKeys.exit_order_bottom_cancel.tr(),
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
