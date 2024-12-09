import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/loading_indicators.dart';

Widget shippingDetailsItem({
  required String text,
  required String iconPath,
  required bool isLoading,
  required bool isSuccess,
  required String date,
}) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(5.r),
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSuccess
              ? MyColors.mainColor
              : const Color.fromRGBO(217, 217, 217, 1),
        ),
        child: svgIcon(
          path: 'assets/svg_icons/checkmark_delivery.svg',
          width: 7.92.w,
          height: 6.34.h,
          color: const Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      SizedBox(width: 10.w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: Styles.styles16w500Black36.copyWith(
              color: isLoading
                  ? const Color.fromRGBO(36, 36, 36, 1)
                  : const Color.fromRGBO(217, 217, 217, 1),
            ),
          ),
          SizedBox(height: 5.h),
          if (isLoading) const SmoothLoadingIndicators(),
          if (isSuccess)
            Text(
              date,
              style: Styles.styles12w400intergrey121,
            ),
        ],
      ),
      const Spacer(),
      svgIcon(
        path: iconPath,
        width: 24.w,
        height: 24.h,
        color: MyColors.mainColor,
      )
    ],
  );
}
