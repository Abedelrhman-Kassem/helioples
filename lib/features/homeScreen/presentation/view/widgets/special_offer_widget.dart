import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svgAsset.dart';

Widget specialOfferWidget() {
  return SizedBox(
    width: 297.w,
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
                  const Image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/screens_background/home-special-offers.png',
                    ),
                  ),
                  Container(
                    width: 190.w,
                    height: 130.h,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(0, 0, 0, 1),
                          Color.fromRGBO(0, 0, 0, 0),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12.h,
                    left: 12.w,
                    child: Container(
                      width: 93.w,
                      height: 22.h,
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
                            width: 13.74.w,
                            height: 13.74.h,
                            color: Colors.white,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            'Up to 20% off',
                            style: Styles.styles7w500interFamily,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mango Season',
                    style: Styles.styles13w700interFamily,
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Offer Ends At ',
                          style: Styles.styles9w400interFamily,
                          children: [
                            TextSpan(
                              text: '1 Day 16 Hours',
                              style: Styles.styles9w500interFamily,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 4.w),
                      svgIcon(
                        path: 'assets/svg_icons/clock.svg',
                        width: 13.5.w,
                        height: 13.5.h,
                        color: const Color.fromRGBO(50, 50, 50, 1),
                      ),
                    ],
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  text: 'Beneficiary ',
                  style: Styles.styles9w400interFamily,
                  children: [
                    TextSpan(
                      text: '33',
                      style: Styles.styles9w800interFamily,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
