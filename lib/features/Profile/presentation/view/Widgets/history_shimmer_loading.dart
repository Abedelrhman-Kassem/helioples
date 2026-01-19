import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget historyShimmerLoading() {
  return Skeletonizer(
    child: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return const HistoryItemShimmer();
      },
    ),
  );
}

class HistoryItemShimmer extends StatelessWidget {
  const HistoryItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
              style: Styles.styles17w700interFamily.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(80, 80, 80, 1),
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Container(
                  width: 400.w,
                  height: 140.h,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(227, 227, 227, 1),
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                      color: const Color.fromRGBO(243, 243, 243, 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 15.h,
                        ),
                        child: Image.asset(
                          "assets/Icons_logos/history_icon.png",
                          width: 60.w,
                          height: 60.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 25.w,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "orderHistory.user ",
                                    style: Styles.styles13w300interFamily
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                    children: [
                                      TextSpan(
                                        text: LocaleKeys
                                            .comleted_order_screen_completed_order_screen_items
                                            .tr(),
                                        style: Styles.styles13w300interFamily
                                            .copyWith(
                                              color: const Color.fromRGBO(
                                                80,
                                                80,
                                                80,
                                                1,
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  LocaleKeys
                                      .comleted_order_screen_completed_order_screen_egp
                                      .tr(),
                                  style: Styles.styles17w700interFamily,
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/svg_icons/location_history.svg",
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  "orderHistory.address!",
                                  style: Styles.styles12w400interFamily
                                      .copyWith(
                                        color: const Color.fromRGBO(
                                          80,
                                          80,
                                          80,
                                          1,
                                        ),
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/Icons_logos/logos_visa.png",
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  "***521",
                                  style: Styles.styles11w700interFamily
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
