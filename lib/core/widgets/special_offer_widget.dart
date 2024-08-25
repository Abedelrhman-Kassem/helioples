import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/Helper.dart';
import 'package:negmt_heliopolis/core/widgets/overlay.dart';
import 'package:negmt_heliopolis/core/widgets/svgAsset.dart';

Widget specialOfferWidget({
  required BuildContext context,
  required String assetImagePath,
  required Widget Function() upToOfferWidget,
  required Widget Function() descriptionOfferWidget,
  void Function()? onTap,
  double? widgetWidth,
  double? imageHeight,
  String? brandImagePath,
  String mainUrlImage = '',
  String secondaryUrlImage = '',
}) {
  final TextDirection textDirection = Directionality.of(context);
  final bool isRtl = textDirection == TextDirection.rtl;

  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: widgetWidth ?? MediaQuery.of(context).size.width,
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
                      url: mainUrlImage,
                      imageHeight: imageHeight,
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
                          url: secondaryUrlImage,
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
            width: iconWidth,
            height: iconHeight,
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
  RichText? beneficiaryText,
  RichText? offerOrderedText,
  required double iconWidth,
  required double iconHeight,
}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 5.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleText,
                  if (offerOrderedText != null) offerOrderedText,
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  offerRichText,
                  SizedBox(width: 4.w),
                  if (beneficiaryText == null) const Spacer(),
                  svgIcon(
                    path: 'assets/svg_icons/clock.svg',
                    width: iconWidth,
                    height: iconHeight,
                    color: const Color.fromRGBO(50, 50, 50, 1),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (beneficiaryText != null) beneficiaryText,
      ],
    ),
  );
}
