import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language_helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/overlay.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/special_offer_model.dart';

class SpecialOfferWidget extends StatelessWidget {
  final Offer offer;
  final bool canNavigate;
  final bool isSmall;
  const SpecialOfferWidget({
    super.key,
    required this.offer,
    required this.canNavigate,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    TextDirection textDirection =
        isRtl(context) ? TextDirection.rtl : TextDirection.ltr;

    return GestureDetector(
      onTap: () {
        if (canNavigate) {
          Navigator.pushNamed(
            context,
            specialOfferItemScreen,
            arguments: offer.id,
          );
        }
      },
      child: SizedBox(
        width: double.infinity,
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
                  AspectRatio(
                    aspectRatio: isSmall ? 1 / 1 : 296 / 136,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Helper.loadNetworkImage(
                          url: offer.thumbnailImage ?? '',
                          imageHeight: double.infinity,
                          assetsErrorPath: 'assets/test_images/offers.png',
                        ),
                        overlay(),
                        if (offer.badge != null)
                          upToOfferWidget(
                            context: context,
                            upToOffer: offer.badge!,
                          ),
                        Positioned.directional(
                          textDirection: textDirection,
                          width: 60.w,
                          top: 10.h,
                          start: 10.w,
                          child: Helper.loadNetworkImage(
                            url: offer.companyImage ?? '',
                            assetsErrorPath:
                                'assets/test_images/offer-brand.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            descriptionOfferWidget(offer, isSmall),
          ],
        ),
      ),
    );
  }
}

Widget upToOfferWidget({
  required BuildContext context,
  required String upToOffer,
}) {
  final TextDirection textDirection = Directionality.of(context);
  return Positioned.directional(
    textDirection: textDirection,
    bottom: 12.h,
    start: 12.w,
    child: LayoutBuilder(
      builder: (context, constrains) {
        // double fontSizeFactor = (constrains.maxWidth / 100);
        return Container(
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
                width: 17.74.w,
                height: 17.74.h,
                color: Colors.white,
              ),
              SizedBox(width: 3.w),
              Text(
                upToOffer,
                style: Styles.styles7w500interFamily.copyWith(
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget descriptionOfferWidget(Offer offer, bool isSmall) {
  String formatDuration(String expiryDateString) {
    final expiryDate = DateTime.parse(expiryDateString);
    final now = DateTime.now();
    final difference = expiryDate.difference(now);

    if (difference.isNegative) {
      return "Expired";
    }

    final months = difference.inDays ~/ 30;
    final days = difference.inDays % 30;
    final hours = difference.inHours % 24;

    return '${months > 0 ? '$months month${months > 1 ? 's' : ''} ' : ''}'
            '${days > 0 ? '$days day${days > 1 ? 's' : ''} ' : ''}'
            '${hours > 0 ? '$hours hour${hours > 1 ? 's' : ''}' : ''}'
        .trim();
  }

  return LayoutBuilder(
    builder: (context, constrains) {
      double fontSizeFactor = (constrains.maxWidth / 100);

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
                      Text(
                        offer.name!,
                        style: Styles.styles13w700interFamily.copyWith(),
                      ),
                      if (isSmall)
                        RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: '33 ',
                            style: Styles.styles8w800interFamily,
                            children: [
                              TextSpan(
                                text: 'Offers Ordered',
                                style: Styles.styles8w500interFamily,
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: 'Offer Ends At ',
                          style: Styles.styles9w400interFamily.copyWith(
                            fontSize: isSmall ? 9.sp : (4 * fontSizeFactor).sp,
                          ),
                          children: [
                            TextSpan(
                              text: formatDuration(offer.expiresAt!),
                              style: Styles.styles12w500interFamily.copyWith(
                                fontSize: isSmall
                                    ? 8.5.sp
                                    : (3.5 * fontSizeFactor).sp,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 4.w),
                      // if (beneficiaryText == null) const Spacer(),
                      svgIcon(
                        path: 'assets/svg_icons/clock.svg',
                        width: 13.66.w,
                        height: 13.66.h,
                        color: const Color.fromRGBO(50, 50, 50, 1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!isSmall)
              RichText(
                text: TextSpan(
                  text: 'Beneficiary ',
                  style: Styles.styles9w400interFamily.copyWith(
                    fontSize: 12.sp,
                  ),
                  children: [
                    TextSpan(
                      text: '${offer.visits}',
                      style: Styles.styles9w800interFamily.copyWith(
                        fontSize: 12.sp,
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      );
    },
  );
}
