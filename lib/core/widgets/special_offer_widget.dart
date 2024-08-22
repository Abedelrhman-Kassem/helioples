import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/Helper.dart';
import 'package:negmt_heliopolis/core/widgets/overlay.dart';
import 'package:negmt_heliopolis/core/widgets/svgAsset.dart';

Widget specialOfferWidget({
  required BuildContext context,
  required String assetImagePath,
  //
  required Widget Function() upToOfferWidget,
  //
  required Widget Function() descriptionOfferWidget,
  void Function()? onTap,
  double? widgetWidth,
  String? brandImagePath,
}) {
  final TextDirection textDirection = Directionality.of(context);
  final bool isRtl = textDirection == TextDirection.rtl;

  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: widgetWidth?.w ?? MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Helper.loadNetworkImage(
                      isRtl: isRtl,
                      assetsErrorPath: assetImagePath,
                    ),
                    overlay(isRtl),
                    upToOfferWidget(),
                    if (brandImagePath is String)
                      Positioned.directional(
                        textDirection: textDirection,
                        width: 50,
                        top: 13,
                        start: 10,
                        child: Helper.loadNetworkImage(
                          isRtl: isRtl,
                          assetsErrorPath: brandImagePath,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          descriptionOfferWidget(),
        ],
      ),
    ),
  );
}

Widget upToOfferWidget({
  required BuildContext context,
  required double iconWidth,
  required double iconHeight,
  required Text text,
}) {
  final TextDirection textDirection = Directionality.of(context);
  return Positioned.directional(
    textDirection: textDirection,
    bottom: 12.h,
    start: 12.w,
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 3.74.h,
        horizontal: 12.46.w,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(247, 148, 31, 1),
        border: Border.all(
          color: Colors.white,
          width: 1.r,
        ),
        borderRadius: BorderRadius.all(Radius.circular(37.r)),
      ),
      child: Row(
        children: [
          svgIcon(
            path: 'assets/svg_icons/discount-shape.svg',
            width: iconWidth.w,
            height: iconHeight.h,
            color: Colors.white,
          ),
          SizedBox(width: 3.w),
          text,
        ],
      ),
    ),
  );
}

Widget descriptionOfferWidget({
  required Text titleText,
  required RichText offerRichText,
  required RichText beneficiaryText,
  required double iconWidth,
  required double iconHeight,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 15.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText,
            SizedBox(height: 5.h),
            Row(
              children: [
                offerRichText,
                SizedBox(width: 4.w),
                svgIcon(
                  path: 'assets/svg_icons/clock.svg',
                  width: iconWidth.w,
                  height: iconHeight.h,
                  color: const Color.fromRGBO(50, 50, 50, 1),
                ),
              ],
            ),
          ],
        ),
        beneficiaryText,
      ],
    ),
  );
}
