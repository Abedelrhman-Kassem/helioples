import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svgAsset.dart';


class CartContainer extends StatelessWidget {
  final String svgIconPath;
  final String buttonText;
  final String productsCount;
  final String totalAmount;
  
  const CartContainer({
    super.key,
    required this.svgIconPath,
    required this.buttonText,
    required this.productsCount,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 42.w),
      child: Container(
        height: 64.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: MyColors.mainColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3.sp,
              blurRadius: 5.sp,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              svgIcon(path: svgIconPath, width: 35, height: 35, color: Colors.white),
              SizedBox(width: 8.w),
              Text(
                buttonText,
                style: Styles.styles12w500Black.copyWith(color: Colors.white),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '$productsCount ',
                      style: Styles.styles12w500Black.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                    TextSpan(
                      text: 'products',
                      style: Styles.styles12w400black.copyWith(color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.w),
              VerticalDivider(
                color: Colors.white,
                thickness: 2.sp,
                indent: 20.h,
                endIndent: 20.h,
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '$totalAmount ',
                      style: Styles.styles12w500Black.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                    TextSpan(
                      text: 'EGP',
                      style: Styles.styles12w400black.copyWith(color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
